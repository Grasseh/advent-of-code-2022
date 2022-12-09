require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver9
    def solve_a(input, _opts = {})
      head = { x: 0, y: 0 }
      tail = { x: 0, y: 0 }
      tail_visited = { '0-0' => true }

      input.each do |row|
        direction, count = row.chomp.split

        count.to_i.times do
          case direction
          when 'L'
            head[:x] -= 1
          when 'R'
            head[:x] += 1
          when 'U'
            head[:y] -= 1
          when 'D'
            head[:y] += 1
          end

          distance_x = tail[:x] - head[:x]
          distance_y = tail[:y] - head[:y]

          if distance_y.abs == 2 || distance_x.abs == 2
            tail[:x] += (distance_x <=> 0) * -1
            tail[:y] += (distance_y <=> 0) * -1
          end

          tail_visited["#{tail[:x]}-#{tail[:y]}"] = true
        end
      end

      tail_visited.count
    end

    def solve_b(_input, _opts = {})
      -1
    end
  end
end
