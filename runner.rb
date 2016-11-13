load "lib/logger.rb"
load "lib/work_day.rb"
load "lib/project.rb"
load "lib/csv_file/parser.rb"
load "lib/csv_file/input_transformer.rb"
load "lib/csv_file/work_day_decorator.rb"
load "lib/csv_file/output_transformer.rb"
load "lib/csv_file/persister.rb"

csv = CSVFile::Parser.new("./generated_output.csv").read
project = CSVFile::InputTransformer.new(csv, Project).create
data = CSVFile::OutputTransformer.new(project, CSVFile::WorkDayDecorator).format
CSVFile::Persister.new(data).save
