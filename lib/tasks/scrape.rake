namespace :scrape do
  desc "Scrape AGF For Sale forum"
  task agf: :environment do
      puts "scraping AGF pages..."
      # Post.delay.scrape_create
      # no moneny for heroku workers :(
      Post.scrape_create
      puts "scraping complete."
  end
end