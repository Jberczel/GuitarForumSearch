require 'test_helper'

class AuctionLinksTest < ActionDispatch::IntegrationTest

  test 'auction links are hidden' do
    visit(guitars_path)
    # assert_not page.find('.auction-links').visible?
    # fill('', with: 'Larrivee Parlor')
  end
end
