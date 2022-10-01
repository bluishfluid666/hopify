# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc).page(params[:page])
  end

  def create
    # debugger
    bugged = false
    outofstock = false
    bugged_stock = 0
    @order = current_user.orders.build
    @order.total = params[:total].to_f
    cart_items = params[:product_stock_ids]
    quantities = params[:quantity]
    subtotals = params[:subtotal]
    shops = params[:shops]
    if @order.save
      cart_items.length.times.each do |t|
        prod_stock = ProductStock.find(cart_items[t]).stock
        if prod_stock < quantities[t].to_i
          bugged = true
          outofstock = true if prod_stock.zero?
          bugged_stock = cart_items[t]
          break
        else
          @order_item = @order.order_items.create!(
            product_stock_id: cart_items[t].to_i,
            quantity: quantities[t].to_i,
            shop_id: shops[t].to_i,
            subtotal: subtotals[t].to_f
          )
          @order_item.product_stock.stock -= @order_item.quantity
        end
      end
      # binding.pry
    end
    if bugged
      stock = ProductStock.find(bugged_stock)
      name = stock.product.name
      color = stock.color
      size = ApparelSize.find(stock.apparel_size_id).title
      @order.destroy
      error_msg = "#{name} #{color} #{size}'s demand quantity is invalid. Lower it down"
      error_msg = "#{name} #{color} #{size}'s out of stock!" if outofstock
      flash[:danger] = error_msg
      redirect_to cart_items_path
    else
      current_cart.destroy
      OrderMailer.order_notice(current_user).deliver_now
      shops.uniq.each do |shid|
        OrderMailer.shop_order(current_user, Shop.find(shid)).deliver_now
      end
      flash[:success] = 'Order created successfully!'
      redirect_to orders_path, status: :see_other
    end
  end
end
