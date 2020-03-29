class AttendancesController < ApplicationController

  before_action :project_published
  before_action :authenticate_user!
  before_action :project_full
  before_action :available
  before_action :add_skill, only: [:new]

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

    @attendance = Attendance.create(project: @project, attendee: current_user, stripe_customer_id: customer.id, price_attendee: @amount)
    @attendance.pay!

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

  def project_full
    @project = Project.find(params[:project_id])
    unless !@project.full?
      flash[:error] ="Ce projet est complet"
      redirect_back(fallback_location: root_path)
    end
  end

  def available
  @project = Project.find(params[:project_id])
  unless current_user.is_available?(@project)
      flash[:error] ="Vous êtes déjà inscrit à un projet sur ces dates"
      redirect_back(fallback_location: root_path)
    end
  end

  def add_skill
    @project = Project.find(params[:project_id])
    unless current_user.skills[0]
    flash[:alert] = "Vous devez renseigner une compétence principale pour vous inscrire à un projet."
    redirect_to new_user_skill_setup_path(current_user.id)
    end
  end

end
