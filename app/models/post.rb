class Post < ActiveRecord::Base
  extend PostUtils
  default_scope { order(:id) }
 
end

