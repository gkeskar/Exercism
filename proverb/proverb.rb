class Proverb

  private

  attr_reader :things, :qualifier

  def initialize(*things, qualifier: '')
    @things = things
    @qualifier = qualifier
  end

  def cause_and_effect
    things.each_with_index.reduce([]) do |cause_effect_pair, (_, index)|
      if things.slice(index, 2).length == 2
        cause_effect_pair  << things.slice(index, 2)
      end
      cause_effect_pair
    end
  end

  def phrases(pair_of_things)
    phrases = pair_of_things.reduce("") do  |phrase, things|
      cause = things.first
      effect = things.last
      phrase << "For want of a %s the %s was lost.\n" % [cause, effect]
    end
    first_object_of_chain = pair_of_things.first.first
    if qualifier.empty? ? optional_qualifier = first_object_of_chain :
      optional_qualifier = "%s %s" %[qualifier, first_object_of_chain]
    end
    final_phrase = "And all for the want of a %s." %[optional_qualifier]
    phrases + final_phrase
  end

  public

  def to_s
    phrases(cause_and_effect)
  end

end
