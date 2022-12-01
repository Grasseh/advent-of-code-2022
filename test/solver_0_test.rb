require_relative '../solvers/solver_0'
require_relative 'test_helper'

module Tests
  class Solver0Test < Minitest::Test
    def setup
      @solver = Solvers::Solver0.new
    end

    def test_problem_a
      [
        ['(())', 0, 'returns the entrance on the wrapped parens'],
        ['()()', 0, 'returns the entrance on the pairs of parens'],
        ['(((', 3, 'gets up to the third floor if it just goes up'],
        ['(()(()(', 3, 'can go up and down to the third floor'],
        [
          '))(((((',
          3,
          'can go down first and then straight up to the third floor'
        ],
        ['())', -1, 'can go up and then reach the basement'],
        ['))(', -1, 'can go down and up in the basement'],
        [')))', -3, 'can go straight to B3F'],
        [')())())', -3, 'can go to B3F by messing around']
      ].each do |(input, expected, description)|
        assert_equal(
          expected,
          @solver.solve_a(wrap_line_input(input)),
          description
        )
      end
    end

    def test_problem_b
      [
        [')', 1, 'returns the first move if he goes straight to the basement'],
        ['()())', 5, 'returns the fifth move if he messes around']
      ].each do |(input, expected, description)|
        assert_equal(
          expected,
          @solver.solve_b(wrap_line_input(input)),
          description
        )
      end
    end
  end
end
