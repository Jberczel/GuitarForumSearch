module ApplicationHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ')
  end

  FORMATS = [
   /(?<user>.+)(?<date>\s+\d+\/\d+\/\d+.*$)/,
   /(?<user>.+)(?<date>\s+[a-zA-Z]{3} \d+ \d+.*$)/
  ]

  def format_last_post(post)
    FORMATS.each do |format|
       m = post.match(format)
       return [ m[:user], m[:date].lstrip ] if m
    end
    ["",""] # return empty string if no matches found
  end
end
