require_relative '../solvers/solver_11'
require_relative 'test_helper'

module Tests
  class Solver11Test < Minitest::Test
    def setup
      @solver = Solvers::Solver11.new
    end

    def example_a
      [
        'Monkey 0:',
        '  Starting items: 79, 98',
        '  Operation: new = old * 19',
        '  Test: divisible by 23',
        '    If true: throw to monkey 2',
        '    If false: throw to monkey 3',
        '',
        'Monkey 1:',
        '  Starting items: 54, 65, 75, 74',
        '  Operation: new = old + 6',
        '  Test: divisible by 19',
        '    If true: throw to monkey 2',
        '    If false: throw to monkey 0',
        '',
        'Monkey 2:',
        '  Starting items: 79, 60, 97',
        '  Operation: new = old * old',
        '  Test: divisible by 13',
        '    If true: throw to monkey 1',
        '    If false: throw to monkey 3',
        '',
        'Monkey 3:',
        '  Starting items: 74',
        '  Operation: new = old + 3',
        '  Test: divisible by 17',
        '  If true: throw to monkey 0',
        '  If false: throw to monkey 1'
      ]
    end

    def test_problem_a
      assert_equal(
        10605,
        @solver.solve_a(wrap_array_input(*example_a))
      )
    end

    def test_problem_b
      assert_equal(
        2713310158,
        @solver.solve_b(wrap_array_input(*example_a))
      )
    end
  end
end
