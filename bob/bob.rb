class Bob

  def self.hey(remark)
    remark = remark.gsub(/['\d\s+]/,"")
    if /^[A-Z]+\?$/.match(remark)
      "Calm down, I know what I'm doing!"
    elsif remark.end_with?('?')
      "Sure."
    elsif /^[A-Z]+$/.match(remark.gsub(/\W/,""))
       "Whoa, chill out!"
    elsif remark.empty?
       "Fine. Be that way!"
    else
       "Whatever."
    end
  end

end
