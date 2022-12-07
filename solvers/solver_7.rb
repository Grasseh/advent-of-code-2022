require 'active_support'
require 'active_support/core_ext'
require 'pry'

module Solvers
  class Solver7
    def solve_a(input, _opts = {})
      @smol_size_sum = 0

      tree = build_tree(input)
      build_directory_sizes(tree)
      @smol_size_sum
    end

    def solve_b(_input, _opts = {})
      -1
    end

    def build_tree(input)
      i = 1
      current_node = ChristmasFileSystemDirectoryNode.new('/', -1, nil)
      tree_root = current_node

      while i < input.length
        command = parse_command(input, i)
        output = parse_output(input, i)
        i += output.count + 1

        current_node = execute_command(command, current_node, output)
      end

      tree_root
    end

    def hook(_node_name, node_sum)
      return if node_sum > 100000

      @smol_size_sum += node_sum
    end

    def build_directory_sizes(node)
      sum = 0

      node.child_directories.each do |_, child_node|
        sum += if child_node.size == -1
          build_directory_sizes(child_node)
        else
          child_node.size
        end
      end

      node.size = sum
      hook(node.name, node.size)
      node.size
    end

    def parse_output(input, line_number)
      output = []

      while line_number < input.count - 1 && input[line_number + 1].first != '$'
        output << input[line_number + 1].chomp
        line_number += 1
      end

      output
    end

    def parse_command(input, line_number)
      command = input[line_number].chomp.split

      {
        instruction: command.second,
        arguments: command[2..(command.count - 1)]
      }
    end

    def execute_command(command, current_node, output)
      send(
        command.dig(:instruction),
        current_node,
        output,
        *command.dig(:arguments)
      )
    end

    def cd(current_node, _output, *args)
      return current_node.parent if args.first == '..'

      current_node.get(args.first)
    end

    def ls(current_node, output, *_args)
      output.each do |node|
        size, name = node.split

        if current_node.get(name)
          current_node.get(name).size = size
        else
          new_node = if size == 'dir'
            ChristmasFileSystemDirectoryNode.new(
              name,
              -1,
              current_node
            )
          else
            ChristmasFileSystemFile.new(
              name,
              size.to_i,
              current_node
            )
          end

          current_node.new_node(name, new_node)
        end
      end

      current_node
    end
  end

  class ChristmasFileSystemFile
    attr_accessor :size, :name, :parent

    def initialize(name, size, parent)
      @name = name
      @size = size
      @parent = parent
    end
  end

  class ChristmasFileSystemDirectoryNode < ChristmasFileSystemFile
    attr_accessor :child_directories

    def initialize(name, size, parent)
      super

      @child_directories = {}
    end

    def get(name)
      @child_directories.dig(name)
    end

    def new_node(name, node)
      @child_directories[name] = node
    end
  end
end
