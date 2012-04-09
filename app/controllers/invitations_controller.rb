class InvitationsController < ApplicationController

  def index
    fbuser = current_user.fbgraph
    @fb_friends = fbuser.friends
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end

  def new
    @friend_uid = params[:uid]
    auth = current_user.authentications.find_by_provider("facebook")
    fbuser = FbGraph::User.new(@friend_uid, :access_token => auth.token)
    
    fbuser.feed!(
      :message => 'Polecam najsu, zobacz!',
      :link => 'https://najsu.herokuapp.com',
      :name => 'Najsu',
      :description => 'Odkrywaj filmiki dziel ze znajomymi!'
    )

    invitation = current_user.invitations.create(:uid => @friend_uid)

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
end