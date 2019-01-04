class ConversationsController < ApplicationController
  before_action :require_logged_in, only: [:index, :create]

  def index
    @users = @logged_in_user.friends
    # @users = User.all
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", @logged_in_user.id, @logged_in_user.id)
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).empty?
      Conversation.create(conversation_params)
    end
    redirect_to conversation_messages_path(Conversation.between(params[:sender_id], params[:receiver_id]).first.id)
  end

  private

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
