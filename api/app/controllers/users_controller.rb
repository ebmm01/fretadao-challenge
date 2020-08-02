class UsersController < ApplicationController
    before_action :user_by_id, only: [:rescrapper, :show, :update, :destroy]

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
        localuser =  User.get_github_user_data(url = @user.url)
        @user.update_attributes(localuser)
    end

    def search
        @user = User.full_text_search(params[:text])
        render json: @user, status: :created
    end

    def show
        if @user
            render json: @user, status: :ok
        else
            render json: @user.errors, status: :not_found 
        end
    end

    def update
        if @user.update(user_params)
            if user_params["url"]
                rescrapper
            end
            render json: @user
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
    end
    
    private 

        def user_params
            params.require(:user).permit(:name, :url)
        end 

        def user_by_id
            @user = User.find(params[:id] || params[:user_id])
        end
end
