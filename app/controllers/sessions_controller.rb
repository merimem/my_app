class SessionsController < ApplicationController

def new
end

def create
	user = User.find_by(email: params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
		session[:user_id] = user.id 
		#enregistrer au hash de la session
		flash[:success]="Vous êtes connecté avec succès"
		redirect_to user_path(user)
	else 
		flash.now[:danger]= "Erreur d'authentification" 
		#afficher ce message juste pour la page actuelle
		render 'new'
	end
end

def destroy
	session[:user_id] = nil
	flash[:success] = "Vous avez été déconnecté"
	redirect_to root_path
end

end