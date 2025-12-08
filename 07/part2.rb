def start(filename)
  manifold = []
  File.readlines(filename).each do |line|
    manifold.append(line.chomp.chars)
  end

  start = manifold.first.index("S")
  splitter_positions = get_position_of_splitters(manifold)
  puts travel(0, start, splitter_positions, manifold.length - 1)
end

def get_position_of_splitters(manifold)
  positions = []
  manifold.each_with_index do |line, x|
    line.each_with_index do |content, y|
      if content == "^"
        positions.append([x, y])
      end
    end
  end
  positions
end

def travel(x, y, splitters, bottom, cache = {})
  key = [x, y]
  return cache[key] if cache.key?(key)

  # Når slutten av en tidslinje
  if x >= bottom
    return 1
  end

  result = if splitters.include?([x + 1, y])
    travel(x + 1, y - 1, splitters, bottom, cache) + travel(x + 1, y + 1, splitters, bottom, cache)
  else
    travel(x + 1, y, splitters, bottom, cache)
  end

  cache[key] = result
  result
end

start("input.txt")
