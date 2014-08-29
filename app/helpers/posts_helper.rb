module PostsHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end

  def cache_key_for_posts
    # TODO: while parsing pages, requests to page will not pull all records until complete
    last_updated_at = Post.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end
