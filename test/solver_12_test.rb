require_relative '../solvers/solver_12'
require_relative 'test_helper'

module Tests
  class Solver12Test < Minitest::Test
    def setup
      @solver = Solvers::Solver12.new
    end

    def example_a
      %w(
        Sabqponm
        abcryxyl
        accszExk
        acctuvwj
        abdefghi
      )
    end

    def test_problem_a
      assert_equal(
        31,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      assert_equal(
        29,
        @solver.solve_b(wrap_array_input(*example_a))
      )
    end
  end
end
