class UsersController < ApplicationController
    before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :login_user, only: [:new, :create]
    before_action :correct_user, only: [:edit, :update, :destroy, :followings]
    before_action :set_user, only: [:show]
    
    def index
        @users = User.order(id: :desc).page(params[:page])
    end
    
    def show
        @tags = @user.tags.order(id: :desc)
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
    
    def search
        @users = if params[:search]
            User.user_search(params[:search]).page(params[:page]).per(20)
        else
            User.user_search(params[:search])
        end
    end
    
    def followings
        @followings = @user.followings.page(params[:page])
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def correct_user
        set_user
        unless @user == current_user
            redirect_back(fallback_location: root_path)
        end
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :comment, :password, :password_confirmation)
    end
end
