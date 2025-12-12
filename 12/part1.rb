class Tree
  attr_accessor :size, :number_of_packages, :capacity

  def initialize(dim, number_of_packages)
    x, y = dim.split("x")
    @size = x.to_i * y.to_i
    @capacity = (x.to_i / 3) * (y.to_i / 3)
    @number_of_packages = number_of_packages.map { |p| p.to_i }
  end

  def sum_of_packages
    number_of_packages.sum
  end

  def fits_all?
    sum_of_packages <= @capacity
  end
end

def start(filename)
  trees = []
  File.readlines(filename).each_with_index do |line, i|
    next if i < 30
    puts line

    tree = line.chomp.split(":")

    trees.append(Tree.new(tree[0], tree[1].split(" ")))
  end

  sum = 0

  trees.each do |tree|
    puts "#{tree.size} #{tree.sum_of_packages} #{tree.capacity} #{tree.fits_all?}"
    if tree.fits_all?
      sum += 1
    end
  end

  puts sum
end

start("input.txt")
