module PostsHelper
  
  def cache_key_for_posts
    # TODO: while parsing pages, requests to page will not pull all records until complete
    last_updated_at = Post.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end
