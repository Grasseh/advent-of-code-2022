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

    def solve_b(input, _opts = {})
      grid = parse_input(input)
      height = grid.count
      width = grid.first.count
      best_score = 0
      # Edges all have a scenic score of 0. Anything not on the edge has a
      # scenic score. Note that the max score a 1 can have is 1, so we'll skip
      # those too.

      (1..(width - 2)).each do |x|
        (1..(height - 2)).each do |y|
          tree_height = grid[y][x]
          next if tree_height == 1

          north_score = calculate_scenic_score(x, y, 0, -1, grid, width, height)
          south_score = calculate_scenic_score(x, y, 0, 1, grid, width, height)
          east_score = calculate_scenic_score(x, y, 1, 0, grid, width, height)
          west_score = calculate_scenic_score(x, y, -1, 0, grid, width, height)

          scenic_score = north_score * south_score * east_score * west_score
          best_score = [scenic_score, best_score].max
        end
      end

      best_score
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

    # rubocop:disable Layout/LineLength
    def calculate_scenic_score(start_x, start_y, x_step, y_step, grid, width, height)
      # rubocop:enable Layout/LineLength
      tree_height = grid[start_y][start_x]
      scenic_score = 0
      x = start_x
      y = start_y

      loop do
        x += x_step
        y += y_step

        break if x >= width || x.negative? || y >= height || y.negative?

        scenic_score += 1
        break if grid[y][x] >= tree_height
      end

      scenic_score
    end
  end
end
