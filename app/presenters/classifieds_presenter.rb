module ClassifiedsPresenter

  def listing
    h.content_tag :div do
      h.concat h.link_to title, "#{base_url}#{link}", :target => "_blank"
      h.concat h.tag("br")
      h.concat h.content_tag :span, author, :class => "author"
    end
  end

  # Last_Post Formatting
  # splits user and date from parsed column
  #
  # ==== Examples
  #
  # "Professor Chaos 12/31/2014 5:57 PM"    # => <div> 12/31/2014 5:57 PM<br> by Professor Chaos</div>
  # "Johnny Cash II Dec 31 2014 11:59 PM"   # => <div>Dec 31 2014 11:59 PM<br> by Johnny Cash II</div>
  # "Today at 2:40 PM by John Fahey"        # => <div>Today at 2:40 PM<br>by John Fahey</div>
  #
  FORMATS = [
   /(?<user>.+)\s+(?<date>\d+\/\d+\/\d+.*$)/,
   /(?<user>.+)\s+(?<date>[a-zA-Z]{3} \d+ \d+.*$)/,
   /(?<date>.+)\s+by\s+(?<user>.+$)/
  ]

  def formatted_last_post
    date, user = ""
    FORMATS.each do |format|
      m = last_post.match(format)
      date, user = m[:date], m[:user] if m
    end
    h.simple_format("#{date}\nby #{user}", {}, :wrapper_tag => "div")
  end
end
