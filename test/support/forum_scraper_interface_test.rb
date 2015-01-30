module ForumScraperInterfaceTest
  extend ActiveSupport::Concern

  included do

    test 'responds to url' do
      assert_respond_to(@object, :url)
    end

    test 'responds to sticky posts' do
      assert_respond_to(@object, :sticky_posts)
    end

    test 'responds to posts' do
      assert_respond_to(@object, :posts)
    end

    test 'responds to posts?' do
      assert_respond_to(@object, :posts?)
    end

    test 'responds to content' do
      assert_respond_to(@object, :content)
    end

    test 'responds to something default_url' do
      assert_respond_to(@object, :default_url)
    end

    test 'responds to sticky default_sticky_posts' do
      assert_respond_to(@object, :default_sticky_posts)
    end

    test 'responds to parse pages' do
      assert_respond_to @object, :parse_pages
    end

    test 'responds to create posts' do
      assert_respond_to @object, :create_posts
    end

    test 'responds to post_initialize' do
      assert_respond_to @object, :post_initialize
    end

    test 'responds to page count' do
      assert_respond_to @object, :page_count
    end
  end
end
