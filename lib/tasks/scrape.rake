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
    hour = ENV['now'] ? Time.now.hour : 4
    QuarterDayScheduler.new(:hour => hour).schedule { scrape Larrivee }
  end

  task martin: :environment do
    hour = ENV['now'] ? Time.now.hour : 5
    QuarterDayScheduler.new(:hour => hour).schedule { scrape Martin }
  end

  task blueridge: :environment do
    hour = ENV['now'] ? Time.now.hour : 6
    BiDailyScheduler.new(:hour => hour).schedule { scrape Blueridge }
  end
end

def scrape(object)
  puts "scraping #{object} pages..."
  scraper = "#{object}Scraper".constantize.new
  scraper.parse_pages { |page| puts "parsing page #{page}..." }
  scraper.create_posts(object)
  puts "scraping complete"
end
