require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver13
    def solve_a(input, _opts = {})
      pairs = input.split("\n")
      sum = 0

      pairs.each_with_index do |pair, index|
        first_pair = JSON.parse(pair.first.chomp)
        second_pair = JSON.parse(pair.second.chomp)
        next unless compare(first_pair, second_pair).negative?

        sum += index + 1
      end

      sum
    end

    def solve_b(_input, _opts = {})
      -1
    end

    def compare(left, right)
      if left.is_a?(Integer) && right.is_a?(Integer)
        left <=> right
      elsif left.is_a?(Array) && right.is_a?(Array)
        compare_arrays(left, right)
      elsif left.is_a?(Array)
        compare(left, [right])
      else
        compare([left], right)
      end
    end

    def compare_arrays(left, right)
      i = 0
      comparison = 0
      same_length = left.count == right.count

      loop do
        break if comparison != 0
        break if left.count <= i && same_length

        if left.count <= i
          comparison = -1
          break
        end

        if right.count <= i
          comparison = 1
          break
        end

        comparison = compare(left[i], right[i])
        i += 1
      end

      comparison
    end
  end
end
