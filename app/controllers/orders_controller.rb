class OrdersController < ApplicationController
  
  def index
    @orders = current_user.orders
  end


  def create
    # debugger
    @order = current_user.orders.build
    @order.total = params[:total].to_f
    cart_items = params[:product_stock_ids]
    quantities = params[:quantity]
    subtotals = params[:subtotal]
    shops = params[:shops]
    if @order.save
      cart_items.length.times.each do |t|
        @order_item = @order.order_items.create!(
          product_stock_id: cart_items[t].to_i, 
          quantity: quantities[t].to_i,
          shop_id: shops[t].to_i,
          subtotal: subtotals[t].to_f
        )
        @order_item.product_stock.stock -= @order_item.quantity
      end
      current_user.cart_session.destroy
      OrderMailer.order_notice(current_user).deliver_now
      
      flash[:success] = "Order created successfully!"
      redirect_to orders_path, status: :see_other
    else
      render 'cart_items/index', status: :unprocessable_entity
    end
  end

end
