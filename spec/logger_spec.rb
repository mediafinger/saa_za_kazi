require_relative "./spec_helper.rb"

describe Logger do
  subject(:logger) { Logger }

  let(:klass)   { String }
  let(:action)  { :puts }
  let(:options) { { some: "parameter", any: "thing" } }

  it "prints to STDERR" do
    expect { logger.error(klass, action, options) }.to output.to_stderr_from_any_process
  end

  it "prints an error message to STDERR" do
    expect { logger.error(klass, action, options) }.to output(
      "******** error in class #{klass} method #{action} ********\n" \
      "#{options.inspect}\n" \
      "**********************************************************\n"
    ).to_stderr_from_any_process
  end
end
