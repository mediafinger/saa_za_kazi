require "csv"

class Parser
  def initialize(path)
    @path = path
  end

  def from_csv(options = {})
    settings = {
      col_sep:           options.fetch(:col_sep, ", "),
      encoding:          options.fetch(:encoding, "UTF-8"),
      quote_char:        options.fetch(:quote_char, '"'),
      row_sep:           options.fetch(:row_sep, "\n"),
      force_quotes:      true,
      headers:           true,
      skip_blanks:       true,
      skip_lines:        /\A#.*\z/, # ignore comment lines starting with #
      header_converters: :symbol,
      converters:        [->(value) { value&.strip }, ->(value) { value.empty? ? nil : value },]
    }

    CSV.read(@path, settings)
  end
end
