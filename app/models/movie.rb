class Movie < ActiveRecord::Base

	attr_accessible :resource_id, :user_id, :title, :source, :thumbnail
  after_save :repost_and_like

  has_many :likes
  has_many :comments
  has_many :reposts
  
  belongs_to :user

  # Pagination parameter
  self.per_page = 10

  # Returns movies from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  # Period scopes for various types 
  scope :last_week, where("created_at > ?", 7.days.ago )

  # Hype type scopes
  scope :popular, order("likes_count DESC")
  scope :watched, order("views_count DESC")


  def views_update
    self.views_count+=1
    save!
  end


  # Check if video to be added is unique 
  def self.unique?(resource_id, source)
    movie = find_by_resource_id_and_source(resource_id, source) 
    if movie
      movie
    else
      false
    end
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

    def repost_and_like
      Repost.create(:movie_id => self.id, :user_id => self.user_id, :resource_id => self.resource_id, :source => self.source, :thumbnail => self.thumbnail) 
      Like.create(:movie_id => self.id, :user_id => self.user_id)
    end

end
