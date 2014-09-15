module GearHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end

  def cache_key_for_gear
    last_updated_at = Gear.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end