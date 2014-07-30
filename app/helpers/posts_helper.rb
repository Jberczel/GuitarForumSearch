module PostsHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ') 
  end
end
