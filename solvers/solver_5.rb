require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver5
    def solve_a(input, _opts = {})
      input_crates, input_operations = input.split("\n")
      crates = parse_crates(input_crates)
      operations = parse_operations(input_operations)

      operations.each do |operation|
        execute_stack_operation!(crates, operation)
      end

      crates.values.map(&:last).join
    end

    def solve_b(input, _opts = {})
      input_crates, input_operations = input.split("\n")
      crates = parse_crates(input_crates)
      operations = parse_operations(input_operations)

      operations.each do |operation|
        execute_group_operation!(crates, operation)
      end

      crates.values.map(&:last).join
    end

    def parse_crates(input)
      crate_index_string = input.pop.chomp
      crate_indexes = crate_index_string.split
      reversed_input = input.reverse

      crate_indexes.each_with_object({}) do |crate_index, crates|
        stack = []
        index = crate_index_string.index(crate_index)

        reversed_input.each do |row|
          crate_letter = row[index]
          break unless crate_letter.present?

          stack.push(crate_letter)
        end

        crates[crate_index] = stack
      end
    end

    def parse_operations(input)
      input.map do |operation_row|
        data = operation_row.chomp.split

        {
          move_count: data[1].to_i,
          from: data[3],
          to: data[5]
        }
      end
    end

    def execute_stack_operation!(crates, operation)
      stack_from = crates.dig(operation.dig(:from))
      stack_to = crates.dig(operation.dig(:to))

      operation.dig(:move_count).times do
        stack_to.push(stack_from.pop)
      end
    end

    def execute_group_operation!(crates, operation)
      stack_from = crates.dig(operation.dig(:from))
      stack_to = crates.dig(operation.dig(:to))

      stack_to.push(stack_from.pop(operation.dig(:move_count))).flatten!
    end
  end
end
