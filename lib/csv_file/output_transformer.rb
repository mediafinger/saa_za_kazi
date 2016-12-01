require "csv"

module CSVFile
  class OutputTransformer
    attr_accessor :array, :head

    def initialize(project, decorator, options = {})
      @project = project
      @decorator = decorator
      @additional = options.fetch(:additional, false)
    end

    def format
      {
        head: %w(Date Day Hours From-To Breaks Description),
        body: @project.workdays.map { |workday| @decorator.new(workday).output },
      }.merge(extra_lines)
    end

    def extra_lines
      return { additional: @project.output_working_hours_per_month } if @additional
      {}
    end
  end
end
