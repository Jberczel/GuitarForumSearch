module PostsHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end

  def cache_key_for_posts
    first_updated_at = Post.first.updated_at.to_i
    last_updated_at = Post.last.updated_at.to_i
    "/all-#{first_updated_at}-#{last_updated_at}"
  end
end
