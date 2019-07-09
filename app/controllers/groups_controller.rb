class GroupsController < ApplicationController
    before_action :require_user_logged_in
    before_action :host_user, only: [:edit, :update, :destroy]
    before_action :set_group, only: [:show, :connect, :details]
    
    def index
    #   @users = User.all.page(params[:page])
        @groups = current_user.connectings.page(params[:page])
    end
    
    def show
        if !current_user.connecting?(@group)
            redirect_back(fallback_location: groups_url)
        end
        @users = User.all
        group_counts(@group)
    end
    
    def new
        @group = current_user.groups.new
    end
    
    def create
        @group = current_user.groups.build(group_params)
        
        if @group.save
            @group.user.have_connect(@group)
            flash[:success] = "グループが作成されました"
            redirect_to groups_url
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
        
        redirect_to groups_url
    end
    
    def search
        @groups = if !params[:search].blank?
            Group.group_search(params[:search]).page(params[:page]).per(30)
        else
            Group.group_search(params[:search])
        end
    end
    
    def connect
        @users = @group.connected.page(params[:page])
        
        if !current_user.connecting?(@group)
            redirect_back(fallback_location: groups_url)
        end
    end
    
    def details
        group_counts(@group)
    end
    
    private
    
    def group_params
        params.require(:group).permit(:name, :content)
    end
    
    def set_group
        @group = Group.find(params[:id])
    end
    
    def host_user
        @group = current_user.groups.find_by(id: params[:id])
        
        unless @group
            redirect_back(fallback_location: groups_url)
        end
    end
    
end
