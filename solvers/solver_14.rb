require 'active_support'
require 'active_support/core_ext'
require 'pry'
require 'curses'

module Solvers
  class Solver14
    def initialize
      @min_y = 0
      @max_y = 0
      @min_x = 9999
      @max_x = 0
    end

    def solve_a(input, opts = {})
      grid = build_grid(input)

      if opts.dig(:print)
        Curses.init_screen
        Curses.crmode
        print_map(grid)
      end

      sand_count = drop_sand_until(grid, opts) do |current_y|
        current_y > @max_y
      end

      sand_count - 1
    end

    def solve_b(input, opts = {})
      grid = build_grid(input)

      ((@min_x - 500)..(@max_x + 500)).each do |x|
        grid["#{x}-#{@max_y + 2}"] = '#'
      end

      if opts.dig(:print)
        Curses.init_screen
        Curses.crmode
        print_map(grid)
      end

      sand_count = drop_sand_until(grid, opts) do |_|
        grid['500-0'] == 'o'
      end

      sand_count
    end

    def drop_sand_until(grid, opts, &block)
      sand_spawn = [500, 0]
      sand_count = 0

      loop do
        current_grain = sand_spawn
        sand_count += 1

        current_x = current_grain.first
        current_y = current_grain.last
        big_break = false

        loop do
          # find new position
          if !grid["#{current_x}-#{current_y + 1}"]
            current_y += 1
          elsif !grid["#{current_x - 1}-#{current_y + 1}"]
            current_y += 1
            current_x -= 1
          elsif !grid["#{current_x + 1}-#{current_y + 1}"]
            current_y += 1
            current_x += 1
          else
            grid["#{current_x}-#{current_y}"] = 'o'
            big_break = block.call(current_y)
            break
          end

          big_break = block.call(current_y)
          break if big_break
        end

        print_map(grid) if opts.dig(:print)
        break if big_break
      end

      sand_count
    end

    def build_grid(input)
      input.each_with_object({}) do |row, grid|
        positions = row.chomp.split(' -> ').map { |p| p.split(',') }

        positions.each_with_index do |position, index|
          next if index.zero?

          current_position = position.map(&:to_i)
          previous_position = positions[index - 1].map(&:to_i)
          x = current_position.first
          y = current_position.last
          old_x = previous_position.first
          old_y = previous_position.last

          @max_y = [y, old_y, @max_y].max
          @min_y = [y, old_y, @min_y].min
          @min_x = [x, old_x, @min_x].min
          @max_x = [x, old_x, @max_x].max

          if x == old_x
            smol_y = [y, old_y].min
            beeg_y = [y, old_y].max

            (smol_y..beeg_y).each do |i_y|
              grid["#{x}-#{i_y}"] = '#'
            end
          else
            smol_x = [x, old_x].min
            beeg_x = [x, old_x].max

            (smol_x..beeg_x).each do |i_x|
              grid["#{i_x}-#{y}"] = '#'
            end
          end
        end
      end
    end

    def print_map(grid)
      lines = (@min_y..@max_y).map do |y|
        ((@min_x - 1)..(@max_x + 1)).map do |x|
          grid["#{x}-#{y}"].presence || '.'
        end.join
      end

      lines.each_with_index do |line, index|
        Curses.setpos(index, 0)
        Curses.addstr(line)
      end

      Curses.refresh
    end
  end
end
