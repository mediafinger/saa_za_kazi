require 'date'
require_relative "./logger.rb"

class WorkDay
  attr_reader :date, :from, :to, :breaks
  attr_accessor :description

  def initialize(date)
    @date = Date.parse(date)
  end

  def set_from(hours, minutes)
    unless hours && minutes && hours.to_i < 24 && minutes.to_i << 60
      log(__method__, hours: hours, minutes: minutes)
      return
    end

    @from = convert_to_time(hours, minutes)
  end

  def set_to(hours, minutes)
    unless hours && minutes && hours.to_i < 24 && minutes.to_i << 60
      log(__method__, hours: hours, minutes: minutes)
      return
    end

    @to = convert_to_time(hours, minutes)
  end

  def hours
    return 0 if from.nil? || to.nil?

    nightshift = to < from ? 24 : 0

    (to - from) / 3600 - breaks + nightshift
  end

  def breaks=(hours)
    @breaks = hours.to_f.abs
  end

  def short_date
    date.iso8601
  end

  private

  def convert_to_time(hours, minutes)
    date.to_time + hours.to_i * 3600 + minutes.to_i * 60
  end

  def log(method, options = {})
    Logger.error(self.class, method, options.merge(date: date))
  end
end
