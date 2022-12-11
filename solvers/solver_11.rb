require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver11
    def solve_a(input, _opts = {})
      monkey_business(input, 3, 20)
    end

    def solve_b(input, _opts = {})
      monkey_business(input, 1, 10000)
    end

    def monkey_business(input, relief, iterations)
      monkeys = input.split("\n").map do |monkey_lines|
        create_monkey(monkey_lines, relief)
      end

      max_test = monkeys.reduce(1) { |redux, monkey| redux * monkey.test }
      monkeys.each { |monkey| monkey.modulo = max_test }

      iterations.times do
        monkeys.each do |monkey|
          monkey.play_with_items do |receiving_monkey_index, new_item_value|
            monkeys[receiving_monkey_index].receive(new_item_value)
          end
        end
      end

      monkeys = monkeys.sort_by(&:count).reverse
      monkeys.first.count * monkeys.second.count
    end

    def create_monkey(monkey_text, relief)
      start_items = monkey_text
        .second
        .chomp
        .split(':')
        .second
        .split(', ')
        .map(&:to_i)

      operation = parse_operation(monkey_text.third.chomp.split('=').second)
      test = monkey_text.fourth.chomp.split('by ').second.to_i
      test_true = monkey_text.fifth.chomp.split('monkey ').second.to_i
      test_false = monkey_text[5].chomp.split('monkey ').second.to_i

      Monkey.new(start_items, operation, test, test_true, test_false, relief)
    end

    def parse_operation(operation_text)
      operands = operation_text.split
      operator = operands.second.to_sym
      constant = operands.third

      if constant == 'old'
        constant = '2'
        operator = :**
      end

      proc do |inner_operator, inner_constant, old|
        old.send(inner_operator, inner_constant)
      end.curry[operator, constant.to_i]
    end
  end

  class Monkey
    attr_reader :count, :operation, :test
    attr_writer :modulo

    def initialize(start_items, operation, test, test_true, test_false, relief)
      @items = start_items
      @operation = operation
      @test = test
      @test_true = test_true
      @test_false = test_false
      @relief_modifier = relief
      @count = 0
      @modulo = 1
    end

    def play_with_items(&block)
      @count += @items.count

      @items.each do |item|
        new_value = (@operation.call(item) / @relief_modifier) % @modulo

        if (new_value % @test).zero?
          block.call(@test_true, new_value)
        else
          block.call(@test_false, new_value)
        end
      end

      @items = []
    end

    def receive(item_value)
      @items << item_value
    end
  end
end
