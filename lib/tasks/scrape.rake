namespace :scrape do
  desc "Scrape AGF For Sale forum"
  task agf: :environment do
    puts "scraping AGF pages..."
    scraper = GuitarScraper.new
    scraper.parse_pages.create_posts(Post)
    puts "scraping complete."
  end

  task agf_gear: :environment do
    puts "scraping AGF GEAR pages..."
    scraper = GearScraper.new
    scraper.parse_pages.create_posts(Gear)
    puts "scraping complete"
  end

  task larrivee: :environment do
    puts "scraping LARRIVEE pages..."
    scraper = LarriveeScraper.new
    scraper.parse_pages.create_posts(Larrivee)
    puts "scraping complete"
  end
end