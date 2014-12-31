module BlueridgesHelper
  def cache_key_for_blueridge
    last_updated_at = Blueridge.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end

  def format_blueridge_last_post(post)
    # workaround for now
    post.split(' ', 2)
  end

end
