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

class Line
  attr_accessor :from, :to, :direction

  def initialize(from, to, direction)
    @from = from
    @to = to
    @direction = direction
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

  def line_intersects?(line)
    min_x = [@x1, @x2].min
    max_x = [@x1, @x2].max
    min_y = [@y1, @y2].min
    max_y = [@y1, @y2].max
    intersects = false

    if !(line.from.y >= min_y || line.to.y <= max_y || line.from.x >= min_x || line.to.x <= max_x)
      intersects = true
    end
    intersects
  end

  def lines_intersect?(lines)
    lines.any? { |line| line_intersects?(line) }
  end
end

def start(filename)
  coords = []
  File.readlines(filename).each do |line|
    coord = line.chomp.split(",")

    coords.append(Coordinate.new(coord[0].to_i, coord[1].to_i))
  end

  lines = create_straight_lines(coords)
  lines.each do |line|
    puts "(#{line.from.x},#{line.from.y}) to (#{line.to.x},#{line.to.y}) - #{line.direction}"
  end
  rectangle = Rectangle.new(11, 1, 2, 5)
  puts rectangle.size
  puts rectangle.lines_intersect?(lines)
  # puts find_max_rectangle(coords, lines)
end

def create_straight_lines(coords)
  lines = []

  coords.each_with_index do |coord, i|
    next_coord = coords[(i + 1) % coords.length]

    # Determine direction and create line
    # Always set from as the lowest coordinate in the direction
    if coord.x == next_coord.x
      # Vertical line: from should have lower y value
      from_coord = (coord.y < next_coord.y) ? coord : next_coord
      to_coord = (coord.y < next_coord.y) ? next_coord : coord
      lines << Line.new(from_coord, to_coord, :vertical)
    elsif coord.y == next_coord.y
      # Horizontal line: from should have lower x value
      from_coord = (coord.x < next_coord.x) ? coord : next_coord
      to_coord = (coord.x < next_coord.x) ? next_coord : coord
      lines << Line.new(from_coord, to_coord, :horizontal)
    end
  end

  lines
end

def find_max_rectangle(coords, lines)
  max_rectangle = 0
  coords.each do |c1|
    coords.each do |c2|
      rectangle = c1.rectangle(c2)
      size = rectangle.size
      if size == 50
        puts "#{rectangle.size}: #{c1.x},#{c1.y} #{c2.x},#{c2.y}"
      end

      if size > max_rectangle && !rectangle.lines_intersect?(lines)
        max_rectangle = size
      end
    end
  end
  max_rectangle
end
start("test.txt")
