def start(filename)
  problem_array = []
  File.readlines(filename).each do |line|
    puts line.length
    puts line.chop.length
    problem_array.append(line.chop.chars)
  end

  boundaries = find_problem_boundaries(problem_array)
  boundaries.append(problem_array.first.length)
  sum = 0
  start = 0
  boundaries.each do |stop|
    multiply = problem_array[problem_array.length - 1][start] == "*"
    problem_solution = 0
    (start...stop).each_with_index do |operand, idx|
      op = ""
      (0..problem_array.length - 1).each do |number|
        if !problem_array[number][operand].nil?
          op += problem_array[number][operand]
        end
      end
      op = op.to_i
      puts "OP: #{op}"
      if idx == 0
        problem_solution += op
      elsif multiply
        problem_solution *= op
      else
        problem_solution += op
      end
    end
    puts problem_solution
    sum += problem_solution
    start = stop + 1
  end
  puts sum
end

def find_problem_boundaries(problem_array)
  problem_bounds = []
  problem_array.first.each_with_index do |char, idx|
    if char == " "
      is_boundary = true
      (1...problem_array.length).each do |x|
        if problem_array[x][idx] != " "
          is_boundary = false
        end
      end
      if is_boundary
        problem_bounds.append(idx)
      end
    end
  end
  problem_bounds
end

start("input.txt")
