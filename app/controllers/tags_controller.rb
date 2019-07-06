class TagsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user_tag, only: [:edit, :update, :destroy]
  before_action :set_tag, only: [:edit, :update, :destroy]
  
  def new
    @tag = current_user.tags.new
  end
  
  def edit
  end
  
  def create
    @tag = current_user.tags.build(tag_params)
    
    if @tag.save
      flash[:success] = "タグのセットが完了しました"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "タグのセットは行っていません"
      render :index
    end
  end
  
  def update
    if @tag.update(tag_params)
      flash[:success] = "タグが更新されました"
      redirect_to @tag.user
    else
      flash[:danger] = "タグの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @tag.destroy
    flash[:success] = "タグを削除しました"
    redirect_to @tag.user
  end
  
  
  private
  
  def tag_params
    params.require(:tag).permit(:name)
  end
  
  def set_tag
    @tag = current_user.tags.find_by(id: params[:id])
  end
  
  def correct_user_tag
    set_tag
    
    unless @tag
      redirect_back(fallback_location: root_path)
    end
  end
  
end
