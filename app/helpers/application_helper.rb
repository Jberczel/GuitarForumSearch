module ApplicationHelper

  # Last_post formats
  FORMATS = [
   /(?<user>.+)\s+(?<date>\d+\/\d+\/\d+.*$)/,
   /(?<user>.+)\s+(?<date>[a-zA-Z]{3} \d+ \d+.*$)/
  ]

  # Splits user and date from parsed column (last_post)
  #
  # ==== Examples
  #
  # "Professor Chaos 12/31/2014 5:57 PM"    # => ["Professor Chaos", "12,31/2014 5:57 PM"]
  # "Johnny Cash II Dec 31 2014 11:59 PM"   # => ["Johnny Cash II", "Dec 31 2014 11:59 PM"]
  # "-"                                     # => ["", ""]
  def format_last_post(post)
    FORMATS.each do |format|
       m = post.match(format)
       return [ m[:user], m[:date] ] if m
    end
    ["",""] # return empty string if no matches found
  end
end
