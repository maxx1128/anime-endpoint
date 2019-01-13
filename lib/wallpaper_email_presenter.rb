require 'fileutils'
require_relative 'tags_module.rb'
require_relative 'wallpaper_url_query.rb'

class WallpaperEmailPresenter
  include Tags

  def random_tag_groups
    activity = [reading_tags, computer_tags].sample
    anime = [rwby_tags, monster_girls_tags, mirai_nikki_tags].sample
    gaming_1 = [ddlc_tags, katawa_shoujo_tags].sample
    gaming_2 = [splatoon_tags, zelda_tags, smash_bros_tags, pokemon_tags].sample
    extra = [portrait_tags, angel_tags, glasses_tags].sample

    [activity, anime, gaming_1, gaming_2, extra, random_tags, random_tags]
  end

  def full_view
    wallpaper_views.prepend("<h1>Here's Today's Wallpapers!</h1>")
  end

  def wallpaper_views
    all_views = random_tag_groups.map do |tag_group|
      tags = tag_group[:tags]
      image = WallpaperUrlQuery.new(tags).random_image

      view = "<h3>#{tag_group[:name]}</h3>"

      if image.is_a?(Hash)
        view << "<p class='error-message'><strong>No image found here!</strong></p>"
      else
        view << "<img src=#{image} style='display: block; max-width: 100%; margin: 0 auto;' />"
      end
    end

    all_views.join('')
  end
end
