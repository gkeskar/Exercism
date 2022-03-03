class FoodChain
  require 'byebug'

  ANIMALS = {
    1 => 'fly',  2 => 'spider', 
    3 => 'bird', 4 => 'cat', 
    5 => 'dog',  6 => 'goat',
    7 => 'cow',  8 => 'horse'
  }

  ACTION = {
    'fly' => "Perhaps she'll die.",
    'spider' => "It wriggled and jiggled and tickled inside her.",
    'bird' => "How absurd to swallow a bird!",
    'cat' => "Imagine that, to swallow a cat!",
    'dog' => "What a hog, to swallow a dog!",
    'goat' => "Just opened her throat and swallowed a goat!",
    'cow' => "I don't know how she swallowed a cow!",
    'horse' => "She's dead, of course!"
  }

  def self.song
    (1..8).map do |number_of_stanzas|
      if number_of_stanzas == 1
        first_stanza + "\n"
      else
        stanza(number_of_stanzas) + "\n"
      end
    end.join
  end

  def self.first_stanza
    first_line = "I know an old lady who swallowed a fly."
    first_line_action = "\nI don't know why she swallowed the fly. Perhaps she'll die."
    first_line + first_line_action
  end


  def self.stanza(number)
    first_line_action = "\nI don't know why she swallowed the fly. Perhaps she'll die."
    last_line = "I know an old lady who swallowed a horse.\nShe's dead, of course!"
    return if number == 1
    if number == 2
      add_new_line1(number) + add_new_line2(number) + (first_line_action)
    elsif number == 8
      "\n" + last_line
    else
      (add_new_line1(number) + add_new_line2(number) + (stanza(number - 1))).gsub(add_new_line1(number - 1),"")
    end
  end

  def self.add_new_line1(number)
    return if number == 1
    animal = ANIMALS[number]
    previous_animal = ANIMALS[number - 1]
    action = ACTION[animal]
    line1 = "\nI know an old lady who swallowed a #{animal}." + "\n#{action}"
  end

  def self.add_new_line2(number)
    return if number == 1
    animal = ANIMALS[number]
    previous_animal = ANIMALS[number - 1]
    action = ACTION[animal]
    if previous_animal == 'spider'
      line2 = "\nShe swallowed the #{animal} to catch the spider that wriggled and jiggled and tickled inside her."
    else
      line2 = "\nShe swallowed the #{animal} to catch the #{previous_animal}."
    end
  end

end

if $PROGRAM_NAME == __FILE__
  puts FoodChain.song()
end
