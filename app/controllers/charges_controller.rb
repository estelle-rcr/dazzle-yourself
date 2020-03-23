class ChargesController < ApplicationController
  before_action :my_project
  
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

    @charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: "Paiement de l'inscription",
      currency: 'eur',
    })

    @project.pay!


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def my_project
    @project = Project.find(params[:project_id])
    unless current_user == @project.owner
      flash[:error] ="Vous n'êtes pas autorisé à consulter cette page"
      redirect_to root_path
    end
  end
end
