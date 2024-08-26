##
# This class scrapes images base64 payload from the Google Carrousel
#
# We fond out some images base64 payload is stored in javascript functions that
# replaces the `src` attribute of the <img>
class ThumbnailsScraper
  IMAGES_REGEX = /\(function\(\){var s='(?<src>[^']+)';var ii=\['(?<img>[^']+)'\];_setImagesSrc\(ii,s\);\}\)\(\);/

  def initialize(raw_html)
    @raw_html = raw_html
  end

  ##
  # Scrape the base64 image payload of the images
  #
  # Returns a Hash[imageID] with the base64 payload
  def scrape
    thumbnails
  end

  private

  def thumbnails
    @images ||= @raw_html.scan(IMAGES_REGEX).inject({}) do |res, regex_res|
      image_id = regex_res[1]
      image_src = remove_scape_characters(regex_res[0])

      res.merge!({image_id => image_src})
    end
  end

  def remove_scape_characters(image_src)
    image_src.gsub!('\x3d', 'x3d')

    image_src
  end
end
