namespace :scrape do
  desc "Scrape AGF For Sale forum"
  task agf: :environment do
      puts "scraping AGF pages..."
      Post.scrape_create
      puts "scraping complete."
  end

  task agf_gear: :environment do
    puts "scraping AGF GEAR pages..."
    Gear.scrape_create
    puts "scraping complete"
  end
end