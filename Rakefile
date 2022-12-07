require 'minitest/test_task'
require 'benchmark'

Minitest::TestTask.create

task default: :test

desc 'Run CLI problem solver'
task :run do
  puts 'Welcome to Grasseh\'s Advent of Code 2022 solutions.'
  puts 'Please enter below the number of the problem you wish to solve: '

  number = $stdin.gets.chomp

  puts "You selected problem ##{number}"

  require_relative "solvers/solver_#{number}.rb"

  solver = eval("Solvers::Solver#{number}").new

  input = File.open("inputs/#{number}.txt").readlines

  puts solver.solve_a(input)
  puts solver.solve_b(input)
end

desc 'Run Benchmarks'
task :benchmark do
  puts 'Reporting each test ran 100 times'

  Benchmark.bm(15) do |x|
    Dir
      .glob(File.join('.', 'inputs', '*'))
      .select { |file| File.file?(file) }
      .map { |file| File.basename(file, '.*') }
      .each do |number|
        require_relative "solvers/solver_#{number}.rb"
        solver = eval("Solvers::Solver#{number}").new
        input = File.open("inputs/#{number}.txt").readlines

        x.report("Problem ##{number}A:") do
          100.times do
            solver.solve_a(input, print: false)
          end
        end

        x.report("Problem ##{number}B:") do
          100.times do
            solver.solve_b(input, print: false)
          end
        end
      end
  end
end
