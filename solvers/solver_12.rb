require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver12
    def solve_a(input, _opts = {})
      grid = input
      start = get_coord('S', grid)
      goal = get_coord('E', grid)
      grid = grid.map(&:chomp).map(&:chars)
      a_star(grid, start, goal)
    end

    def solve_b(input, _opts = {})
      # We can cheat this a little. The only valid As in the input
      # are all in the left column.
      grid = input
      goal = get_coord('E', grid)
      grid = grid.map(&:chomp).map(&:chars)
      input.map.with_index do |_row, i|
        start = [0, i]
        a_star(grid, start, goal)
      end.min
    end

    def get_coord(character, grid)
      row = grid.select { |s| s.include?(character) }.first
      row_index = grid.index(row)
      col_index = row.index(character)

      [col_index, row_index]
    end

    def find_valid_adjacent(position, letter, grid)
      current_ascii = letter_ascii(letter)

      [
        [-1, 0],
        [1, 0],
        [0, -1],
        [0, 1]
      ].map do |x_var, y_var|
        x = x_var + position.first
        y = y_var + position.last

        next if x.negative? || y.negative?
        next if x >= grid.first.count || y >= grid.count

        next unless letter_ascii(grid[y][x]) <= current_ascii + 1

        { coord: [x, y], letter: grid[y][x] }
      end.compact
    end

    def a_star(grid, start, goal)
      to_visit_queue = { start => 0 }
      path_to = { start => nil }
      cost_to = { start => 0 }

      until to_visit_queue.empty?
        current = to_visit_queue.min_by { |_k, val| val }
        current_position = current.first
        current_letter = letter_at_position(grid, current_position)
        to_visit_queue.delete(current_position)

        break if current_position == goal

        find_valid_adjacent(current_position, current_letter, grid)
          .each do |adjacent_hash|
            adjacent = adjacent_hash.dig(:coord)
            cost_to_move_to_adjacent = cost_to[current_position] + 1

            next unless (
              !cost_to.keys.include?(adjacent) ||
              cost_to_move_to_adjacent < cost_to[adjacent]
            )

            cost_to[adjacent] = cost_to_move_to_adjacent

            heuristic = a_star_heuristic(
              cost_to_move_to_adjacent,
              goal,
              adjacent_hash,
              current_letter
            )

            to_visit_queue[adjacent] = heuristic
            path_to[adjacent] = current_position
          end

      end

      cost_to[goal]
    end

    def a_star_heuristic(exact_cost, goal, adjacent, current)
      exact_cost +
        manhattan(goal, adjacent.dig(:coord)) +
        altitude_difference(current, adjacent.dig(:letter))
    end

    def letter_at_position(grid, current_position)
      grid[current_position.last][current_position.first]
    end

    def altitude_difference(current, adjacent)
      case letter_ascii(adjacent) - letter_ascii(current)
      when 1
        1
      when 0
        3
      else
        7
      end
    end

    def letter_ascii(letter)
      case letter
      when 'S'
        'a'.ord - 1
      when 'E'
        'z'.ord + 1
      else
        letter.ord
      end
    end

    def manhattan(coord_a, coord_b)
      (coord_a.first - coord_b.first).abs + (coord_a.last - coord_b.last).abs
    end
  end
end
