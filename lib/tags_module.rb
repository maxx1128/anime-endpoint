module Tags
  SFW = "+-skin_tight+-ass+-cleavage+-underwear+-thigh-highs+-lingerie+-bondage+-nude+-sideboob+-hands_on_breasts+-see-through+-thighs+-thigh_gap+-huge_breasts+-miniskirt+-impossible_clothes+-shorts+-swimsuit+-bikini+-kiss+-panties+-panty*+-breast*+-sexually_suggestive+-blood+-looking_at_viewer ".freeze
  TYPES = "+-comic+-manga+-long_image+-tall_image+-character_sheet".freeze
  SIZING = "+height%3a>500+width%3A>500".freeze

  def reading_tags
    tags = with_optional_tag(choose_one_tag(%w(reading book)), %w(smile bookshelf glasses))

    { name: "Reading",
      tags: tag_parameters(tags) }
  end

  def computer_tags
    tags = %w(computer)

    { name: "Computers",
      tags: tag_parameters(tags) }
  end

  def rwby_tags
    tags = %w(rwby)

    { name: "RWBY",
      tags: tag_parameters(tags) }
  end

  def monster_girls_tags
    tags = %w(monster_musume_no_iru_nichijou)

    { name: "Daily Life with Monster Girls",
      tags: tag_parameters(tags) }
  end

  def infinite_stratos_tags
    tags = %w(infinite_stratos)

    { name: "Infinite Stratos",
      tags: tag_parameters(tags) }
  end

  def mirai_nikki_tags
    tags = %w(mirai_nikki)

    { name: "Mirai Nikki",
      tags: tag_parameters(tags) }
  end

  def ddlc_tags
    tags = %w(doki_doki_literature_club)

    { name: "Doki Doki Literature Club",
      tags: tag_parameters(tags) }
  end

  def katawa_shoujo_tags
    tags = %w(katawa_shoujo)

    { name: "Katawa Shoujo",
      tags: tag_parameters(tags) }
  end

  def splatoon_tags
    tags = choose_one_tag(%w(splatoon splatoon_2))

    { name: "Splatoon",
      tags: tag_parameters(tags) }
  end

  def zelda_tags
    tags = %w(the_legend_of_zelda)

    { name: "Zelda",
      tags: tag_parameters(tags) }
  end

  def smash_bros_tags
    tags = %w(super_smash_bros.)

    { name: "Super Smash Bros",
      tags: tag_parameters(tags) }
  end

  def pokemon_tags
    tags = with_optional_tag(%w(pokemon), %w(eevee umbreon espeon porygon))

    { name: "Pokemon",
      tags: tag_parameters(tags) }
  end

  def portrait_tags
    tags = ['simple_background'].push(%w(1boy 1girl).sample)

    { name: "Portrait",
      tags: tag_parameters(tags) }
  end

  def angel_tags
    tags = %w(angel wings)

    { name: "Angel",
      tags: tag_parameters(tags) }
  end

  def glasses_tags
    tags = with_optional_tag(%w(glasses), %w(1girl heart blush smile))

    { name: "Glasses",
      tags: tag_parameters(tags) }
  end

  def happy_tags
    tags = choose_one_tag(%w(smile heart heart_hands wink))

    { name: "Happy",
      tags: tag_parameters(tags) }
  end

  def sad_tags
    tags = choose_one_tag(%w(sad tears crying))

    { name: "Sad",
      tags: tag_parameters(tags) }
  end

  def outdoor_tags
    tags = %w(outdoors)

    { name: "Outdoors",
      tags: tag_parameters(tags) }
  end

  def absurdres_tags
    tags = %w(absurdres)

    { name: "Absurdres",
      tags: tag_parameters(tags) }
  end

  def visual_novel_art_tags
    tags = %w(game_cg)

    { name: "Visual Novel Art",
      tags: tag_parameters(tags) }
  end

  def chibi_tags
    tags = %w(chibi)

    { name: "Chibi",
      tags: tag_parameters(tags) }
  end

  def random_tags
    tags = []

    { name: "Random",
      tags: tag_parameters(tags) }
  end

  private

  def tag_parameters(tags)
    "#{tags.map { |tag| tag.prepend('+') }.join('')}#{SFW}#{TYPES}#{SIZING}"
  end

  def choose_one_tag(tags)
    [tags.sample]
  end

  def with_optional_tag(tags, extra_tags)
    one_in_three = (rand(1..3) == 1)

    if one_in_three
      tags.push(extra_tags.sample)
    else
      tags
    end
  end
end
