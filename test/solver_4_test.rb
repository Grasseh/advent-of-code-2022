require_relative '../solvers/solver_4'
require_relative 'test_helper'

module Tests
  class Solver4Test < Minitest::Test
    def setup
      @solver = Solvers::Solver4.new
    end

    def example_a
      %w(
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
      )
    end

    def test_problem_a
      expected = 2

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
