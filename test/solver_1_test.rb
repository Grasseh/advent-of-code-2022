require_relative '../solvers/solver_1'
require_relative 'test_helper'

module Tests
  class Solver1Test < Minitest::Test
    def setup
      @solver = Solvers::Solver1.new
    end

    def example_a
      [
        '1000',
        '2000',
        '3000',
        '',
        '4000',
        '',
        '5000',
        '6000',
        '',
        '7000',
        '8000',
        '9000',
        '',
        '10000'
      ]
    end

    def test_problem_a
      expected = 24000

      assert_equal(
        expected,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      expected = 45000

      assert_equal(
        expected,
        @solver.solve_b(wrap_array_input(*example_a))
      )
    end
  end
end
