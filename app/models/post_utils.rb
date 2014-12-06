module PostUtils
   def create(posts)
    posts.each do |p|
      create!(title: p.title, link: p.link, author: p.author,
              last_post: p.last_post, replies: p.replies, views: p.views)
    end
  end

  def clear_db
    destroy_all      
    reset_pk_sequence # reset primary key to 0
  end
end