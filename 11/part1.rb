class Node
  attr_accessor :name, :connections, :start, :out

  def initialize(name, connections)
    @name = name
    @start = @name == "you"
    @out = connections.include?("out")
    connections.delete("you")
    connections.delete("out")
    @connections = connections
  end

  def to_s
    "#{@name}: Start #{@start} Out #{@out} Connections #{@connections}"
  end

  def travel(nodes)
    if @out
      1
    else
      result = 0
      connections.each do |c|
        connection = nodes[c]
        result += connection.travel(nodes)
      end
      result
    end
  end
end

def start(filename)
  nodes = {}
  File.readlines(filename).each do |line|
    node = line.chomp.split(":")

    nodes[node[0]] = Node.new(node[0], node[1].split(" "))
  end
  starting = nodes.values.select(&:start)
  sum = 0
  starting.each do |n|
    sum += n.travel(nodes)
  end
  puts sum
end

start("input.txt")
