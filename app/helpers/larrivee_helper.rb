
module LarriveeHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end

  def cache_key_for_larrivee
    last_updated_at = Larrivee.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end