class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update]
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

	def index
		@users = User.paginate(page:params[:page], per_page: 10)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.account_activation(@user).deliver_now
			flash[:info] = "Please check your email to activate your account."
			redirect_to root_url
		else
			render :new
		end
	end

	def show
		@user = User.find_by id: params[:id]
		@microposts = @user.microposts.paginate(page: params[:page] , per_page: 10)
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		if @user.update(user_params)
			flash[:success] = "update success"
			redirect_to @user
		else
			render "edit"
		end
	end

	def destroy
		user = User.find_by(id: params[:id])
		if user&.destroy
			flash[:success] = "User deleted"
		else
			flash[:danger] = "Delete fail!"
		end
		redirect_to users_url
	end

	def feed
 		microposts
 	end

 	def following
 		@title = "Following"
 		@user = User.find_by(id: params[:id])
 		@users = @user.following
 		.paginate(page: params[:page])
 		render "show_follow"
 	end

 	def followers
 		@title = "Followers"
 		@user = User.find_by(id: params[:id])
 		@users = @user.followers
 		.paginate(page: params[:page])
 		render "show_follow"
 	end

	private
	def user_params
		params.require(:user).permit :name, :email, :password, :password_confirmation
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find_by(id: params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
end

