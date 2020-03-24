class AttendancesController < ApplicationController
before_action :project_published
before_action :authenticate_user!

  def new
    @project = Project.find(params[:project_id])
    @amount = @project.package.price_attendee
  end

    def create
    @project = Project.find(params[:project_id])
    @amount = @project.package.price_attendee

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

    @attendance = Attendance.create(project: @project, attendee: current_user, stripe_customer_id: customer.id, state: "paid", price_attendee: @amount)
    redirect_to new_user_skill_setup_path(@user.id)
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
  end

  private

  def project_published
    @project = Project.find(params[:project_id])
    unless @project.state == "published"
      flash[:error] ="Vous n'êtes pas autorisé à consulter cette page"
      redirect_to root_path
    end

  end

end
