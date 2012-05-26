class InvitationsController < ApplicationController

  before_filter :signed_in_user
  before_filter :facebook_user
  #zmienic new na create w fbuser.html i sprawdzić jak się zachowuje z facebook

  def index  
    @fb_friends = current_user.fbdata.friends
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @friend_uid = params[:uid]
    friend = current_user.fbpost(@friend_uid)
    
    friend.feed!(
      :message => 'Polecam najsu, zobacz!',
      :link => 'https://najsu.pl',
      :name => 'Najsu',
      :description => 'Odkrywaj filmiki dziel ze znajomymi!'
    )

    #invitation = current_user.invitations.create(:uid => @friend_uid)

    respond_to do |format|
      format.html 
      format.js { @status = true }
    end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end

  private

    def facebook_user
      redirect_to root_path unless current_user.facebook?
    end

end
