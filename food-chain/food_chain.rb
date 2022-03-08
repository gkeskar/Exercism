class FoodChain

    OPENING_PHRASE = "I know an old lady who swallowed a"

    ANIMALS_AND_ACTIONS = {
      'fly' => "I don't know why she swallowed the fly. Perhaps she'll die.",
      'spider' => "wriggled and jiggled and tickled inside her.",
      'bird' => "How absurd to swallow a bird!",
      'cat' => "Imagine that, to swallow a cat!",
      'dog' => "What a hog, to swallow a dog!",
      'goat' => "Just opened her throat and swallowed a goat!",
      'cow' => "I don't know how she swallowed a cow!",
      'horse' => "She's dead, of course!"
    }

    def self.song
      new.to_s
    end

    def to_s
      (0..7).each_with_object("") do |number_of_stanzas, lines|
        lines << "%s\n\n" % [stanza(number_of_stanzas)]
      end.chomp
    end


    def first_two_lines(number)
      animal = ANIMALS_AND_ACTIONS.keys[number]
      action = animal == 'spider' ? "It " + ANIMALS_AND_ACTIONS['spider'] : action = ANIMALS_AND_ACTIONS[animal]
      "%s %s.\n%s" % [OPENING_PHRASE, animal, action]
    end

    def third_line(number)
      return "" if ( number == 0 || number == 7 )
      animal = ANIMALS_AND_ACTIONS.keys[number]
      previous_animal = ANIMALS_AND_ACTIONS.keys[number - 1]
      action = ANIMALS_AND_ACTIONS[animal]
      opening_phrase = "She swallowed the #{animal} to catch the #{previous_animal}"
      spider_phrase = "that #{ANIMALS_AND_ACTIONS['spider']}"
      previous_animal == 'spider' ?
        "\n%s %s" % [opening_phrase, spider_phrase] : "\n%s." % [opening_phrase]
    end

    def cumulative_lines(number)
      return "" if ( number == 0 || number == 7 )
      return  "\n%s" % [ANIMALS_AND_ACTIONS['fly']] if number == 1
      lines = number.downto(2).each_with_object("") do | number_of_stanzas, result |
        result << third_line(number_of_stanzas - 1)
      end
      "%s\n%s" % [lines, ANIMALS_AND_ACTIONS['fly']]
    end

    def stanza(number)
      first_two_lines(number) + third_line(number) + cumulative_lines(number)
    end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.song
end
