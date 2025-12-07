def start(filename)
  reading_ranges = true
  ranges = []
  File.readlines(filename).each do |line|
    if line.chomp.empty?
      puts "swith"
      reading_ranges = false
      next
    end
    if reading_ranges
      add_ranges(line, ranges)
    else
      break
    end
  end
  sorted_ranges = sort_ranges(ranges)
  sorted_ranges.each do |range|
    puts "Start: #{range[0]} Stop: #{range[1]}"
  end
  merged_ranges = merge_ranges(sorted_ranges)
  total_range_size = 0
  merged_ranges.each do |range|
    total_range_size += range_size(range)
    puts "Start: #{range[0]} Stop: #{range[1]}"
  end
  puts total_range_size
end

def merge_ranges(ranges)
  merged = [ranges[0]]

  ranges[1..-1].each do |current|
    last = merged[-1]

    if current[0] <= last[1]
      merged[-1] = [last[0], [last[1], current[1]].max]
    else
      merged << current
    end
  end

  merged
end

def sort_ranges(ranges)
  ranges.sort_by { |range| range[0] }
end

def range_size(range)
  start = range[0].to_i
  stop = range[1].to_i
  stop - start + 1
end

def add_ranges(line, ranges)
  parts = line.chomp.split("-")
  start = parts[0].to_i
  stop = parts[1].to_i
  ranges.append([start, stop])
end

start("input.txt")
