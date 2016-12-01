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
    workdays.reduce(0) { |sum, workday| sum + workday.hours }
  end

  def average_working_hours
    total_working_hours / workdays.count
  end

  def longest_break
    sorted_by_break.first
  end

  def output_working_hours_per_month
    output = []

    (first_day.date.year..last_day.date.year).to_a.each do |year|
      first_month = year == first_day.date.year ? first_day.date.month : 1
      last_month  = year == last_day.date.year  ? last_day.date.month  : 12

      (first_month..last_month).to_a.each do |month|
        current_month = (first_of_month(month, year)...first_of_next_month(month, year)).to_a
        hours = workdays.reduce(0) do |sum, workday|
          if current_month.include?(workday.date) # TODO: only iterate over one month?!
            sum + workday.hours
          else
            sum + 0
          end
        end

        output << { "#{month}.#{year}" => "#{hours}h" }
      end
    end

    output
  end

  private

  def sorted_by_date
    workdays.sort_by { |workday| workday.short_date }
  end

  def sorted_by_working_hours
    workdays.sort_by { |workday| workday.hours }
  end

  def sorted_by_break
    workdays.sort_by { |workday| workday.break }
  end

  def first_of_month(month, year)
    Date.parse("01. #{month}. #{year}")
  end

  def first_of_next_month(month, year)
    next_month = month + 1 <= 12 ? month + 1 : 1
    next_year  = next_month == 1 ? year + 1  : year

    Date.parse("01. #{next_month}. #{next_year}")
  end
end
