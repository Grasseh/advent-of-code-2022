require_relative '../solvers/solver_8'
require_relative 'test_helper'

module Tests
  class Solver8Test < Minitest::Test
    def setup
      @solver = Solvers::Solver8.new
    end

    def example_a
      %w(
        30373
        25512
        65332
        33549
        35390
      )
    end

    def test_problem_a
      expected = 21

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
