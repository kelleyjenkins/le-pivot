class ChargesController < ApplicationController

  def create
  order = Order.find(params[:order_id])

  # Amount in cents
  @amount = (order.order_total(order) * 100).to_i

  if !current_user.stripe_id
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    current_user.update!(stripe_id: customer.id, stripe_token: params[:stripeToken])
  end

    charge = Stripe::Charge.create(
      :customer    => current_user.stripe_id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )



  order.paid!

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
