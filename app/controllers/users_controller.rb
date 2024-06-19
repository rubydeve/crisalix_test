class UsersController < ApplicationController

    before_action :check_user, except: [:logout]

    def login
    end 

    def user_login
        @user = User.find_by_email(params[:user][:email])
        if !@user.blank?
            if @user.valid_password?(params[:user][:password]) 
                sign_in @user
                redirect_to dashboard_url
            else
                flash[:error] = 'Invalid Credentials.'
                render :login
            end
        else
            flash[:error] = 'Invalid Email.'
            render :login
        end
    end

    def register 
        @user = User.new
    end

    def user_register 
        @already = User.find_by_email(params[:user][:email])
        @user = User.new(param_user)
        if @already.blank?
            if @user.save
                redirect_to login_path
            else
                flash[:error] = "#{@user.errors.full_messages.to_sentence}" 
                render :register
            end
        else
            flash[:error] = 'User Already Exist.'
            render :register
        end
    end

    def logout
        sign_out current_user if check_user
    end

    private 

    def param_user
        params.require(:user).permit(:role, :name, :address, :email, :password)
    end

    def check_user
        # if user already login
        redirect_to root_url if current_user
    end
end
