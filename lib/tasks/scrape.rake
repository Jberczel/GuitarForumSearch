namespace :scrape do
  desc "Scrape AGF For Sale forum"
  task agf: :environment do
      puts "scraping AGF pages..."
      Post.delete_all
      Post.reset_pk_sequence
      Post.scrape
      puts "scraping complete."
  end
end