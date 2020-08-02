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
        localuser =  User.get_github_user_data(url = user_by_id.url)
        user_by_id.update_attributes(localuser)
    end

    def search
        @user = User.fulltext_search(params[:text])
        render json: @user, status: :created
    end

    def show
        if user_by_id
            render json: user_by_id, status: :ok
        else
            render json: @user.errors, status: :not_found 
        end
    end
    
    private 

        def user_params
            params.require(:user).permit(:name, :url)
        end 

        def user_by_id
            User.find(params[:id])
        end
end
