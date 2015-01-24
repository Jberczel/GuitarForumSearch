class Larrivee < ActiveRecord::Base
  extend PostUtils
  default_scope { order(:id) }
  before_save  { self.link = link.gsub(/PHPSESSID=.*&/, '') }
end
