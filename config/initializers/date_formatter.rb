Date::DATE_FORMATS[:day_of_week_date] = lambda { |date|
      day_format = ActiveSupport::Inflector.ordinalize(date.day)
      date.strftime("%A, %B #{day_format}") }

Time::DATE_FORMATS[:date_and_time] = lambda { |date|
      day_format = ActiveSupport::Inflector.ordinalize(date.day)
      date.strftime("%A, %B #{day_format}, %l:%M %p") }
