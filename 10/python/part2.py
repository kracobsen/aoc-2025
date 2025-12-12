from scipy.optimize import linprog

total_presses = 0

with open('input.txt', 'r') as file:
    for line in file:
        parts = line.split()
        diagram_str = parts[0]
        joltage_str = parts[-1]
        button_strings = parts[1:-1]
        parsed_buttons = []
        for button_str in button_strings:
            button_tuple = eval(button_str[:-1] + ',)')
            parsed_buttons.append(button_tuple)
        
        joltages = eval(joltage_str[1:-1])
        
        num_lights = len(joltages)
        
        objective_coefficients = []
        for _ in parsed_buttons:
            objective_coefficients.append(1)
        
        constraint_matrix = []
        for light_index in range(num_lights):
            row = []
            for button in parsed_buttons:
                if light_index in button:
                    row.append(1)
                else:
                    row.append(0)
            constraint_matrix.append(row)
        # Solve the linear programming problem
        # Minimize: sum of button presses (objective_coefficients · x)
        # Subject to: constraint_matrix · x = joltage_values
        # Where x must be integers (number of times each button is pressed)
        result = linprog(
            c=objective_coefficients,      # Coefficients for objective function
            A_eq=constraint_matrix,         # Equality constraint matrix
            b_eq=joltages,           # Right-hand side of equality constraints
            integrality=1                   # Require integer solutions
        )
        
        total_presses += result.fun

print(int(total_presses))