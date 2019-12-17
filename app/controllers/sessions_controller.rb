class SessionsController < ApplicationController
    skip_before_action :authorize
    def create
        puts "*******params*******"
        p params
        puts "*******params*******"
        puts params
        @user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
        puts "*******params*******"
        puts params
        puts "*******user*******"
        p @user
        if @user
            session["user_id"] = @user.id
            redirect_to "/groups"
        else
            flash[:notice] = ["invalid combination"]
            redirect_to "/"
        end
    end
    
    def destroy
        reset_session
        redirect_to "/"
    end
end
