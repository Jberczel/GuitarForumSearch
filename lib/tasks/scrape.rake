namespace :scrape do
  desc "Scrape AGF For Sale forum"
  task agf: :environment do
      puts "scraping AGF pages..."
      Post.scrape_create
      puts "scraping complete."
  end
end