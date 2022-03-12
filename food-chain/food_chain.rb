class FoodChain

    OPENING_PHRASE = "I know an old lady who swallowed a"
    ANIMAL_PHRASE_PREFIX = 'She swallowed the %<animal>s to catch the %<prior_animal>s'
    Animal = Struct.new(:type, :action)
    ANIMALS = [
      Animal.new("fly", "I don't know why she swallowed the fly. Perhaps she'll die."),
      Animal.new("spider", "It wriggled and jiggled and tickled inside her."),
      Animal.new("bird", "How absurd to swallow a bird!"),
      Animal.new("cat", "Imagine that, to swallow a cat!"),
      Animal.new("dog", "What a hog, to swallow a dog!"),
      Animal.new("goat", "Just opened her throat and swallowed a goat!"),
      Animal.new("cow", "I don't know how she swallowed a cow!"),
      Animal.new("horse", "She's dead, of course!"),
    ]

    def self.song
      new.to_s
    end

    private

    def animal(number)
      ANIMALS[number].type
    end

    def prior_animal(number)
      ANIMALS[number - 1].type
    end

    def action(number)
      ANIMALS[number].action
    end

    def prior_animal_action(number)
      ANIMALS[number - 1].action
    end

    def first_two_lines(number)
      "%s %s.\n%s" % [OPENING_PHRASE, animal(number), action(number)]
    end

    def third_line_prefix(number)
      ANIMAL_PHRASE_PREFIX % {animal: animal(number), prior_animal: prior_animal(number)}
    end

    def third_line_suffix(number)
      prior_animal(number) == 'spider' ? prior_animal_action(number).sub('It','that') : ''
    end

    def third_line(number)
      ("%s %s" % [third_line_prefix(number),third_line_suffix(number)]).strip.chomp('.')
    end

    def should_include_cumulative_lines?(number)
      (1..ANIMALS.length - 2).include?(number)
    end

    def cumulative_lines(number)
      return '' unless should_include_cumulative_lines?(number)
      number.downto(1).each_with_object(lines = '') do | stanza |
        lines << "\n%s." % [third_line(stanza)]
      end
      "%s\n%s" % [lines, action(0)]
    end

    def stanza(number)
      first_two_lines(number) << cumulative_lines(number)
    end

    public

    def song
      ANIMALS.length.times.each_with_object('') do |z, lines|
        lines << "%s\n\n" % [stanza(z)]
      end.chomp
    end

    def to_s
      song.to_s
    end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.new
end
