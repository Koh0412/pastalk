class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_user, only: [:index, :create]
  
  def index
    send_ids = current_user.messages.where(receive_user_id: @user.id).pluck(:id)
    receive_ids = @user.messages.where(receive_user_id: current_user.id).pluck(:id)
    
    @messages = Message.where(id: send_ids + receive_ids).order(created_at: :desc)
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.receive_user_id = @user.id
    
    if @message.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def message_params
    params.require(:message).permit(:content)
  end
end
