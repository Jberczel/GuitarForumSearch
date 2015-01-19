require 'test_helper'

class LarriveeDecoratorTest < Draper::TestCase

  def setup
    @larrivee = larrivees(:three).decorate
  end

  test 'removal of sess id from link' do
    link = "http://www.larriveeforum.com/smf/index.php?topic=47537.0"
    assert_equal link, @larrivee.link
  end
end
