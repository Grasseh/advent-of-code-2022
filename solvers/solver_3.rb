require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver3
    def solve_a(input, _opts = {})
      duplicates = input.map do |bag|
        compartments = bag.chomp.chars.each_slice(bag.size / 2).map(&:join)

        duplicate = compartments
          .first
          .chars
          .intersection(compartments.last.chars)

        priority(duplicate.first)
      end

      duplicates.sum
    end

    def solve_b(_input, _opts = {})
      -1
    end

    def priority(letter)
      if letter.upcase == letter
        letter.ord - 38
      else
        letter.ord - 96
      end
    end
  end
end
