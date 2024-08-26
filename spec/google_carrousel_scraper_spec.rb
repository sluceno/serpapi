require 'google_carrousel_scraper'
require 'json'

describe GoogleCarrouselScraper do
  let(:expected_output) { JSON.load(File.read('files/expected-array.json'))['artworks'] }
  let(:raw_html) { File.read('files/van-gogh-paintings.html') }

  subject { GoogleCarrouselScraper.new(raw_html) }

  context 'when success' do
    it 'returns the expected results' do
      expect(JSON.pretty_generate(subject.scrape)).to eq(JSON.pretty_generate(expected_output))
    end
  end
end
