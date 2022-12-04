require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver4
    def solve_a(input, _opts = {})
      overlap = input.select do |elf_pair|
        first_elf, second_elf = elf_pair.chomp.split(',')
        first_elf_start, first_elf_end = first_elf.split('-').map(&:to_i)
        second_elf_start, second_elf_end = second_elf.split('-').map(&:to_i)

        (
          first_elf_start <= second_elf_start && first_elf_end >= second_elf_end
        ) ||
          first_elf_start >= second_elf_start && first_elf_end <= second_elf_end
      end

      overlap.count
    end

    def solve_b(input, _opts = {})
      overlap = input.reject do |elf_pair|
        first_elf, second_elf = elf_pair.chomp.split(',')
        first_elf_start, first_elf_end = first_elf.split('-').map(&:to_i)
        second_elf_start, second_elf_end = second_elf.split('-').map(&:to_i)

        (
          first_elf_start < second_elf_start && first_elf_end < second_elf_start
        ) ||
          first_elf_start > second_elf_start && second_elf_end < first_elf_start
      end

      overlap.count
    end
  end
end
