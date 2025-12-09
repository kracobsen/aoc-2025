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
end

def start(filename)
  coords = []
  File.readlines(filename).each do |line|
    coord = line.chomp.split(",")

    coords.append(Coordinate.new(coord[0].to_i, coord[1].to_i))
  end

  max_rectangle = 0
  coords.each do |c1|
    coords.each do |c2|
      max_rectangle = [max_rectangle, c1.rectangle(c2).size].max
    end
  end

  puts max_rectangle
end

start("input.txt")
