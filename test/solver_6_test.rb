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
      [
        [19, 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'],
        [23, 'bvwbjplbgvbhsrlpgdmjqwftvncz'],
        [23, 'nppdvjthqldpwncqszvftbrmjlhg'],
        [29, 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'],
        [26, 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw']
      ].each do |expected, line|
        assert_equal(
          expected,
          @solver.solve_b(wrap_line_input(line)),
          "Expected #{expected} for #{line}"
        )
      end
    end
  end
end
