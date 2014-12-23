# encoding: utf-8
require 'minitest/autorun'
require 'minitest/unit'
require_relative '../lib/time_compact'

class TestTimeCompact < MiniTest::Test
  def setup
    I18n.enforce_available_locales = true
    I18n.available_locales = [:en, :ja]
    @object = Object.new
    @object.extend TimeCompact
  end

  def test_time_compact_en
    I18n.locale = 'en'
    assert_equal '2014/1/1', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2015, 1, 1, 0, 0, 0)
    ), 'defferent year'
    assert_equal '1/1', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 2, 1, 0, 0, 0)
    ), 'same year'
    assert_equal '1/1', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 2, 0, 0, 0)
    ), 'same month'
    assert_equal '0:00', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 1, 0, 0)
    ), 'same day'
    assert_equal '0 min', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 0, 1, 0)
    ), 'same hour'
  end

  def test_time_compact_en_verbose
    I18n.locale = 'en'
    assert_equal '2014/1/1 0:00', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2015, 1, 1, 0, 0, 0),
      i18n_key_prefix: :verbose
    ), 'defferent year'
    assert_equal '1/1 0:00', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 2, 1, 0, 0, 0),
      i18n_key_prefix: :verbose
    ), 'same year'
    assert_equal '1/1 0:00', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 2, 0, 0, 0),
      i18n_key_prefix: :verbose
    ), 'same month'
    assert_equal '0:00', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 1, 0, 0),
      i18n_key_prefix: :verbose
    ), 'same day'
    assert_equal '0 min', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 0, 1, 0),
      i18n_key_prefix: :verbose
    ), 'same hour'
  end

  def test_time_compact_ja
    I18n.locale = 'ja'
    assert_equal '2014年1月1日', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2015, 1, 1, 0, 0, 0)
    ), 'defferent year'
    assert_equal '1月1日', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 2, 1, 0, 0, 0)
    ), 'same year'
    assert_equal '1日', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 2, 0, 0, 0)
    ), 'same month'
    assert_equal '0時0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 1, 0, 0)
    ), 'same day'
    assert_equal '0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 0, 1, 0)
    ), 'same hour'
  end

  def test_time_compact_ja_verbose
    I18n.locale = 'ja'
    assert_equal '2014年1月1日 0時0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2015, 1, 1, 0, 0, 0),
      i18n_key_prefix: 'verbose'
    ), 'defferent year'
    assert_equal '1月1日 0時0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 2, 1, 0, 0, 0),
      i18n_key_prefix: 'verbose'
    ), 'same year'
    assert_equal '1日 0時0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 2, 0, 0, 0),
      i18n_key_prefix: 'verbose'
    ), 'same month'
    assert_equal '0時0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 1, 0, 0),
      i18n_key_prefix: 'verbose'
    ), 'same day'
    assert_equal '0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 0, 1, 0),
      i18n_key_prefix: 'verbose'
    ), 'same hour'
  end

  def test_time_compact_process_optional_args
    time = Time.new(2014, 1, 1, 0, 0, 0)

    Time.stub(:now, time) do
      assert_equal [time, {}],
        @object.send(:time_compact_process_optional_args, []),
        'no optional args'

      assert_equal [time, { awesome_option: 'yaay!' }],
        @object.send(:time_compact_process_optional_args,
          [{ awesome_option: 'yaay!' }]),
        'only options hash is passed'
    end

    assert_equal [time, {}],
      @object.send(:time_compact_process_optional_args, [time]),
      'only time is passed'

    assert_equal [time, { fantastic_option: 'woohoo!!!' }],
      @object.send(:time_compact_process_optional_args,
        [time, { fantastic_option: 'woohoo!!!' }]),
      'time and options hash are passed'
  end

  def test_time_compact_i18n_key
    assert_equal 'time_compact.other',
      @object.send(:time_compact_i18n_key, :none),
      'for same to :none with no prefix'
    assert_equal 'time_compact.same_hour',
      @object.send(:time_compact_i18n_key, :hour),
      'for same to :hour with no prefix'
    assert_equal 'time_compact.same_day',
      @object.send(:time_compact_i18n_key, :day),
      'for same to :day with no prefix'

    assert_equal 'time_compact.prefix.same_hour',
      @object.send(:time_compact_i18n_key, :hour, 'prefix'),
      'for same to :hour with no prefix'
    assert_equal 'time_compact.prefix.same_day',
      @object.send(:time_compact_i18n_key, :day, 'prefix'),
      'for same to :day with no prefix'
  end

  def test_time_compact_i18n_key_prefix
    assert_equal 'time_compact', @object.send(:time_compact_i18n_key_prefix),
                 'no prefix'
    assert_equal 'time_compact.additional',
                 @object.send(:time_compact_i18n_key_prefix, 'additional'),
                 'with prefix'
  end

  def test_time_compact_times_same_to
    assert_equal :hour,
                 @object.send(:time_compact_times_same_to,
                              Time.new(2014, 12, 12, 10, 00),
                              Time.new(2014, 12, 12, 10, 30)),
                 'same to hour'

    assert_equal :day,
                 @object.send(:time_compact_times_same_to,
                              Time.new(2014, 12, 12, 10, 00),
                              Time.new(2014, 12, 12, 11, 00)),
                 'same to day'

    assert_equal :month,
                 @object.send(:time_compact_times_same_to,
                              Time.new(2014, 12, 12, 10, 00),
                              Time.new(2014, 12, 24, 10, 00)),
                 'same to month'

    assert_equal :year,
                 @object.send(:time_compact_times_same_to,
                              Time.new(2014, 11, 12, 10, 00),
                              Time.new(2014, 12, 12, 10, 00)),
                 'same to year'

    assert_equal :none,
                 @object.send(:time_compact_times_same_to,
                              Time.new(2014, 12, 12, 10, 00),
                              Time.new(2015, 12, 12, 10, 00)),
                 'same to none'
  end
end
