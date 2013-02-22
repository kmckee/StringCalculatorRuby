class StringCalculator

  def self.add numbers
    split_numbers = split numbers  
    negatives = split_numbers.select { |x| x < 0 } 
    raise ArgumentError, "Negatives not allowed.  Received #{negatives.to_s}" unless negatives.length == 0
    valid_numbers = split_numbers.select { |x| x < 1000 }
    valid_numbers.inject(0) { |sum, n| sum + n }
  end
  
  def self.get_delimiter string
    if string.start_with?("//")
      if string[2] == "["
        return  string.scan(/\[([^\[\]]*)\]/).flatten
      else
        return [] << string[2]
      end
    end
    return []
  end

  private
  
  def self.split numbers
    replace_all_delimiters_with_commas(numbers).split(',').map { |x| x.to_i }
  end

  def self.replace_all_delimiters_with_commas numbers
    normalized_numbers = numbers.gsub("\n", ',')
    custom_delimiter = get_delimiter numbers
    custom_delimiter.each do |d|
      normalized_numbers.gsub!(d, ',') if d
    end if custom_delimiter
    normalized_numbers
  end
end
