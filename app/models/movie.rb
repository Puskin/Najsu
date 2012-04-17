class Movie < ActiveRecord::Base

	attr_accessible :resource_id, :user_id, :title

  has_many :likes
  has_many :comments
  belongs_to :user

  # Pagination parameter
  self.per_page = 10

  # Returns movies from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  # Period scopes for various types 
  scope :last_week, lambda { where("created_at > ?", 7.days.ago ) }

  # Hype type scopes
  scope :popular, order("likes_count DESC")
  scope :watched, order("views_count DESC")


  def views_update
    self.views_count+=1
    save!
  end

  def reposts
    Movie.find_all_by_resource_id(self.resource_id)
  end

  def reposted_by
    Movie.find_all_by_resource_id(self.resource_id).map(&:user_id)
  end


  #Cheking if liked by user
  def liked?(user_id)
  	likes = self.likes
  	if likes.find_by_user_id(user_id)
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
