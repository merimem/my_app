class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	#@user = User.find(params[:id])
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy]
	def new
		@user = User.new
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Bienvenue au blog de tourisme #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		
		if @user.update(user_params)
			flash[:success] = "Votre compte a été édité avec succés"
			redirect_to articles_path
		else
			render 'edit'
		end
	
	end

	def show
		
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "L'utilisateur et tous ses articles ont été supprimés"
		redirect_to users_path	
	end


end

private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:danger] = "Vous ne pouvez modifier que votre propre compte"
			redirect_to root_path
		end
	end

	def require_admin
		if logged_in? && !current_user.admin?
			flash[:danger]="Vous n'etes pas un admin"
			redirect_to root_path
		end
	end
	
