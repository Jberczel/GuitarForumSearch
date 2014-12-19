require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
  end

  test "responds to" do
    assert_respond_to @post, :title
    assert_respond_to @post, :link
    assert_respond_to @post, :author
    assert_respond_to @post, :last_post
    assert_respond_to @post, :replies
    assert_respond_to @post, :views
  end
end

