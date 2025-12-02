def start(filename)
  line = File.readlines(filename).first
  parts = line.split(",")
  parse_ranges(parts)
end

def parse_ranges(ranges)
  sum = 0
  ranges.each do |range|
    split = range.split("-")
    start = split[0].to_i
    stop = split[1].to_i
    (start..stop).each do |num|
      if repeated_pattern?(num.to_s)
        puts num
        sum += num
      end
    end
  end
  puts sum
end

def repeated_pattern?(number_string)
  repeated = false
  (2..number_string.length).each do |parts|
    next if number_string.length % parts != 0
    string_parts = divide_string(number_string, parts)
    if string_parts.all? { |s| s == string_parts[0] }
      repeated = true
    end
  end
  repeated
end

def divide_string(string, parts)
  size = string.length / parts
  (0...parts).map { |i| string[i * size, size] }
end

start("input.txt")
