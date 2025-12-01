def start(file)
  pos = 50
  sum = 0
  File.readlines(file).each do |line|
    number = line[1..-1].to_i
    pos_tuple = if line.start_with?("L")
      rotate_left(pos, number)
    else
      rotate_right(pos, number)
    end
    pos = pos_tuple[0]
    sum += pos_tuple[1]
    puts pos
  end
  puts "Number of zeroes: " + sum.to_s
end

def rotate_right(pos, times)
  click = 0
  while times > 0
    pos += 1
    if pos == 100
      pos = 0
    end
    if pos == 0
      click += 1
    end
    times -= 1
  end
  [pos, click]
end

def rotate_left(pos, times)
  click = 0
  while times > 0
    pos -= 1
    if pos == -1
      pos = 99
    end
    if pos == 0
      click += 1
    end
    times -= 1
  end
  [pos, click]
end

start("input.txt")
