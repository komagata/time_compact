require_relative 'time_compact/version'
require_relative 'time_compact/railtie' if defined? Rails
require 'i18n'
require 'yaml'

module TimeCompact
  LOCALE_DIR = File.expand_path('../../locale', __FILE__)

  def time_compact(time, now = Time.now)
    I18n.enforce_available_locales = true
    I18n.load_path += Dir[LOCALE_DIR + '/*.yml']

    if time.year == now.year
      if time.month == now.month
        if time.day == now.day
          if time.hour == now.hour
            time.strftime(fetch_locale('same_hour'))
          else
            time.strftime(fetch_locale('same_day'))
          end
        else
          time.strftime(fetch_locale('same_month'))
        end
      else
        time.strftime(fetch_locale('same_year'))
      end
    else
      time.strftime(fetch_locale('other'))
    end
  end

  private

  def fetch_locale(name)
    yml = YAML.load_file("#{LOCALE_DIR}/#{I18n.locale}.yml")
    yml[I18n.locale.to_s]['time_compact'][name]
  end
end
