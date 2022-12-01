require 'active_support'
require 'active_support/core_ext'

module Solvers
  class Solver1
    def solve_a(input, _opts = {})
      get_calories(input).max
    end

    def solve_b(input, _opts = {})
      get_calories(input).sort.last(3).sum
    end

    def get_calories(input)
      elves = input.split("\n")

      elves.map do |elf|
        elf.map(&:chomp).map(&:to_i).sum
      end
    end
  end
end
