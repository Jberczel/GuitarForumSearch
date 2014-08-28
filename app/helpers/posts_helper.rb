module PostsHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end

  def cache_key_for_posts
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/all-#{count}-#{max_updated_at}"
  end
end
