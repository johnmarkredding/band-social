class MessagesController < ApplicationController
  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end
  def create
    message = Message.new(message_params)
    message.user = @logged_in_user
    if !message.save
      flash[:errors] = message.errors.full_messages
    end
    redirect_to conversation_messages_path(params[:conversation_id])
  end

  private

  def message_params
    params.permit(:conversation_id, :body, :user_id)
  end
end
