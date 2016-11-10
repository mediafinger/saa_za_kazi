require_relative "./logger.rb"

class WorkDay
  attr_reader :date, :from, :to, :breaks
  attr_accessor :description

  def initialize(date)
    @date = Date.parse(date)
  end

  def set_from(hours, minutes)
    unless hours && minutes
      log(__method__, hours: hours, minutes: minutes)
      return
    end

    @from = date.to_time + hours * 3600 + minutes * 60
  end

  def set_to(hours, minutes)
    unless hours && minutes
      log(__method__, hours: hours, minutes: minutes)
      return
    end

    @to = date.to_time + hours * 3600 + minutes * 60
  end

  def hours
    return 0 if from.nil? || to.nil?
    (to - from) / 3600 - breaks
  end

  def breaks=(hours)
    @breaks = hours.to_f.abs
  end

  def short_date
    date.iso8601
  end

  def long_date
    date.strftime("%a %d.%b.%Y")
  end

  def to_s
    "#{long_date}, #{hours}h and #{breaks}h breaks"
  end

  private

  def log(method, options = {})
    Logger.error(self.class, method, options.merge(date: date))
  end
end
