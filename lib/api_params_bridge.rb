require_relative 'tags_module.rb'

class APIParamsBridge
  include Tags

  def initialize(params)
    @include_tags = params[:tags] || '',
    @exclude_tags = params[:exclude] || '',
    @large = params[:large] || false
    @size = params[:size] || false

    @height = params[:height] || false
    @width = params[:width] || false
    @min_height = params[:min_height] || false
    @min_width = params[:min_width] || false
    @max_height = params[:max_height] || false
    @max_width = params[:max_width] || false
  end

  def get_sizing_tags
    sizes = [@height, @width, @min_height, @min_width, @max_height, @max_width].reject { |s| !s }

    sizes
  end

  def get_tags
    puts @include_tags

    include_tags = @include_tags[0].split(',').map{ |t| t.prepend('+') }.join('')
    exclude_tags = @exclude_tags.split(',').map{ |t| t.prepend('+-') }.join('')

    "#{include_tags}#{exclude_tags}"
  end

  def give_tags
    "#{get_tags}#{Tags::SFW}#{Tags::TYPES}"
  end
end

params = {
  tags: 'book,computer',
  exclude: 'television,beach',
  height: 200,
  width: 300
}

test_params = APIParamsBridge.new(params);

puts test_params.get_tags
