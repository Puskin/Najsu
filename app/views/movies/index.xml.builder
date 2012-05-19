xml.movies do
  @movies.each do |movie|                            
      xml.movie(
        :id => movie.id, 
        :user_id => movie.user_id, 
        :source => movie.source,
        :resource_id => movie.resource_id, 
        :title => movie.title
      )
  end  
end