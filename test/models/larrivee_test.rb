require 'test_helper'

class LarriveeTest < ActiveSupport::TestCase
  def setup
    @larrivee = larrivees(:three)
  end

  test 'links do not include session ids' do
    @larrivee.link = 'http://www.larriveeforum.com/smf/index.php?PHPSESSID=s7gqub6ughlid137l2ne77grd5&topic=47537.0'
    @larrivee.save
    refute_match(/PHPSESSID=.*&/, @larrivee.link)
  end
end
