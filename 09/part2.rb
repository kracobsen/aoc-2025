class Coordinate
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def rectangle(c2)
    Rectangle.new(x, y, c2.x, c2.y)
  end
end

class Rectangle
  attr_accessor :x1, :x2, :y1, :y2

  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def size
    min_x = [@x1, @x2].min
    max_x = [@x1, @x2].max
    min_y = [@y1, @y2].min
    max_y = [@y1, @y2].max
    (max_x - min_x + 1) * (max_y - min_y + 1)
  end

  def inside_area?(coords)
    # Calculate rectangle bounds
    min_x = [@x1, @x2].min
    max_x = [@x1, @x2].max
    min_y = [@y1, @y2].min
    max_y = [@y1, @y2].max

    # Create closed loop by adding first coordinate at the end
    coords_with_wrap = coords + [coords.first]

    # Check each edge of the polygon formed by coordinates
    coords_with_wrap.each_cons(2) do |coord1, coord2|
      lx1, ly1 = coord1.x, coord1.y
      lx2, ly2 = coord2.x, coord2.y

      # Check if line segment overlaps with rectangle
      # Line overlaps if it's NOT completely outside (to left, right, above, or below)
      # If line overlaps, rectangle is not fully inside the polygon
      unless [lx1, lx2].max <= min_x || max_x <= [lx1, lx2].min ||
          [ly1, ly2].max <= min_y || max_y <= [ly1, ly2].min
        return false  # Line overlaps rectangle, so rectangle is not inside
      end
    end

    # All edges don't overlap rectangle, so rectangle is inside the polygon
    true
  end
end

def start(filename)
  coords = []
  File.readlines(filename).each do |line|
    coord = line.chomp.split(",")

    coords.append(Coordinate.new(coord[0].to_i, coord[1].to_i))
  end

  puts find_max_rectangle(coords)
end

def find_max_rectangle(coords)
  max_rectangle = 0
  coords.each do |c1|
    coords.each do |c2|
      rectangle = c1.rectangle(c2)
      size = rectangle.size
      if size > max_rectangle && rectangle.inside_area?(coords)
        max_rectangle = size
      end
    end
  end
  max_rectangle
end
start("input.txt")
