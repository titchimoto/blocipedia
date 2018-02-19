class ChargesController < ApplicationController


  def new
    @amount = 15_00

  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Blocipedia Premium Membership - #{current_user.email}",
    amount: @amount
  }
end

  def create
    @amount = 15_00

    customer = Stripe::Customer.create(email: current_user.email, card: params[:stripeToken])

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for signing up for Blocipedia Premium, #{current_user.email}!"
    current_user.premium!
    redirect_to wikis_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path

  end


end
