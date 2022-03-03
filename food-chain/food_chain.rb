class FoodChain
  require 'byebug'

  ANIMALS = {
    1 => 'fly',  2 => 'spider', 
    3 => 'bird', 4 => 'cat', 
    5 => 'dog',  6 => 'goat',
    7 => 'cow',  8 => 'horse'
  }.freeze

  ACTION = {
    'fly' => "I don't know why she swallowed the fly. Perhaps she'll die.",
    'spider' => "It wriggled and jiggled and tickled inside her.",
    'bird' => "How absurd to swallow a bird!",
    'cat' => "Imagine that, to swallow a cat!",
    'dog' => "What a hog, to swallow a dog!",
    'goat' => "Just opened her throat and swallowed a goat!",
    'cow' => "I don't know how she swallowed a cow!",
    'horse' => "She's dead, of course!"
  }.freeze

  def self.song
    (1..8).map do |number_of_stanzas|
      stanza(number_of_stanzas) + "\n"
    end.join
  end

  def self.first_two_lines(number)
    animal = ANIMALS[number]
    action = ACTION[animal]
    "I know an old lady who swallowed a #{animal}.\n#{action}"
  end

  def self.previous_lines(number)
    stanza(number - 1).gsub("\n" + first_two_lines(number - 1),"")
  end

  def self.stanza(number)
    if number == 1
      first_two_lines(1)
    elsif number == 8
      "\n" + first_two_lines(8)
    elsif number == 2
      "\n" + first_two_lines(number) + new_line(number) + "\n#{ACTION['fly']}"
    else
      "\n"  + first_two_lines(number) + new_line(number) + previous_lines(number)
    end
  end

  def self.new_line(number)
    animal = ANIMALS[number]
    previous_animal = ANIMALS[number - 1]
    action = ACTION[animal]
    previous_animal == 'spider' ?
      line2 = "\nShe swallowed the #{animal} to catch the spider that wriggled and jiggled and tickled inside her."
      : line2 = "\nShe swallowed the #{animal} to catch the #{previous_animal}."
  end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.song()
end
