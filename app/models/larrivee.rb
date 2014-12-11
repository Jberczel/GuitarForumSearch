class Larrivee < ActiveRecord::Base
  extend PostUtils
  default_scope { order(:id) }
end
