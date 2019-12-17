class UsersController < ApplicationController
  skip_before_action :authorize, only: [:index, :create]
  def index
  end
  def create
    @user = User.new(user_params)
    if @user.valid?
      p @user
      puts "*******user successfully created*******"
      @user.save
      session["user_id"] = @user.id
      puts "*******session id*******"
      puts session["user_id"]
      redirect_to "/groups"
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to "/"
    end
  end
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
