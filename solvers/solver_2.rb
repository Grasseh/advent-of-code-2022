require 'active_support'
require 'active_support/core_ext'

module Solvers
  class Solver2
    def solve_a(input, _opts = {})
      cache ||= {}

      input.reduce(0) do |score, round|
        cache[round] ||= begin
          opponent_choice = shapes_hash_with_decision.dig(round[0])
          self_choice = shapes_hash_with_decision.dig(round[2])
          result = ((self_choice.score % 3 - opponent_choice.score % 3) + 4) % 3
          self_choice.score + result * 3
        end

        score + cache[round]
      end
    end

    def solve_b(input, _opts = {})
      cache ||= {}

      input.reduce(0) do |score, round|
        cache[round] ||= begin
          opponent_choice = shapes_hash.dig(round[0])
          expected_result = result_hash.dig(round[2])
          self_choice = decide_shape(opponent_choice, expected_result)
          self_choice.score + expected_result * 3
        end

        score + cache[round]
      end
    end

    def decide_shape(opponent_choice, expected_result)
      index_movement = (expected_result - 1) % 3
      opponent_index = opponent_choice.score - 1
      choice_index = (opponent_index + index_movement) % 3
      shapes[choice_index]
    end

    def shapes
      @shapes ||= [
        Shape.new(1, 'Rock'),
        Shape.new(2, 'Paper'),
        Shape.new(3, 'Scissors')
      ]
    end

    def shapes_hash_with_decision
      @shapes_hash_with_decision ||= shapes_hash.merge({
        X: shapes[0],
        Y: shapes[1],
        Z: shapes[2]
      })
    end

    def result_hash
      @result_hash ||= {
        X: 0,
        Y: 1,
        Z: 2
      }.with_indifferent_access
    end

    def shapes_hash
      @shapes_hash ||= {
        A: shapes[0],
        B: shapes[1],
        C: shapes[2]
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
