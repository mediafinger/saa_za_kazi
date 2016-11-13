load "lib/logger.rb"
load "lib/parser.rb"
load "lib/work_day.rb"
load "lib/project.rb"
load "lib/transformer.rb"
load "lib/persister.rb"

# parser = Parser.new("./solarisBank_times.csv")
parser = Parser.new("./generated_output.csv")
csv = parser.from_csv

t = CSVTransformer.new(csv)
project = t.all_to_workdays

# wd1 = t.row_to_workday(t.array[0])
# wd2 = t.row_to_workday(t.array[1])
# wd3 = t.row_to_workday(t.array[2])

persister = Persister.new(project.output)
puts persister.to_csv
