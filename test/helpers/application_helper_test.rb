require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @post1 = "Professor Chaos 12/28/2014 1:18 PM"
    @post2 = "Big Bad Bill 2 12/14/2014 9:07 AM"
    @post3 = "gdeleoh Dec 20 14 3:48 PM"
    @post4 = " - "
  end

  test 'format_last_post with spaces in username' do
    result = ["Professor Chaos","12/28/2014 1:18 PM"]
    assert_equal result, format_last_post(@post1)
  end

  test 'format_last_post with numeric name' do
     result = ["Big Bad Bill 2","12/14/2014 9:07 AM"]
    assert_equal result, format_last_post(@post2)
  end

  test 'format_last_post with mmm dd yy date format' do
    result = ["gdeleoh", "Dec 20 14 3:48 PM"]
    assert_equal result, format_last_post(@post3)
  end

  test 'format_last_post with no format match' do
    result = ["", ""]
    assert_equal result, format_last_post(@post4)
  end
end



