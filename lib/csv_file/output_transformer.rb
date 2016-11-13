require "csv"

module CSVFile
  class OutputTransformer
    attr_accessor :array, :head

    def initialize(project, decorator)
      @project = project
      @decorator = decorator
    end

    def format
      {
        head: %w(Date Day Hours From-To Breaks Description),
        body: @project.workdays.map { |workday| @decorator.new(workday).output }
      }
    end
  end
end
