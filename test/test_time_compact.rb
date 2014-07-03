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
end
