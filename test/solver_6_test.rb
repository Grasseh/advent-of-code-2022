require_relative '../solvers/solver_6'
require_relative 'test_helper'

module Tests
  class Solver6Test < Minitest::Test
    def setup
      @solver = Solvers::Solver6.new
    end

    def test_problem_a
      [
        [7, 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'],
        [5, 'bvwbjplbgvbhsrlpgdmjqwftvncz'],
        [6, 'nppdvjthqldpwncqszvftbrmjlhg'],
        [10, 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'],
        [11, 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw']
      ].each do |expected, line|
        assert_equal(
          expected,
          @solver.solve_a(wrap_line_input(line)),
          "Expected #{expected} for #{line}"
        )
      end
    end

    def test_problem_b
      expected = -1

      assert_equal(
        expected,
        @solver.solve_a(wrap_line_input('mjqjpqmgbljsphdztnvjfqwrcgsmlb'))
      )
    end
  end
end
