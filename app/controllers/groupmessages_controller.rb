class GroupmessagesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @group = Group.find(params[:id])
    # @group_message = current_user.send_groupmessage(@group)
    @group_message = current_user.groupmessages.build(groupmessage_params)
    @group_message.group_id = @group.id
    if @group_message.save
      # flash[:success] = "メッセージが投稿されました"
      redirect_to @group
    else
      # flash[:danger] = "投稿失敗しました"
      redirect_back(fallback_location: group_url)

    end
  end

  def destroy
  end
  
  private
  
  def groupmessage_params
    params.require(:groupmessage).permit(:body, :group_id)
  end
end
