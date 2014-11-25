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
                 @object.send(:time_compact_process_optional_args,
                              [time]),
                 'only time is passed'

    assert_equal [time, { fantastic_option: 'woohoo!!!' }],
                 @object.send(:time_compact_process_optional_args,
                              [time, { fantastic_option: 'woohoo!!!' }]),
                 'time and options hash are passed'
  end

  def test_time_compact_i18n_key
    assert_equal 'time_compact', @object.send(:time_compact_i18n_key),
                 'no prefix'
    assert_equal 'time_compact.prefix',
                 @object.send(:time_compact_i18n_key, 'prefix'),
                 'with prefix'
  end
end
