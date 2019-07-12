class GroupmessagesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @group = Group.find(params[:id])
    @group_message = current_user.groupmessages.build(groupmessage_params)
    @group_message.group_id = @group.id
    
    if @group_message.save
      redirect_to @group
    else
      redirect_back(fallback_location: group_url)

    end
  end

  def destroy
    @group_message = current_user.groupmessages.find_by(id: params[:id])
    @group_message.destroy
    redirect_back(fallback_location: groups_url)
  end
  
  private
  
  def groupmessage_params
    params.require(:groupmessage).permit(:body, :group_id)
  end

end
