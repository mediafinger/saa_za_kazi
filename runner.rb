load "lib/logger.rb"
load "lib/parser.rb"
load "lib/work_day.rb"
load "lib/project.rb"
load "lib/transformer.rb"

parser = Parser.new("./solarisBank_times.csv")
csv = parser.read

t = Transformer.new(csv)
project = t.all_to_workdays

# wd1 = t.row_to_workday(t.array[0])
# wd2 = t.row_to_workday(t.array[1])
# wd3 = t.row_to_workday(t.array[2])
