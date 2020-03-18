class ChargesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @amount = @project.package.price_owner
  end

  def create
    @project = Project.find(params[:project_id])
    @amount = @project.package.price_owner

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: "Paiement de l'inscription",
      currency: 'eur',
    })

    @project.update(state: "paid")


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
