class Bob

  def self.hey(remark)
    remark = remark.gsub(/['\d\s]/,"")
    if /^[A-Z]+\?$/.match(remark)
      "Calm down, I know what I'm doing!"
    elsif /^[\w\D]*\?$/.match(remark)
      "Sure."
    elsif /^[A-Z]+$/.match(remark.gsub(/\W/,""))
       "Whoa, chill out!"
    elsif /^$/.match(remark)
       "Fine. Be that way!"
    else
       "Whatever."
    end
  end

end
