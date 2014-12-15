namespace :scrape do
  desc "Scrape guitar forum"

  task agf: :environment do
    puts "scraping agf guitar pages..."
    scraper = GuitarScraper.new
    scraper.parse_pages.create_posts(Post)
    puts "scraping complete"
  end

  task agf_gear: :environment do
    scrape Gear
  end

  task larrivee: :environment do
    BiDailyScheduler.new(:hour => 4).schedule do
      scrape Larrivee
    end
  end

  task martin: :environment do
    BiDailyScheduler.new(:hour => 5).schedule do
      scrape Martin
    end
  end
end

def scrape(object)
  puts "scraping #{object} pages..."
  scraper = "#{object}Scraper".constantize.new
  scraper.parse_pages.create_posts(object)
  puts "scraping complete"
end


