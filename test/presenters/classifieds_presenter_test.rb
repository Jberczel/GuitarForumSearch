module ClassifiedsPresentersTest

  test 'listing includes title, link, and author' do
    assert_match @object.title,  @object.listing
    assert_match @object.link,   @object.listing
    assert_match @object.author, @object.listing
  end

  test 'last_post formatting' do
    assert_match @object.last_post, @object.formatted_last_post
    assert_match "<br />", @object.formatted_last_post
  end

end
