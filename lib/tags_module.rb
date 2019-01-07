module Tags
  # Have several optional ones, and select a few of them at random for the final results?
  def all_image_params
    [reading_params, visual_novel_params, anime_params, pokemon_params, video_games_params, random_params]
  end

  def reading_params
    { label: "Reading",
      params: tag_parameters(%w(smile book bookshelf glasses ''), %w(reading)) }
  end

  def visual_novel_params
    { label: "Visual Novel",
      params: tag_parameters(%w(doki_doki_literature_club katawa_shoujo)) }
  end

  def anime_params
    { label: "Anime",
      params: tag_parameters(%w(rwby monster_musume_no_iru_nichijou mirai_nikki)) }
  end

  def pokemon_params
    { label: "Pokemon",
      params: tag_parameters(%w(eevee umbreon espeon ''), %w(pokemon)) }
  end

  def video_games_params
    { label: "Video Games",
      params: tag_parameters(%w(splatoon splatoon_2 the_legend_of_zelda super_smash_bros._ultimate)) }
  end

  def random_params
    { label: "Random",
      params: tag_parameters([], %w(absurdres)) }
  end

  def tag_parameters(sample_tags, required_tags = [])
    sfw = "+-skin_tight+-ass+-cleavage+-seductive_smile+-swimsuit+-underwear+-thigh-highs+-lingerie"
    types = "+-comic+-translation_request"
    sizing = "+height%3a>1000+height%3a<4000+width%3A>750"
    extra_tags = required_tags.map { |tag| tag.prepend('+') }.join('')

    "#{sample_tags.sample}#{extra_tags}#{sfw}#{types}#{sizing}"
  end
end
