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
    mail(to: @user.email, subject: "Ton paiement pour le projet '#{@project.title}' est confirmé") 
  end

  def confirmation_participation_email(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: "Ton inscription au projet '#{@project.title}' est confirmée") 
  end

    def new_participation_email(project, user, attendee)
    @project = project
    @user = user
    @attendee = attendee
    mail(to: @user.email, subject: "Une nouvelle inscription à ton projet '#{@project.title}'") 
  end

  def project_published_email(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: "Ton projet '#{@project.title}' est en ligne !") 
  end

  def reminder_participation_email(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: "Le projet '#{@project.title}' démarre dans 72 heures !") 
  end

end
