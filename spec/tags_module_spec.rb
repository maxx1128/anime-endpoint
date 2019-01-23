require_relative '../lib/tags_module.rb'

describe Tags do
  before :each do
    dummy_class = Class.new { include Tags }

    @Tags = dummy_class.new()
    @all_tag_methods = dummy_class.instance_methods.grep(/tags\z/)
  end

  it 'should have all tag methods include their name and tag listings' do
    @all_tag_methods.each do |method_name|
      method = @Tags.send(method_name)
      name = method[:name]
      tags = method[:tags]

      expect(method).to include(:name, :tags)

      expect(name).to be_a(String)
      expect(tags).to be_a(String)
    end
  end

  it 'should have required tags for size and content' do
    @all_tag_methods.each do |method_name|
      method = @Tags.send(method_name)
      tags = method[:tags]

      expect(tags).to include(Tags::SFW, Tags::TYPES, Tags::SIZING)
    end
  end
end
