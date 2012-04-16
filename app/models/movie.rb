class Movie < ActiveRecord::Base

	attr_accessible :resource_id, :user_id, :title

  has_many :votes
  has_many :comments

  belongs_to :user

  self.per_page = 10



  # Returns movies from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  def views_update
    self.views_count+=1
    save!
  end

  def likes_count
    self.votes.likes.count - self.votes.dislikes.count
  end


  def reposts
    Movie.find_all_by_resource_id(self.resource_id)
  end

  def reposted_by
    Movie.find_all_by_resource_id(self.resource_id).map(&:user_id)
  end


  #voting movies
  def vote?(user_id)
  	if self.voted?(user_id)
  		votes = self.votes
  		vote = votes.find_by_user_id(user_id)
  		vote.character
  	else
  		false
  	end	
  end

  def voted?(user_id)
  	votes = self.votes
  	if vote = votes.find_by_user_id(user_id)
	  	true
  	else 
  		false
  	end
  end


  private

    # Returns an SQL condition for users followed by the given user.
    # We include the user's own id as well. (REMOVED TEMP)
    def self.followed_by(user)
      followed_user_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
      #where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", { user_id: user })
      where("user_id IN (#{followed_user_ids})", { user_id: user })
    end

end
