require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver6
    def solve_a(input, _opts = {})
      line = input.first.chomp
      start_of_packet(line)
    end

    def solve_b(input, _opts = {})
      line = input.first.chomp
      start_of_message(line)
    end

    def start_of_packet(line)
      unique_string_index(line, 4)
    end

    def start_of_message(line)
      unique_string_index(line, 14)
    end

    def unique_string_index(line, char_count)
      line.chars.each_with_index do |_char, index|
        next if index < char_count - 1

        if line[(index - char_count + 1)..index].chars.uniq.count == char_count
          return index + 1
        end
      end
    end
  end
end
