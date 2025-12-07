def start(filename)
  sum = 0
  ranges = []
  reading_ranges = true
  File.readlines(filename).each do |line|
    if line.chomp.empty?
      puts "swith"
      reading_ranges = false
      next
    end
    if reading_ranges
      add_ranges(line, ranges)
    elsif in_range?(line, ranges)
      sum += 1
    end
  end
  puts sum
end

def add_ranges(line, ranges)
  parts = line.chomp.split("-")
  start = parts[0].to_i
  stop = parts[1].to_i
  ranges.append([start, stop])
end

def in_range?(line, ranges)
  num = line.chomp.to_i
  puts num
  ranges.each do |range|
    if num >= range[0] && num <= range[1]
      return true
    end
  end
  false
end

start("input.txt")
