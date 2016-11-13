require "csv"

class Persister
  def initialize(data)
    @data = data
  end

  def to_csv(path = "./output.csv", options = {})
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

    save(path, generate_csv)
  end

  private

  def save(path, data)
    open(path, 'w') do |file|
      file.puts data
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
