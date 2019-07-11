class ConnectsController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    current_user.have_connect(group)
    flash[:success] = "グループのメンバーになりました"
    redirect_to group
  end

  def destroy
    group = Group.find(params[:id])
    current_user.delete_connect(group)
    flash[:success] = "グループを退会しました"
    redirect_to groups_url
  end
end
