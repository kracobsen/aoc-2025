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
      number_string = num.to_s
      middle = number_string.length / 2
      if number_string[0...middle] == number_string[middle..]
        sum += num
      end
    end
  end
  puts sum
end

start("input.txt")
