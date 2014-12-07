module LarriveeHelper
  def cache_key_for_larrivee
    last_updated_at = Larrivee.last.updated_at.to_i
    "/all-#{last_updated_at}"
  end
end