module MartinHelper
  def cache_key_for_martin
    last_updated_at = Martin.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end