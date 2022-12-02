require_relative '../solvers/solver_2'
require_relative 'test_helper'

module Tests
  class Solver2Test < Minitest::Test
    def setup
      @solver = Solvers::Solver2.new
    end

    def example_a
      [
        'A Y',
        'B X',
        'C Z'
      ]
    end

    def test_problem_a
      expected = 15

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
