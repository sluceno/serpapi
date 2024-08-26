require 'json'

require_relative 'lib/google_carrousel_scraper'

FILE='files/van-gogh-paintings.html'

html = File.read(FILE)

result = GoogleCarrouselScraper.new(html).scrape

puts JSON.pretty_generate(result)
