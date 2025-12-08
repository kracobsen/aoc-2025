class JunctionBox
  attr_accessor :x, :y, :z, :distances

  def initialize(x = 0, y = 0, z = 0)
    @x = x
    @y = y
    @z = z
    @distances = {}
  end

  def to_s
    "#{@x},#{@y},#{@z}"
  end

  def calculate_distances(other_boxes)
    other_boxes.each do |other_box|
      next if to_s == other_box.to_s
      @distances[other_box.to_s] = distance(other_box)
    end
  end

  def distance(other_box)
    coord_diff = ((@x - other_box.x)**2) + ((@y - other_box.y)**2) + ((@z - other_box.z)**2)
    Math.sqrt(coord_diff)
  end
end

class Vector
  attr_accessor :a, :b, :distance

  def initialize(a, b, distance)
    @a = a
    @b = b
    @distance = distance
  end

  def to_s
    "#{a}, #{b}: #{distance}"
  end
end

def start(filename, connections)
  boxes = []
  File.readlines(filename).each do |line|
    coords = line.chomp.split(",")

    boxes.append(JunctionBox.new(coords[0].to_i, coords[1].to_i, coords[2].to_i))
  end

  boxes.each do |box|
    box.calculate_distances(boxes)
  end

  all_distances = []

  boxes.each do |box|
    box.distances.each do |key, value|
      all_distances.append(Vector.new(box.to_s, key, value))
    end
  end
  sorted = all_distances.sort_by { |v| v.distance }
  sorted = sorted.uniq { |v| [v.a, v.b].sort }

  connected_sets = []

  top_connections = sorted
  final_vector = nil
  top_connections.each do |vector|
    if connected_sets.length == 1 && connected_sets.first.length == connections - 1
      final_vector = vector
    end
    set_a = connected_sets.find { |s| s.include?(vector.a) }
    set_b = connected_sets.find { |s| s.include?(vector.b) }

    if set_a && set_b
      # Slå sammen set hvis den finnes i begge sett
      if set_a != set_b
        set_a.merge(set_b)
        connected_sets.delete(set_b)
      end
    elsif set_a
      set_a.add(vector.b)
    elsif set_b
      set_b.add(vector.a)
    else
      connected_sets << Set.new([vector.a, vector.b])
    end
  end
  # idioti
  puts final_vector.a.split(",")[0].to_i * final_vector.b.split(",")[0].to_i
end

start("input.txt", 1000)
