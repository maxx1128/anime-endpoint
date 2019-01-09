require_relative '../lib/tags_module.rb'

describe Tags do
  before :each do
    dummy_class = Class.new { include Tags }
    @Tags = dummy_class.new
  end

  it 'should have required tags for size and content' do
    all_items = @Tags.all_image_params

    all_items.each do |item|
      tags = item[:params]

      expect(tags).to include(Tags::SFW)
      expect(tags).to include(Tags::TYPES)
      expect(tags).to include(Tags::SIZING)
    end
  end
end
