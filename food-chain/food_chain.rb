class FoodChain

  NEW_LINE = "\n"

  OPENING_LINE = "I know an old lady who swallowed a"

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
      stanza(number_of_stanzas) + NEW_LINE
    end.join
  end

  def self.first_two_lines(number)
    animal = ANIMALS[number]
    action = ACTION[animal]
    "#{OPENING_LINE} #{animal}." + NEW_LINE + "#{action}"
  end

  def self.third_line(number)
    animal = ANIMALS[number]
    previous_animal = ANIMALS[number - 1]
    action = ACTION[animal]
    previous_animal == 'spider' ?
      "\nShe swallowed the #{animal} to catch the spider that wriggled and jiggled and tickled inside her."
      : "\nShe swallowed the #{animal} to catch the #{previous_animal}."
  end

  def self.all_other_lines(number)
    stanza(number - 1).gsub(NEW_LINE + first_two_lines(number - 1),"")
  end

  def self.stanza(number)
    case number

    when 1
      first_two_lines(1)
    when 8
      NEW_LINE + first_two_lines(8)
    when 2
      NEW_LINE + first_two_lines(number) + third_line(number) + "\n#{ACTION['fly']}"
    else
      NEW_LINE  + first_two_lines(number) + third_line(number) + all_other_lines(number)
    end
  end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.song()
end
