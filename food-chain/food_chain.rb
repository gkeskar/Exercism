class FoodChain

  OPENING_PHRASE = "I know an old lady who swallowed a"

  ANIMALS = [ 'fly', 'spider', 'bird', 'cat', 'dog', 'goat','cow', 'horse' ]

  ACTION = {
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
     total_stanzas = 8
    (0..total_stanzas - 1).map do |number_of_stanzas|
      "%s\n" % [stanza(number_of_stanzas)]
    end.join
  end

  def self.first_two_lines(number)
    animal = ANIMALS[number]
      action = animal == 'spider' ? "It " + ACTION['spider'] : action = ACTION[animal]
    "%s %s.\n%s" % [OPENING_PHRASE, animal, action]
  end

  def self.third_line(number)
    animal = ANIMALS[number]
    previous_animal = ANIMALS[number - 1]
    action = ACTION[animal]
    opening_phrase = "She swallowed the #{animal} to catch the #{previous_animal}"
    spider_phrase = "that #{ACTION['spider']}"
    previous_animal == 'spider' ?
      "\n%s %s" % [opening_phrase, spider_phrase] : "\n%s." % [opening_phrase]
  end

  def self.cumulative_lines(number)
    lines = number.downto(2).each_with_object("") do | number_of_stanzas, result |
      result << third_line(number_of_stanzas - 1)
    end
    "%s" "\n%s" % [lines, ACTION['fly']]
  end

  def self.stanza(number)
    case number

    when 0
      first_two_lines(number)
    when 1
      "\n%s" "%s" "\n%s" % [first_two_lines(number), third_line(number), ACTION['fly']]
    when 2..6
       "\n%s" "%s" "%s" % [first_two_lines(number), third_line(number), cumulative_lines(number)]
    when 7
      "\n%s" % [first_two_lines(number)]
    end
  end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.song()
end
