require_relative '../lib/mass_download_saver.rb'

describe MassDownloadSaver do
  let(:default_download) { MassDownloadSaver.new() }
  let(:small_download) { MassDownloadSaver.new(5) }

  it 'should return any specified number of items' do
    default_images = default_download.image_group
    more_images = small_download.image_group

    expect(default_images.length).to eq(MassDownloadSaver::DEFAULT_NUMBER)
    expect(more_images.length).to eq(5)
  end
end
