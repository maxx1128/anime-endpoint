require_relative 'tags_module.rb'

class APIParamsBridge
  include Tags

  def initialize(params)
    @include_tags = params[:tags] || '',
    @exclude_tags = params[:exclude] || '',
    @large = params[:large] || false
    @size = params[:size] || false

    @height = params[:height] ? get_size_hash('height', params[:height]) : false
    @width = params[:width] ? get_size_hash('width', params[:width]) : false
    @min_height = params[:min_height] ? get_size_hash('min_height', params[:min_height]) : false
    @min_width = params[:min_width] ? get_size_hash('min_width', params[:min_width]) : false
    @max_height = params[:max_height] ? get_size_hash('max_height', params[:max_height]) : false
    @max_width = params[:max_width] ? get_size_hash('max_width', params[:max_width]) : false
  end

  def get_size_hash(label, size)
    if label.include? 'min'
      comparison = '>='
    elsif label.include? 'max'
      comparison = '<='
    else
      comparison = '='
    end

    if label.include? 'width'
      measure = 'width'
    else
      measure = 'height'
    end

    {
      label: label,
      size: size,
      comparison: comparison,
      measure: measure
    }
  end

  def get_sizing_tags
    sizes = [@height, @width, @min_height, @min_width, @max_height, @max_width].reject { |s| !s }

    sizes.map { |s| "+#{s[:measure]}:#{s[:comparison]}#{s[:size]}" }.join('')
  end

  def get_tags
    include_tags = @include_tags[0].split(',').map{ |t| t.prepend('+') }.join('')
    exclude_tags = @exclude_tags.split(',').map{ |t| t.prepend('+-') }.join('')

    "#{include_tags}#{exclude_tags}#{get_sizing_tags}"
  end

  def give_tags
    "#{get_tags}#{Tags::SFW}#{Tags::TYPES}"
  end
end
