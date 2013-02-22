class StringCalculator

  def self.add numbers
    split_numbers = split numbers  
    negatives = split_numbers.select { |x| x < 0 } 
    raise ArgumentError, "Negatives not allowed.  Received #{negatives.to_s}" unless negatives.length == 0
    valid_numbers = split_numbers.select { |x| x < 1000 }
    valid_numbers.inject(0) { |sum, n| sum + n }
  end
  
  def self.get_delimiters_for string
    delims = ["\n", ","]
    if string.start_with?("//")
      if string[2] == "["
        delims.concat(string.scan(/\[([^\[\]]*)\]/).flatten)
      else
        delims << string[2]
      end
    end
    delims
  end

  private
  
  def self.split numbers
    replace_all_delimiters_with_commas(numbers).split(',').map { |x| x.to_i }
  end

  def self.replace_all_delimiters_with_commas numbers
    get_delimiters_for(numbers).each do |d|
      numbers.gsub!(d, ',') if d
    end
    numbers
  end
end
