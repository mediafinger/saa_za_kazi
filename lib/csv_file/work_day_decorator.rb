module CSVFile
  class WorkDayDecorator
    def initialize(workday)
      @workday = workday
    end

    def output
      [csv_date, csv_day, "#{formatted(@workday.hours)}h", csv_fromto, "-#{formatted(@workday.breaks)}h", @workday.description]
    end

    private

    def csv_date
      @workday.date.strftime("%d.%m.%Y")
    end

    def csv_day
      @workday.date.strftime("%a")
    end

    def csv_fromto
      if @workday.from && @workday.to
        "#{@workday.from.strftime('%H:%M')} - #{@workday.to.strftime('%H:%M')}"
      else
        " " * 13
      end
    end

    def long_date
      @workday.date.strftime("%a %d.%b.%Y")
    end

    def formatted(hours)
      "%.2f" % hours.to_f
    end
  end
end
