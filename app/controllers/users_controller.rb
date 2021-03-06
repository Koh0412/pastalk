class UsersController < ApplicationController
    before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :login_user, only: [:new, :create]
    before_action :correct_user, only: [:edit, :update, :destroy, :followings, :followers]
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
            redirect_to @user
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
        @users = if !params[:search].blank?
            User.user_search(params[:search]).page(params[:page]).per(20)
        else
            User.user_search(params[:search])
        end
    end
    
    def tag_search
        @tags = if !params[:tag_search].blank?
            User.tag_search(params[:tag_search]).page(params[:page]).per(20).group_by { |key, val| key.user }
        else
            User.tag_search(params[:tag_search])
        end
        
        # @tag_group = @tags.group_by { |key, val| key.user.name }
    end
    
    def followings
        @followings = @user.followings.page(params[:page])
    end
    
    def followers
        @followers = @user.followers.page(params[:page])
    end
    
    def receive_talk
        # send_ids = current_user.messages.where(receive_user_id: @user.id).pluck(:id)
        # receive_ids = @user.messages.where(receive_user_id: current_user.id).pluck(:id)
        
        @receive_messages = current_user.reverces_of_message.order(created_at: :desc).page(params[:page]).per(50)
    end
    
    def user_talk
        @user_messages = current_user.messages.order(created_at: :desc).page(params[:page]).per(50)
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def correct_user
        set_user
        unless @user == current_user
            redirect_back(fallback_location: user_path(current_user))
        end
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :comment, :password, :password_confirmation)
    end
end
