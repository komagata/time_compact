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
    same_to = time_compact_times_same_to(time, now)
    message = I18n.t(time_compact_i18n_key(same_to, opts[:i18n_key_prefix]))
    time.strftime(message)
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

  def time_compact_i18n_key(same_to, additional = '')
    last_key = (same_to == :none) ? 'other' : "same_#{same_to}"
    time_compact_i18n_key_prefix(additional) + '.' + last_key
  end

  def time_compact_i18n_key_prefix(additional = '')
    ['time_compact', additional.to_s].reject(&:empty?).join('.')
  end

  def time_compact_times_same_to(base_time, compare_time)
    kinds = [:none, :year, :month, :day, :hour]
    kinds.each_with_index do |kind, index|
      next if kind == :none
      break kinds[index - 1] if base_time.send(kind) != compare_time.send(kind)
      break kinds.last if kind == kinds.last
    end
  end
end
