class MembershipsController < ApplicationController

  def create
    band = Band.find(params[:band_id])
    member = User.find_by(username: params[:member_username])
    unless band.members.include?(@logged_in_user) || (band.manager == @logged_in_user)
      reject_auth
    end

    if !!member && band.members.include?(member)
      add_error_message("Already a member.")
    elsif !!member
      @membership = Membership.new(member_id: member.id, band_id: band.id)
      if @membership.save
        flash[:success] = "#{member.name} added!"
        flash[:errors] = @membership.errors.full_messages
      end
    else
      add_error_message("Invalid User")
    end
    redirect_to band_path(band)
  end

  def destroy
    membership = Membership.find(params[:id])
    band = membership.band
    membership.destroy
    redirect_to band_path(band)
  end

  private
end
