require_relative '../solvers/solver_5'
require_relative 'test_helper'

module Tests
  class Solver5Test < Minitest::Test
    def setup
      @solver = Solvers::Solver5.new
    end

    def example_a
      [
        '    [D]',
        '[N] [C]',
        '[Z] [M] [P]',
        ' 1   2   3',
        '',
        'move 1 from 2 to 1',
        'move 3 from 1 to 3',
        'move 2 from 2 to 1',
        'move 1 from 1 to 2'
      ]
    end

    def test_problem_a
      expected = 'CMZ'

      assert_equal(
        expected,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      expected = 'MCD'

      assert_equal(
        expected,
        @solver.solve_b(wrap_array_input(*example_a))
      )
    end
  end
end
