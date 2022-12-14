require_relative '../solvers/solver_14'
require_relative 'test_helper'

module Tests
  class Solver14Test < Minitest::Test
    def setup
      @solver = Solvers::Solver14.new
    end

    def example_a
      [
        '498,4 -> 498,6 -> 496,6',
        '503,4 -> 502,4 -> 502,9 -> 494,9'
      ]
    end

    def test_problem_a
      assert_equal(
        24,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      assert_equal(
        93,
        @solver.solve_b(wrap_array_input(*example_a), print: false)
      )
    end
  end
end
