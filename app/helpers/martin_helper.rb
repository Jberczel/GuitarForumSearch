module MartinHelper
  def cache_key_for_martin
    last_updated_at = Martin.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end

 # def format_martin_last_post(post)
 #   # split text on space between user and date
 #   post.split /\s+(?=\d{1,2}\/\d{1,2}\/\d{2,4})/
 # end

end
