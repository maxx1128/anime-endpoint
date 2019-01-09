module Tags
  SFW = "+-skin_tight+-ass+-cleavage+-underwear+-thigh-highs+-lingerie+-bondage+-huge_breasts"
  TYPES = "+-comic+-translation_request+-manga"
  SIZING = "+height%3a>1000+height%3a<4000+width%3A>750"

  def all_image_params
    activities = gather_tags_for("Activities", [reading_tags, computer_tags], 2)
    anime = gather_tags_for("Anime", [ddlc_tags, katawa_shoujo_tags, rwby_tags, monster_girls_tags, mirai_nikki_tags], 2)
    gaming = gather_tags_for("Gaming", [splatoon_tags, zelda_tags, smash_bros_tags, pokemon_tags], 2)
    extra = gather_tags_for("Extra", [portrait_tags, angel_tags, glasses_tags, random_tags], 2)

    activities + anime + gaming + extra
  end

  def reading_tags
    { name: "Reading",
      tags: with_optional_tags(choose_one_tag(%w(reading book)), %w(smile bookshelf glasses)) }
  end

  def computer_tags
    { name: "Computers",
      tags: %w(computer) }
  end

  def ddlc_tags
    { name: "Doki Doki Literature Club",
      tags: %w(doki_doki_literature_club) }
  end

  def katawa_shoujo_tags
    { name: "Katawa Shoujo",
      tags: %w(katawa_shoujo) }
  end

  def rwby_tags
    { name: "RWBY",
      tags: %w(rwby) }
  end

  def monster_girls_tags
    { name: "Daily Life with Monster Girls",
      tags: %w(monster_musume_no_iru_nichijou) }
  end

  def mirai_nikki_tags
    { name: "Mirai Nikki",
      tags: %w(mirai_nikki) }
  end

  def splatoon_tags
    { name: "Splatoon",
      tags: choose_one_tag(%w(splatoon splatoon_2)) }
  end

  def zelda_tags
    { name: "Zelda",
      tags: %w(the_legend_of_zelda) }
  end

  def smash_bros_tags
    { name: "Super Smash Bros",
      tags: %w(super_smash_bros.) }
  end

  def pokemon_tags
    { name: "Pokemon",
      tags: with_optional_tags(%w(pokemon), %w(eevee umbreon espeon porygon)) }
  end

  def portrait_tags
    tags = ['simple_background'].push(%w(1boy 1girl).sample)

    { name: "Portrait",
      tags: tags }
  end

  def angel_tags
    { name: "Angel",
      tags: %w(angel wings) }
  end

  def glasses_tags
    { name: "Glasses",
      tags: with_optional_tags(%w(glasses), %w(1girl heart blush smile)) }
  end

  def random_tags
    { name: "Random",
      tags: %w(absurdres) }
  end

  private

  def tag_parameters(tags)
    "#{tags.map { |tag| tag.prepend('+') }.join('')}#{SFW}#{TYPES}#{SIZING}"
  end

  def gather_tags_for(group_name, tag_groups, number)
    tags = tag_groups.sample(number)

    presented_tags = tags.map do |item, all_tags|
      {
        label: "#{item[:name]} (#{group_name})",
        params: tag_parameters(item[:tags])
      }
    end
  end

  def choose_one_tag(tags)
    [tags.sample]
  end

  def with_optional_tags(tags, extra_tags)
    one_in_three = (rand(1..3) == 1)

    if one_in_three
      tags.push(extra_tags.sample)
    else
      tags
    end
  end
end
