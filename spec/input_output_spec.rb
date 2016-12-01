require_relative "./spec_helper.rb"

describe "Read CSV, Transform to internal data structure, Write CSV" do
  let(:input_path)  { "./generated_output.csv" }
  let(:input)       { File.read(input_path) }
  let(:output)      { File.read(output_path) }
  let(:output_path) { "./spec/test_output.csv" }

  before do
    # TODO delete output file!
    csv = CSVFile::Parser.new(input_path).read
    project = CSVFile::InputTransformer.new(csv, Project).create
    data = CSVFile::OutputTransformer.new(project, CSVFile::WorkDayDecorator).format
    CSVFile::Persister.new(data).save(output_path)
  end

  it "the input file equals the output file" do
    expect(input).to eq output
  end
end
