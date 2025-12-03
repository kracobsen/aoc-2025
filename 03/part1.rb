def start(filename)
  sum = 0
  File.readlines(filename).each do |line|
    sum += joltage(line.chomp)
  end
  puts sum
end

def joltage(number_string)
  # Largest digit that is not the last digit and newline
  last_char_removed = number_string.chop
  digit_index = max_digit_and_index(last_char_removed)
  max_digit = digit_index[0]
  index = digit_index[1].to_i
  # Largest digit in substring
  max_second_digit = max_digit(number_string[index + 1..])
  "#{max_digit}#{max_second_digit}".to_i
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
