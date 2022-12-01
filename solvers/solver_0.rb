require 'active_support'
require 'active_support/core_ext'

module Solvers
  class Solver0
    def solve_a(input, _opts = {})
      input = input.first.chomp
      input.count('(') - input.count(')')
    end

    def solve_b(input, _opts = {})
      input = input.first.chomp.chars

      input
        .each_with_object(
          { ')': 0, '(': 0 }.with_indifferent_access
        ) do |element, hash|
          hash[element] += 1

          if hash.dig(')') > hash.dig('(')
            return hash.dig(')') + hash.dig('(')
          end
        end

      -1
    end
  end
end
