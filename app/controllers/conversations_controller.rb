class ConversationsController < ApplicationController
  before_action :require_logged_in, only: [:index, :create]

  def index
    if !@logged_in_user.friends.empty?
      @users = @logged_in_user.friends
      @message = "Select Friend"
    else
      @users = User.all.select do |user|
        (!user.managed_bands.empty?) && user != @logged_in_user
      end
      @message = "No friends yet. Ask a band manager to join a band!"
    end
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
