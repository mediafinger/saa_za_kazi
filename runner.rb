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

# binding.irb

puts ":-)"
