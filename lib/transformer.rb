require "csv"
require_relative "./project.rb"
require_relative "./work_day.rb"

class CSVTransformer
  attr_accessor :array, :head

  def initialize(csv)
    # @csv   = csv
    @array = csv.to_a
    @head  = @array.shift
  end

  def all_to_workdays
    @array.each_with_object(Project.new) do |row, project|
      project.add row_to_workday(row)
    end
  end

  # Expects input CSV to be formatted like:
  # Date, Day, Hours, From-To, Breaks, Description
  # 04.10.2016, Tue, 3h, 10:00 - 16:00, -3h, "My comments, and more"
  def row_to_workday(row)
    header = :date, :day, :hours, :fromto, :breaks, :description # @head
    hash = [header, row].transpose.to_h

    from, to = (hash[:fromto] || "").gsub(/\s/, "").split("-").map { |t| t.split(':').map(&:to_i) }

    workday = WorkDay.new(hash[:date])
    workday.description = hash[:description]
    workday.breaks = hash[:breaks].to_f
    workday.set_from(from[0], from[1]) if from
    workday.set_to(to[0], to[1]) if to

    workday
  end
end
