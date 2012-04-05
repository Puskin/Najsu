class Movie < ActiveRecord::Base

	attr_accessible :resource_id, :user_id
  default_scope order: 'movies.created_at DESC'
  has_many :votes
  has_many :comments
  belongs_to :user


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


end
