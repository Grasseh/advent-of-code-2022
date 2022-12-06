require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver6
    def solve_a(input, _opts = {})
      line = input.first.chomp

      line.chars.each_with_index do |_char, index|
        next if index < 3

        if line[(index - 3)..index].chars.uniq.count == 4
          return index + 1
        end
      end
    end

    def solve_b(_input, _opts = {})
      -1
    end
  end
end
