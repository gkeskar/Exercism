class Proverb

  private

  attr_reader :objects, :qualifier

  def initialize(*objects, qualifier: '')
    @objects = objects
    @qualifier = qualifier
  end

  def cause_effect_pairs
    objects.each.with_index.reduce([]) do |cause_effect_pair, (value, index)|
      if objects.slice(index, 2).length == 2
        cause_effect_pair  << objects.slice(index, 2)
      end
      cause_effect_pair
    end
  end

  def phrases(object_pairs)
    phrases = object_pairs.reduce("") do  |phrase, object_pair|
      cause = object_pair.first
      effect = object_pair.last
      phrase << "For want of a %s the %s was lost.\n" % [cause, effect]
    end
    first_object_of_chain = object_pairs.first.first
    if qualifier.empty? ? optional_qualifier = first_object_of_chain :
        optional_qualifier = "%s %s" %[qualifier, first_object_of_chain]
    end
    final_phrase = "And all for the want of a %s." %[optional_qualifier]
    phrases + final_phrase
  end

  public

  def to_s
    phrases(cause_effect_pairs)
  end

end
