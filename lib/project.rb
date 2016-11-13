require_relative "./work_day.rb"

class Project
  attr_reader :workdays

  def initialize
    @workdays = []
  end

  def add(workday)
    @workdays << workday
  end

  def at(date)
    # find workday at date
  end

  def search(tags)
    # find workday with tags in description
  end

  def days
    workdays.count
  end

  def first_day
    sorted_by_date.first
  end

  def last_day
    sorted_by_date.last
  end

  def longest_day
    sorted_by_working_hours.last
  end

  def shortest_day
    sorted_by_working_hours.first
  end

  def total_working_hours
    workdays.reduce(0) { |sum, workday| sum + workday.working_hours }
  end

  def average_working_hours
    total_working_hours / workdays.count
  end

  def longest_break
    sorted_by_break.first
  end

  def output
    {
      head: %w(Date Day Hours From-To Breaks Description),
      body: workdays.map(&:output)
    }
  end

  private

  def sorted_by_date
    workdays.sort_by { |workday| workday.short_date }
  end

  def sorted_by_working_hours
    workdays.sort_by { |workday| workday.working_hours }
  end

  def sorted_by_break
    workdays.sort_by { |workday| workday.break }
  end
end
