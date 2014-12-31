module ApplicationHelper
  # post is string with date and author of last post
  def getDateAndPerson(post)
    post.split('by ')
  end

  FORMATS = [
   /(?<user>.+)\s+(?<date>\d+\/\d+\/\d+.*$)/,
   /(?<user>.+)\s+(?<date>[a-zA-Z]{3} \d+ \d+.*$)/
  ]

  def format_last_post(post)
    FORMATS.each do |format|
       m = post.match(format)
       return [ m[:user], m[:date] ] if m
    end
    ["",""] # return empty string if no matches found
  end
end
