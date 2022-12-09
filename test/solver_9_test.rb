require_relative '../solvers/solver_9'
require_relative 'test_helper'

module Tests
  class Solver9Test < Minitest::Test
    def setup
      @solver = Solvers::Solver9.new
    end

    def example_a
      [
        'R 4',
        'U 4',
        'L 3',
        'D 1',
        'R 4',
        'D 1',
        'L 5',
        'R 2'
      ]
    end

    def example_b
      [
        'R 5',
        'U 8',
        'L 8',
        'D 3',
        'R 17',
        'D 10',
        'L 25',
        'U 20'
      ]
    end

    def test_problem_a
      expected = 13

      assert_equal(
        expected,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      assert_equal(
        1,
        @solver.solve_b(wrap_array_input(*example_a))
      )

      expected = 36

      assert_equal(
        expected,
        @solver.solve_b(wrap_array_input(*example_b))
      )
    end
  end
end
