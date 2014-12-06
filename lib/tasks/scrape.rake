namespace :scrape do
  desc "Scrape AGF For Sale forum"
  task agf: :environment do
    puts "scraping AGF pages..."
    ScrapedPosts.create_posts(ScrapedPosts::GUITARS, Post)
    puts "scraping complete."
  end

  task agf_gear: :environment do
    puts "scraping AGF GEAR pages..."
    ScrapedPosts.create_posts(ScrapedPosts::GEAR, Gear)
    puts "scraping complete"
  end

  task larrivee: :environment do
    puts "scraping LARRIVEE pages..."
    ScrapedPosts.create_posts(ScrapedPosts::LARRIVEE, Larrivee)
    puts "scraping complete"
  end
end