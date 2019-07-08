class GroupsController < ApplicationController
    before_action :correct_user_group, only: [:edit, :update, :destroy]
    before_action :set_group, only: [:show]
    
    def index
    #   @users = User.all.page(params[:page])
        @groups = Group.order(id: :desc).page(params[:page])
    end
    
    def show
        @users = User.all
    end
    
    def new
        @group = current_user.groups.new
    end
    
    def create
        @group = current_user.groups.build(group_params)
        
        if @group.save
            flash[:success] = "グループが作成されました"
            redirect_to groups_path
        else
            flash.now[:danger] = "グループの作成ができませんでした"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @group.update(group_params)
            flash[:success] = "グループ設定が更新されました"
            redirect_to @group
        else
            flash[:danger] = "グループ設定の更新に失敗しました"
            render :edit
        end
    end
    
    def destroy
        @group.destroy
        flash[:success] = "グループが削除されました"
        
        redirect_to groups_path
    end
    
    def search
        
    end
    
    private
    
    def group_params
        params.require(:group).permit(:name, :content)
    end
    
    def set_group
        @group = Group.find(params[:id])
    end
    
    def correct_user_group
        @group = current_user.groups.find_by(id: params[:id])
        
        unless @group
            redirect_back(fallback_location: groups_path)
        end
    end
    
end
