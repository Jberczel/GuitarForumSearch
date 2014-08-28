module PostsHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end

  def cache_key_for_posts
    last_updated_at = Post.first.updated_at.try(:utc).try(:to_s, :number)
    "/all-#{last_updated_at}"
  end
end
