require 'i18n'

module TimeCompact
  def time_compact(time, now = Time.now)
    locale_dir = File.expand_path('../../locale', __FILE__)
    ::I18n.load_path += Dir[locale_dir + "/*.yml"]

    if time.year == now.year
      if time.month == now.month
        if time.day == now.day
          if time.hour == now.hour
            ::I18n.t(
              'same_hour',
              year:  time.year,
              month: time.month,
              day:   time.day,
              hour:  time.hour,
              min:   time.min
            )
          else
            ::I18n.t(
              'same_day',
              year:  time.year,
              month: time.month,
              day:   time.day,
              hour:  time.hour,
              min:   time.min
            )
          end
        else
          ::I18n.t(
            'same_month',
            year:  time.year,
            month: time.month,
            day:   time.day,
            hour:  time.hour,
            min:   time.min
          )
        end
      else
        ::I18n.t(
          'same_year',
          year:  time.year,
          month: time.month,
          day:   time.day,
          hour:  time.hour,
          min:   time.min
        )
      end
    else
      ::I18n.t(
        'other',
        year:  time.year,
        month: time.month,
        day:   time.day,
        hour:  time.hour,
        min:   time.min
      )
    end
  end
end
