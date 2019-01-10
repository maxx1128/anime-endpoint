require_relative '../lib/tags_module.rb'

describe Tags do
  before :each do
    dummy_class = Class.new { include Tags }

    @Tags = dummy_class.new()
    @all_queries = @Tags.all_image_params
    @all_tag_methods = dummy_class.instance_methods.grep(/tags\z/)
  end

  it 'should return the expected data for the presenter' do
    @all_queries.each do |item|
      label = item[:label]
      query = item[:params]

      expect(item).to include(:label, :params)

      expect(label).to be_a(String)
      expect(query).to be_a(String)
    end
  end

  it 'should have required tags for size and content' do
    @all_queries.each do |item|
      query = item[:params]

      expect(query).to include(Tags::SFW, Tags::TYPES, Tags::SIZING)
    end
  end

  it 'should have additional tags aside from the required ones' do
    @all_queries.each do |item|
      query = item[:params]
      query.slice! (Tags::SFW + Tags::TYPES + Tags::SIZING)
      base_params = query.split('+').reject { |p| p.empty? }

      expect(base_params).to be_an(Array)
      expect(base_params.length).to be >= 1
    end
  end

  it 'should have all tag methods include their name and tag listings' do
    @all_tag_methods.each do |method_name|
      method = @Tags.send(method_name)
      name = method[:name]
      tags = method[:tags]

      expect(method).to include(:name, :tags)

      expect(name).to be_a(String)
      expect(tags).to be_an(Array)
      expect(tags.length).to be >= 1
    end
  end
end
