require "csv"

module CSVFile
  class InputTransformer
    attr_accessor :array, :head

    def initialize(csv, model)
      # @csv   = csv
      @array = csv.to_a
      @head  = @array.shift
      @model = model
    end

    def create
      @array.each_with_object(@model.new) do |row, model|
        model.add row_to_workday(row)
      end
    end

    private

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
    rescue IndexError => error
      Logger.error(self.class, :row_to_workday, {error: error.class, message: error.message, row: row })
    end
  end
end
