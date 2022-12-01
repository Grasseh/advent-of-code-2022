require 'active_support'
require 'active_support/core_ext'

module Solvers
  class Solver1
    def solve_a(input, _opts = {})
      elves = input.split("\n")

      calories = elves.map do |elf|
        elf.map(&:chomp).map(&:to_i).sum
      end
      calories.max
    end

    def solve_b(_input, _opts = {})
      -1
    end
  end
end
