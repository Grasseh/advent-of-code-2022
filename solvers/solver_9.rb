require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver9
    def solve_a(input, _opts = {})
      tail_visited(input, 2).count
    end

    def solve_b(input, _opts = {})
      tail_visited(input, 10).count
    end

    def tail_visited(input, knot_count)
      knot_positions = knot_count.times.map do
        { x: 0, y: 0 }
      end

      tail_visited = { '0-0' => true }
      tail_index = knot_count - 1

      input.each do |row|
        direction, count = row.chomp.split

        count.to_i.times do
          case direction
          when 'L'
            knot_positions[0][:x] -= 1
          when 'R'
            knot_positions[0][:x] += 1
          when 'U'
            knot_positions[0][:y] -= 1
          when 'D'
            knot_positions[0][:y] += 1
          end

          (1..tail_index).each do |i|
            head = knot_positions[i - 1]
            tail = knot_positions[i]
            distance_x = tail[:x] - head[:x]
            distance_y = tail[:y] - head[:y]

            if distance_y.abs == 2 || distance_x.abs == 2
              knot_positions[i][:x] += (distance_x <=> 0) * -1
              knot_positions[i][:y] += (distance_y <=> 0) * -1
            end
          end

          tail = knot_positions[tail_index]
          tail_visited["#{tail[:x]}-#{tail[:y]}"] = true
        end
      end

      tail_visited
    end
  end
end
