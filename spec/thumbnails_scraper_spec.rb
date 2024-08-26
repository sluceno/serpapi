require 'thumbnails_scraper'
require 'json'

describe ThumbnailsScraper do
  let(:expected_array) { JSON.load(File.read('files/expected-array.json')) }
  let(:expected_result) { expected_array['artworks'].first['image']}
  let(:raw_html) { File.read('files/van-gogh-paintings.html') }
  let(:image_id) { 'kximg0' }

  subject { ThumbnailsScraper.new(raw_html) }

  context 'when success' do
    it 'returns the expected image data' do
      expect(subject.scrape[image_id]).to eq(expected_result)
    end
  end
end
