require "csv"

module CSVFile
  class Persister
    def initialize(data)
      @data = data
    end

    def data(options = {})
      @settings = {
        col_sep:           options.fetch(:col_sep, ", "),
        encoding:          options.fetch(:encoding, "UTF-8"),
        quote_char:        options.fetch(:quote_char, '"'),
        row_sep:           options.fetch(:row_sep, "\n"),
        force_quotes:      false,
        headers:           true,
        skip_blanks:       true,
        skip_lines:        /\A#.*\z/, # ignore comment lines starting with #
        header_converters: :symbol,
        converters:        [->(value) { value&.strip }, ->(value) { value.empty? ? nil : value },]
      }

      generate_csv
    end

    def save(path = "./output.csv", options = {})
      write_to_file(path, data(options))
      puts "Saved data to file #{path}"
      path
    end

    private

    def write_to_file(path, data)
      open(path, 'w') do |file|
        file.puts data
      end

      if @data[:additional]
        File.open(path, 'a') do |file|
          file.write "# #{'-' * 70}\n"
          @data[:additional].each do |line|
            file.write "# #{line.inspect}\n"
          end
        end
      end
    end

    def generate_csv
      # Output CSV will be formatted like:
      # Date, Day, Hours, From-To, Breaks, Description
      # 04.10.2016, Tue, 3h, 10:00 - 16:00, -3h, "My comments, and more"
      CSV.generate(@settings) do |rows|
        rows << @data[:head]

        @data[:body].each do |row|
          rows << row
        end
      end
    end
  end
end
