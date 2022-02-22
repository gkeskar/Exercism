class ETL

  def self.transform(old)
    self.normalize_letters(old).invert
    .each_with_object({})  do |(letters, value), result|
      letters.each do |letter|
        result[letter] = value
      end
    end
  end

  def self.normalize_letters(old)
    old.transform_values!{|v| v.map(&:downcase)}
  end

end
