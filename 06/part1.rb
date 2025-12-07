def start(filename)
  problem_array = []
  File.readlines(filename).each do |line|
    problem_array.append(line.split(/\s+/))
  end
  sum = 0
  number_of_problems = problem_array.first.length
  (0...number_of_problems).each do |problem|
    multiply = problem_array[-1][problem] == "*"
    problem_solution = 0
    (0...problem_array.length - 1).each_with_index do |operand_pos, idx|
      operand = problem_array[operand_pos][problem].to_i
      if idx == 0
        problem_solution += operand
      elsif multiply
        problem_solution *= operand
      else
        problem_solution += operand
      end
      puts operand
    end
    sum += problem_solution
  end
  puts sum
end

start("test.txt")
