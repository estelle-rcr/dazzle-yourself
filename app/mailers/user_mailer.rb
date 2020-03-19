class UserMailer < ApplicationMailer
  default from: 'no-reply@dazzleyourself.fr'

  def welcome_email(user)

    @user = user
    @profile = "https://dazzle-yourself.herokuapp.com/users/#{@user.id}"
    mail(to: @user.email, subject: 'Bienvenue dans la communauté Dazzle Yourself !') 
  end

  def confirmation_charge_email(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: "Ton paiement pour le projet #{@project.title} est confirmé") 
  end

  def confirmation_participation_email(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: "Ton inscription au projet #{@project.title} est confirmée") 
  end

  def reminder_participation

  end

end
