class Bob

  def self.hey(remark)
    # require 'byebug';byebug
    remark = remark.gsub(/['\d\s]/,"")
    case remark
    when /^[A-Z]+\?$/ then "Calm down, I know what I'm doing!"
    when  /^[\w\D]*\?$/ then "Sure."
    when -> (remark) { /^[A-Z]+$/.match(remark.gsub(/\W/,"")) } then "Whoa, chill out!"
    when  /^$/ then "Fine. Be that way!"
    else
       "Whatever."
    end
  end

end
