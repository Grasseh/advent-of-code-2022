require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver10
    def solve_a(input, _opts = {})
      cycle_count = 0
      register = 1
      signal_strength = 0

      input.each do |row|
        operation, value = row.chomp.split

        if operation == 'noop'
          value = 0
          cycle_count += 1
        else
          cycle_count += 2
          register += value.to_i

          if ((cycle_count - 21) % 40).zero?
            signal_strength += (register - value.to_i) * (cycle_count - 1)
          end
        end

        if ((cycle_count - 20) % 40).zero?
          signal_strength += (register - value.to_i) * cycle_count
        end
      end

      signal_strength
    end

    def solve_b(_input, _opts = {})
      -1
    end
  end
end
