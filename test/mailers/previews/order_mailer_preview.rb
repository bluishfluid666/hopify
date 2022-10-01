# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3001/rails/mailers/order_mailer/order_notice
  def order_notice
    user = User.second
    OrderMailer.order_notice(user)
  end

  # Preview this email at http://localhost:3001/rails/mailers/order_mailer/shop_order
  def shop_order
    user = User.second
    shop = Shop.first
    OrderMailer.shop_order(user, shop)
  end

  # Preview this email at http://localhost:3001/rails/mailers/order_mailer/password_reset
  def password_reset
    OrderMailer.password_reset
  end
end
