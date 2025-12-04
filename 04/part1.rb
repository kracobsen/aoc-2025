def start(filename)
  paper_roll_shelf = []
  sum = 0
  File.readlines(filename).each do |line|
    paper_roll_shelf.append(line.chomp.chars)
  end
  paper_roll_shelf.each_with_index do |shelf, x|
    shelf.each_with_index do |roll, y|
      if check_pos(x, y, paper_roll_shelf)
        sum += 1
      end
    end
  end
  puts sum
end

def check_pos(x, y, arr)
  return false if arr[x][y] != "@"
  total = 0
  total += 1 if is_pos_roll(x - 1, y - 1, arr)
  total += 1 if is_pos_roll(x, y - 1, arr)
  total += 1 if is_pos_roll(x + 1, y - 1, arr)
  total += 1 if is_pos_roll(x - 1, y, arr)
  total += 1 if is_pos_roll(x + 1, y, arr)
  total += 1 if is_pos_roll(x - 1, y + 1, arr)
  total += 1 if is_pos_roll(x, y + 1, arr)
  total += 1 if is_pos_roll(x + 1, y + 1, arr)

  if total < 4
    puts "x: #{x} y:#{y}"
    true
  end
end

def is_pos_roll(x, y, arr)
  return false if x < 0 || y < 0 || x >= arr.length || y >= arr.length
  arr[x][y] == "@"
end

start("input.txt")
