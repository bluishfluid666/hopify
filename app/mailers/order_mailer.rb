class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_notice.subject
  #
  def order_notice(user)
    @user = user
    @order = @user.orders.last
    mail to: user.email, subject: "SUCCESS: Order #{@order.id}"
  end

  def shop_order(user, shop)
    @shop = shop
    @user = user
    @order_items = @user.orders.last.order_items.where("shop_id = ?", @shop.id)
    mail to: shop.user.email, subject: "New order from #{@user.name}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
