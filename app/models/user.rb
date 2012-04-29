class User < ActiveRecord::Base
	
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	before_save :create_remember_token


	validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true, 
										format: { with: VALID_EMAIL_REGEX }, 
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }			

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
	has_many :authentications
	has_many :likes
	has_many :movies
	has_many :comments
	has_many :invitations
	has_many :reposts
	has_many :activities

	#users following relations
	def feed
	  Movie.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end




  #facebook integration stuff
	def facebook?
		if self.authentications.find_by_provider("facebook")
			true
		else
			false
		end
	end

	def fbgraph
		auth = self.authentications.find_by_provider("facebook")
		fbuser = FbGraph::User.fetch(auth.uid, :access_token => auth.token)
	end

	def apply_omniauth(omniauth)
  	self.email = omniauth['info']['email']
  	self.name  = omniauth['info']['name']
  	authentications.build(
  		:provider => omniauth['provider'], 
  		:uid 			=> omniauth['uid'],
  		:token 		=> omniauth['credentials']['token']
  	)
	end

	private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end							   

end
