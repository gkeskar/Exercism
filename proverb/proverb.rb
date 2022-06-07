class Proverb
  private

  attr_reader :things, :qualifier

  def initialize(*things, qualifier: '')
    @things = things
    @qualifier = qualifier
  end

  def repetative_pharses(things)
    phrase = "For want of a %s the %s was lost.\n" % [things.first, things.last]
    return phrase if things.length == 2
    repetative_pharses(things.take(2)) + repetative_pharses(things.drop(1))
  end

  def final_phrase(qualifier)
    first_object_of_chain = things.first
    if qualifier.empty? ? optional_qualifier = first_object_of_chain :
       optional_qualifier = "%s %s" %[qualifier, first_object_of_chain]
    end
    "And all for the want of a %s." %[optional_qualifier]
  end


  def phrases(*things)
    repetative_pharses(things) + final_phrase(qualifier)
  end

  public

  def to_s
    phrases(*things)
  end

end
