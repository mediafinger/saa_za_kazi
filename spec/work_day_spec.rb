require_relative "./spec_helper.rb"

describe WorkDay do
  subject(:workday) { WorkDay.new(date) }

  let(:date)        { "03.10.2016" }
  let(:hours)       { "09" }
  let(:minutes)     { "45" }
  let(:breaks)      { 0.75 }
  let(:description) { "I know what you did last day" }

  context "#from" do
    it "is a Time" do
      workday.set_from(hours, minutes)
      expect(workday.from).to be_a(Time)
    end

    it "is on the same day as date" do
      workday.set_from(hours, minutes)
      expect((workday.from - workday.date.to_time).to_i / 3600).to eq 9
    end

    it "converts Integers to Time" do
      workday.set_from(12, 0)
      expect(workday.from).to be_a(Time)
    end

    it "converts Integers to Time" do
      workday.set_from(12, 0)
      expect((workday.from - workday.date.to_time).to_i / 3600).to eq 12
    end

    context "when the input is invalid" do
      it "logs an error" do
        workday.set_from(12, "o'clock")
      end

      it "returns nil" do
        workday.set_from("ten", 0)
      end

      it "does not store the value" do
        workday.set_from(nil, 30)
      end
    end
  end

  context "#breaks" do
    it "is a Float" do
      workday.breaks = breaks
      expect(workday.breaks).to be_a(Float)
    end

    it "converts Integer to Float" do
      workday.breaks = 1
      expect(workday.breaks).to be_a(Float)
    end

    it "is always positive" do
      workday.breaks = -1
      expect(workday.breaks).to be >= 0
    end

    it "is always positive" do
      workday.breaks = breaks
      expect(workday.breaks).to be >= 0
    end
  end

  context "#description" do
    it "is String" do
      workday.description = description
      expect(workday.description).to be_a(String)
    end

    it "is not modified" do
      workday.description = description
      expect(workday.description).to eq description
    end
  end
end
