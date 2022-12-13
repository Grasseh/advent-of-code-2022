require_relative '../solvers/solver_13'
require_relative 'test_helper'

module Tests
  class Solver13Test < Minitest::Test
    def setup
      @solver = Solvers::Solver13.new
    end

    def example_a
      [
        '[1,1,3,1,1]',
        '[1,1,5,1,1]',
        '',
        '[[1],[2,3,4]]',
        '[[1],4]',
        '',
        '[9]',
        '[[8,7,6]]',
        '',
        '[[4,4],4,4]',
        '[[4,4],4,4,4]',
        '',
        '[7,7,7,7]',
        '[7,7,7]',
        '',
        '[]',
        '[3]',
        '',
        '[[[]]]',
        '[[]]',
        '',
        '[1,[2,[3,[4,[5,6,7]]]],8,9]',
        '[1,[2,[3,[4,[5,6,0]]]],8,9]'
      ]
    end

    def test_problem_a
      assert_equal(
        13,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      assert_equal(
        140,
        @solver.solve_b(wrap_array_input(*example_a))
      )
    end
  end
end
