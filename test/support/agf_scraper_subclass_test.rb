module AgfScraperSubclassTest
  extend ActiveSupport::Concern

  included do
    test 'responds to forum' do
      assert_respond_to @object, :forum
    end
  end
end
