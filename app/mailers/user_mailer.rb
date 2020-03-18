class UserMailer < ApplicationMailer
    default from: 'no-reply@dazzleyourself.fr'
 
    def welcome_email(user)
      @user = user 
      @url  = 'https://dazzle-yourself.herokuapp.com/users/sign_in' 
      mail(to: @user.email, subject: 'Bienvenue sur le site Dazzle Yourself !') 
    end
end
