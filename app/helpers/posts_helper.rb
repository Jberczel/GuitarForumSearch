module PostsHelper
  def cache_key_for_posts
    last_updated_at = Post.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end
