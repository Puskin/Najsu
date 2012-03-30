class Movie < ActiveRecord::Base

	attr_accessible :resource_id
  default_scope order: 'movies.created_at DESC'

end
