# Does not work
class Machine
  attr_accessor :initialization, :buttons, :joltage

  def initialize(initialization, buttons, joltage)
    @initialization = format_initialization(initialization)
    @buttons = format_buttons(buttons)
    @joltage = format_joltage(joltage)

    @max_presses = get_max_presses(@buttons, @joltage)
    @all_presses = get_all_presses(@max_presses)

    puts "#{@all_presses.length}"
  end

  def format_initialization(initialization)
    initialization[1..-2].chars.map { |char| char == " # " }
  end

  def format_buttons(buttons)
    buttons.map { |btn| btn[1..-2].split(",").map(&:to_i) }
  end

  def get_all_presses(max_presses)
    all_presses = []
    max_presses.each do |mp|
      mp["presses"].times do |x|
        all_presses.append(mp["buttons"])
      end
    end
    all_presses
  end

  def get_max_presses(buttons, joltage)
    max_presses = []
    buttons.each do |button|
      min = 1000
      button.each do |b|
        if joltage[b] < min
          min = joltage[b]
        end
      end
      max_presses.append({"presses" => min, "buttons" => button})
    end
    max_presses
  end

  def format_joltage(joltage)
    joltage[1..-2].split(",").map(&:to_i)
  end

  def find_smallest_amount_of_button_presses_to_get_joltage(depth = 200)
    current = joltage.max
    puts @all_presses.combination(current).to_a.length
    # while current <= depth
    #   puts "Trying depth #{current}"
    #   @buttons.combinations() do |button_combo|
    #     if try_combination_to_joltage(button_combo)
    #       return current
    #     end
    #   end
    #   current += 1
    # end
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

  def to_s
    "Init: #{@initialization} Buttons: #{@buttons} Joltage: #{@joltage}"
  end
end

def start(filename)
  # machines = []
  # File.readlines(filename).each do |line|
  #   machine = line.chomp.split(" ")

  #   machines.append(Machine.new(machine.first, machine[1..-2], machine.last))
  # end
  # sum = 0

  machine = File.readlines(filename).first.chomp.split(" ")

  puts Machine.new(machine.first, machine[1..-2], machine.last).find_smallest_amount_of_button_presses_to_get_joltage(200)
end

puts "Test"
start("input.txt")
# puts "Real Input"
# start("input.txt")
