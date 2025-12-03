def start(filename)
  sum = 0
  File.readlines(filename).each do |line|
    joltage = joltage(line.chomp)
    sum += joltage
  end
  puts sum
end

def joltage(number_string)
  current_start_index = 0
  joltage = ""
  12.downto(1).each do |x|
    searchable_string = number_string[current_start_index..-x]
    index_and_digit = max_digit_and_index(searchable_string)
    joltage += index_and_digit[0].to_s
    current_start_index = index_and_digit[1] + current_start_index + 1
  end
  joltage.to_i
end

def max_digit_and_index(string)
  max_digit = max_digit(string)
  index = string.index(max_digit.to_s)
  [max_digit, index]
end

def max_digit(string)
  string.scan(/\d/).map(&:to_i).max
end
start("input.txt")
