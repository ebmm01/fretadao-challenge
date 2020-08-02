class UsersController < ApplicationController
    def index
        @users = User.all

        render json: @users
    end

    def create
        @user = User.new(user_params)

        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def rescrapper
        @user = User.find(params[:id])
        localuser =  User.get_github_user_data(url = @user.url)
        @user.update_attributes(localuser)
    end

    private 

        def user_params
            params.require(:user).permit(:name, :url)
        end 
end
