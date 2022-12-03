require_relative '../solvers/solver_3'
require_relative 'test_helper'

module Tests
  class Solver3Test < Minitest::Test
    def setup
      @solver = Solvers::Solver3.new
    end

    def example_a
      %w(
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      )
    end

    def test_problem_a
      expected = 157

      assert_equal(
        expected,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      expected = -1

      assert_equal(
        expected,
        @solver.solve_b(wrap_array_input(*example_a))
      )
    end
  end
end
