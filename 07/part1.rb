def start(filename)
  manifold = []
  File.readlines(filename).each do |line|
    manifold.append(line.chomp.chars)
  end

  puts "Manifold Size: #{manifold.first.length} X #{manifold.length}"
  splits = []
  travel(0, 70, manifold, splits)

  print_manifold(manifold)
  puts splits.length
end

def travel(height, width, manifold, splits)
  if height >= manifold.length - 1
    return
  end
  puts height
  if manifold[height + 1][width] == "^"
    splits.append(1)
    if manifold[height + 1][width - 1] != "|"
      manifold[height + 1][width - 1] = "|"
      travel(height + 1, width - 1, manifold, splits)
    end
    if manifold[height + 1][width + 1] != "|"
      manifold[height + 1][width + 1] = "|"
      travel(height + 1, width + 1, manifold, splits)
    end
  elsif manifold[height + 1][width] == "."
    manifold[height + 1][width] = "|"
    travel(height + 1, width, manifold, splits)
  end
end

def print_manifold(manifold)
  manifold.each do |m|
    m.each do |p|
      print p
    end
    puts
  end
end

start("input.txt")
