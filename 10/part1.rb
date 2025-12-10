class Machine
  attr_accessor :initialization, :buttons, :joltage

  def initialize(initialization, buttons, joltage)
    @initialization = format_initialization(initialization)
    @buttons = format_buttons(buttons)
    @joltage = format_joltage(joltage)
  end

  def format_initialization(initialization)
    initialization[1..-2].chars.map { |char| char == "#" }
  end

  def format_buttons(buttons)
    buttons.map { |btn| btn[1..-2].split(",").map(&:to_i) }
  end

  def format_joltage(joltage)
    joltage[1..-2].split(",").map(&:to_i)
  end

  def find_smallest_amount_of_button_presses_to_get_joltage(depth = 200)
    current = joltage.max
    while current <= depth
      puts "Trying depth #{current}"
      @buttons.repeated_combination(current).to_a.each do |button_combo|
        if try_combination_to_joltage(button_combo)
          return current
        end
      end
      current += 1
    end
    nil
  end

  def try_combination_to_joltage(button_combo)
    current_joltage = @joltage.map { 0 }
    button_combo.each do |buttons|
      buttons.each do |button|
        current_joltage[button] = current_joltage[button] + 1
      end
    end
    current_joltage == @joltage
  end

  def find_smallest_amount_of_button_presses_to_initialize(depth)
    current = 1
    while current <= depth
      @buttons.combination(current).to_a.each do |button_combo|
        if try_combination(button_combo)
          return current
        end
      end
      current += 1
    end
    nil
  end

  def try_combination_to_initialize(button_combo)
    lights = @initialization.map { false }
    button_combo.each do |buttons|
      buttons.each do |button|
        lights[button] = !lights[button]
      end
    end
    lights == @initialization
  end

  def to_s
    "Init: #{@initialization} Buttons: #{@buttons} Joltage: #{@joltage}"
  end
end

def start(filename)
  machines = []
  File.readlines(filename).each do |line|
    machine = line.chomp.split(" ")

    machines.append(Machine.new(machine.first, machine[1..-2], machine.last))
  end
  sum = 0
  machines.each_with_index do |m, i|
    puts "Check Machine #{i}"

    sum += m.find_smallest_amount_of_button_presses_to_get_joltage
  end
  puts sum
end

puts "Test"
start("test.txt")
puts "Real Input"
start("input.txt")
