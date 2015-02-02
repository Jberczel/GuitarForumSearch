module ClassifiedsInterfaceTest
  extend ActiveSupport::Concern

  included do
    test 'responds to listing' do
      assert_respond_to @object, :listing
    end

    test 'responds to formatted_last_post' do
      assert_respond_to @object, :formatted_last_post
    end

    test 'responds to title' do
      assert_respond_to @object, :title
    end

    test 'responds to link' do
      assert_respond_to @object, :link
    end

    test 'responds to base url' do
      assert_respond_to @object, :base_url
    end

    test 'responds to author' do
      assert_respond_to @object, :author
    end

    test 'responds to last_post' do
      assert_respond_to @object, :last_post
    end
  end

end
