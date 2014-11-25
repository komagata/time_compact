require_relative 'time_compact/version'
require_relative 'time_compact/railtie' if defined? Rails
require 'i18n'
require 'yaml'

module TimeCompact
  def time_compact(time, *options)
    now, opts = time_compact_process_optional_args(options)

    opts = {
      i18n_key_prefix: ''
    }.merge(opts)

    locale_dir = File.expand_path('../../locale', __FILE__)
    I18n.enforce_available_locales = true
    I18n.load_path += Dir["#{locale_dir}/*.yml"]
    messages = I18n.t(time_compact_i18n_key(opts[:i18n_key_prefix]))

    if time.year == now.year
      if time.month == now.month
        if time.day == now.day
          if time.hour == now.hour
            time.strftime(messages[:same_hour])
          else
            time.strftime(messages[:same_day])
          end
        else
          time.strftime(messages[:same_month])
        end
      else
        time.strftime(messages[:same_year])
      end
    else
      time.strftime(messages[:other])
    end
  end

  private

  def time_compact_process_optional_args(args)
    case args[0]
    when Time, DateTime
      [args[0], args[1] || {}]
    when Hash
      [Time.now, args[0]]
    else
      [Time.now, {}]
    end
  end

  def time_compact_i18n_key(prefix = '')
    ['time_compact', prefix].reject(&:empty?).join('.')
  end
end
