require 'nokogiri'

require_relative 'thumbnails_scraper'

class GoogleCarrouselScraper
  def initialize(raw_html)
    @raw_html = raw_html
  end

  def scrape
    html_items.map do |html_item|
      scrape_item(html_item)
    end
  end

  private

  def doc
    @doc ||= Nokogiri::HTML5(@raw_html)
  end

  def thumbnails
    @thumbnails ||= ThumbnailsScraper.new(@raw_html).scrape
  end

  def html_items
    doc.css('div.klbar div.klitem-tr')
  end

  ##
  # scrape_item scrapes a carrousel item
  #
  # Note the following:
  #   - If `name`, `extensions` or `link` is Null should not be part of the object
  #   - `image` can be null if no image data is found
  def scrape_item(html_item)
    image_id = scrape_image_id(html_item)

    artwork = {
      name: scrape_name(html_item),
      extensions: scrape_extensions(html_item),
      link: scrape_link(html_item),
    }.compact

    artwork[:image] = thumbnails[image_id]

    artwork
  end

  def scrape_name(html_item)
    name_node = html_item.at_css('div.kltat')

    return nil unless name_node

    name_node.content
  end

  def scrape_extensions(html_item)
    extensions_node = html_item.css('div.klmeta')

    return nil if extensions_node.empty?

    extensions_node.map { |e| e.content }
  end

  def scrape_link(html_item)
    link_node = html_item.at_css('a.klitem')

    return nil unless link_node

    'https://www.google.com' + link_node['href']
  end

  def scrape_image_id(html_item)
    image_node = html_item.at_css('a.klitem div.klic img')

    return nil unless image_node

    image_node['id']
  end
end
