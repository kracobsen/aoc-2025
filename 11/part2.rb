class Node
  attr_accessor :name, :connections, :start, :out

  def initialize(name, connections)
    @name = name
    @start = @name == "you"
    @out = connections.include?("out")
    connections.delete("out")
    @connections = connections
  end

  def to_s
    "#{@name}: Start #{@start} Out #{@out} Connections #{@connections}"
  end

  def travel(nodes, visited_dac, visited_fft, cache = {})
    key = [@name, visited_dac, visited_fft]
    return cache[key] if cache.key?(key)

    if @name == "dac"
      visited_dac = true
    end

    if @name == "fft"
      visited_fft = true
    end

    result = 0

    if @out
      if visited_dac && visited_fft
        1
      else
        0
      end
    else
      result = 0
      connections.each do |c|
        connection = nodes[c]
        result += connection.travel(nodes, visited_dac, visited_fft, cache)
      end
      cache[key] = result
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
  server = nodes["svr"]
  puts server.travel(nodes, false, false)
end

start("input.txt")
