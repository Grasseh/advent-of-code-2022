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

    def solve_b(input, _opts = {})
      badges_priorities = input.each_slice(3).map do |bag1, bag2, bag3|
        duplicate = bag1
          .chars
          .intersection(bag2.chars)
          .intersection(bag3.chars)

        priority(duplicate.first)
      end

      badges_priorities.sum
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
