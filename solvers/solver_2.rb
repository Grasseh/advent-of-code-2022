require 'active_support'
require 'active_support/core_ext'

module Solvers
  class Solver2
    def solve_a(input, _opts = {})
      input.reduce(0) do |score, round|
        opponent_choice = shapes_hash.dig(round[0])
        self_choice = shapes_hash.dig(round[2])
        result = ((self_choice.score % 3 - opponent_choice.score % 3) + 4) % 3

        score + self_choice.score + result * 3
      end
    end

    def solve_b(_input, _opts = {})
      -1
    end

    def shapes
      @shapes ||= [
        Shape.new(1, 'Rock'),
        Shape.new(2, 'Paper'),
        Shape.new(3, 'Scissors')
      ]
    end

    def shapes_hash
      @shapes_hash ||= {
        A: shapes[0],
        B: shapes[1],
        C: shapes[2],
        X: shapes[0],
        Y: shapes[1],
        Z: shapes[2]
      }.with_indifferent_access
    end
  end

  class Shape
    attr_accessor :score, :name

    def initialize(score, name)
      @score = score
      @name = name
    end
  end
end
