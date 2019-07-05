class UsersController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def index
        @users = User.order(id: :desc).page(params[:page])
    end
    
    def show
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            flash[:success] = "ユーザーを登録しました"
            redirect_to root_url
        else
            flash.now[:danger] = "ユーザー登録に失敗しました"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "プロフィールを更新しました"
            redirect_to @user
        else
            flash.now[:danger] = "プロフィールの更新に失敗しました"
            render :edit
        end
    end
    
    def destroy
        @user.destroy
        
        flash[:success] = "アカウントが削除されました"
        redirect_to root_url
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :comment, :password, :password_confirmation)
    end
end
