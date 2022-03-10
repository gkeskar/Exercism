class FoodChain

    OPENING_PHRASE = "I know an old lady who swallowed a"

    ANIMAL_PHRASE_PREFIX = 'She swallowed the %<animal>s to catch the %<prior_animal>s'

    ANIMALS_AND_ACTIONS = {
      'fly'     => "I don't know why she swallowed the fly. Perhaps she'll die.",
      'spider'  => "It wriggled and jiggled and tickled inside her.",
      'bird'    => "How absurd to swallow a bird!",
      'cat'     => "Imagine that, to swallow a cat!",
      'dog'     => "What a hog, to swallow a dog!",
      'goat'    => "Just opened her throat and swallowed a goat!",
      'cow'     => "I don't know how she swallowed a cow!",
      'horse'   => "She's dead, of course!"
    }

    def self.song
      new.to_s
    end

    private

    def first_two_lines(number)
      animal = ANIMALS_AND_ACTIONS.keys[number]
      action = ANIMALS_AND_ACTIONS[animal]
      "%s %s.\n%s" % [OPENING_PHRASE, animal, action]
    end

    def third_line_suffix_for_animal?(animal)
       animal == 'spider'
    end

    def third_line_suffix(animal)
      return ANIMALS_AND_ACTIONS[animal].gsub("It","that") if animal == 'spider'
    end

    def cumulative_lines(number)
      return "" if number == 0 || number == ANIMALS_AND_ACTIONS.length - 1
      lines = number.downto(1).each_with_object("") do | number_of_stanzas, result |
        animal = ANIMALS_AND_ACTIONS.keys[number_of_stanzas]
        prior_animal = ANIMALS_AND_ACTIONS.keys[number_of_stanzas - 1]
        action = ANIMALS_AND_ACTIONS[animal]
        second_line = (number)
        third_line_prefix = ANIMAL_PHRASE_PREFIX % {animal: animal, prior_animal: prior_animal}
        third_line_suffix_for_animal?(prior_animal) ?
          third_line = "%s %s" % [third_line_prefix,third_line_suffix(prior_animal)] : third_line = third_line_prefix
        result << "\n%s." % [third_line.chomp('.')]
      end
      "%s\n%s" % [lines, ANIMALS_AND_ACTIONS['fly']]
    end

    def stanza(number)
      first_two_lines(number) << cumulative_lines(number)
    end

    public

    def to_s
      ANIMALS_AND_ACTIONS.length.times.each_with_object("") do |number_of_stanzas, lines|
        lines << "%s\n\n" % [stanza(number_of_stanzas)]
      end.chomp
    end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.new
end
