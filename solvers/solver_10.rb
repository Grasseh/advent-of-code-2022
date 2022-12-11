require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver10
    def initialize
      @screen = ''
      @cycle_count = 0
      @register = 1
      @signal_strength = 0
    end

    def solve_a(input, _opts = {})
      run_program(input)
      @signal_strength
    end

    def solve_b(input, _opts = {})
      run_program(input)
      @screen.chars.each_slice(40).map(&:join).join("\n")
    end

    def run_program(input)
      input.each do |row|
        operation, value = row.chomp.split

        if operation == 'noop'
          screen_loop(1, 0)
        else
          screen_loop(2, value.to_i)
        end
      end
    end

    def screen_loop(execution_time, add_value)
      execution_time.times do
        @cycle_count += 1
        draw_screen
        calculate_signal_strength
      end

      @register += add_value
    end

    def draw_screen
      @screen += if pixel_display
        '#'
      else
        '.'
      end
    end

    def pixel_display
      (@register..(@register + 2)).include?(@cycle_count % 40) ||
        (@cycle_count % 40).zero? && (38..40).include?(@register)
    end

    def calculate_signal_strength
      return unless ((@cycle_count - 20) % 40).zero?

      @signal_strength += @register * @cycle_count
    end
  end
end
