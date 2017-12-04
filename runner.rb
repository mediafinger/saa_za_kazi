require "irb"

load "lib/logger.rb"
load "lib/work_day.rb"
load "lib/project.rb"
load "lib/csv_file/parser.rb"
load "lib/csv_file/input_transformer.rb"
load "lib/csv_file/work_day_decorator.rb"
load "lib/csv_file/output_transformer.rb"
load "lib/csv_file/persister.rb"

csv = CSVFile::Parser.new("./solarisBank_times.csv").read
# csv = CSVFile::Parser.new("./generated_output.csv").read
project = CSVFile::InputTransformer.new(csv, Project).create
data = CSVFile::OutputTransformer.new(project, CSVFile::WorkDayDecorator, additional: true).format
path = CSVFile::Persister.new(data).save
puts File.read(path)

puts "2017: #{project.total_working_hours}h / #{project.days.count}d => #{project.average_working_hours.round(2)} h/d"
puts "Angestellter: 1720h / 215d => 8 h/d"

hundred_k = 1429
hours_left = hundred_k - project.total_working_hours

puts "2017: #{hundred_k} - #{project.total_working_hours}h = #{hours_left}h"
puts "2017: #{hours_left}h / 7.7h/d =  #{(hours_left / 7.7).round(2)}d"
puts "2017: #{hours_left}h / 8.0h/d =  #{(hours_left / 8.0).round(2)}d"
puts "2017: #{hours_left}h / 8.3h/d =  #{(hours_left / 8.3).round(2)}d"

# binding.irb

puts ":-)"
