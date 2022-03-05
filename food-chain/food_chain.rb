class FoodChain

  OPENING_PHRASE = "I know an old lady who swallowed a"

  ANIMALS = {
    1 => 'fly',  2 => 'spider', 
    3 => 'bird', 4 => 'cat', 
    5 => 'dog',  6 => 'goat',
    7 => 'cow',  8 => 'horse'
  }.freeze

  ACTION = {
    'fly' => "I don't know why she swallowed the fly. Perhaps she'll die.",
    'spider' => "wriggled and jiggled and tickled inside her.",
    'bird' => "How absurd to swallow a bird!",
    'cat' => "Imagine that, to swallow a cat!",
    'dog' => "What a hog, to swallow a dog!",
    'goat' => "Just opened her throat and swallowed a goat!",
    'cow' => "I don't know how she swallowed a cow!",
    'horse' => "She's dead, of course!"
  }.freeze

  def self.song
    (1..8).map do |number_of_stanzas|
      "%s\n" % [stanza(number_of_stanzas)]
    end.join
  end

  def self.first_two_lines(number)
    animal = ANIMALS[number]
    animal == 'spider' ?
      action = "It " + ACTION['spider'] : action = ACTION[animal]
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
    stanza(number - 1).gsub( "\n%s" % [first_two_lines(number - 1)],"")
  end

  def self.stanza(number)
    case number

    when 1
      first_two_lines(1)
    when 8
      "\n%s" % [first_two_lines(8)]
    when 2
      "\n%s" "%s" "\n%s" % [first_two_lines(2), third_line(2), ACTION['fly']]
    else
       "\n%s" "%s" "%s" % [first_two_lines(number), third_line(number), cumulative_lines(number)]
    end
  end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.song()
end
