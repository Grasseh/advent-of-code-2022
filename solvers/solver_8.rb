require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver8
    def solve_a(input, _opts = {})
      grid = parse_input(input)
      visible = {}
      height = grid.count
      width = grid.first.count

      visible = calculate_visible(grid, visible, height, width)
      visible = calculate_visible(grid, visible, height, width, reverse: true)
      visible = calculate_visible(grid, visible, width, height, rows: false)
      visible = calculate_visible(
        grid,
        visible,
        width,
        height,
        rows: false,
        reverse: true
      )

      visible.count
    end

    def solve_b(_input, _opts = {})
      -1
    end

    def parse_input(input)
      input.map do |row|
        row.chomp.chars.map(&:to_i)
      end
    end

    # rubocop:disable Layout/LineLength
    def calculate_visible(grid, visible, first_iter, second_iter, rows: true, reverse: false)
      # rubocop:enable Layout/LineLength
      (0..(first_iter - 1)).each do |i|
        if rows
          y = i
        else
          x = i
        end

        highest = -1

        (0..(second_iter - 1)).each do |j|
          if rows
            x = reverse ? second_iter - j - 1 : j
          else
            y = reverse ? second_iter - j - 1 : j
          end

          if grid[y][x] > highest
            visible["#{x}-#{y}"] = true
            highest = grid[y][x]
          end
          if highest == 9
            break
          end
        end
      end

      visible
    end
  end
end
