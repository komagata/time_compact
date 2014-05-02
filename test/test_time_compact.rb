require 'minitest/unit'
require 'minitest/autorun'
require_relative '../lib/time_compact'

class TestTimeCompact < MiniTest::Unit::TestCase
  def setup
    @object = Object.new
    @object.extend TimeCompact
  end

  def test_time_compact_en
    I18n.locale = 'en'
    assert_equal '2014/1/1', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2015, 1, 1, 0, 0, 0)
    )
    assert_equal '1/1', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 2, 1, 0, 0, 0)
    )
    assert_equal '1/1', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 2, 0, 0, 0)
    )
    assert_equal '0:0', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 1, 0, 0)
    )
    assert_equal '0 min', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 0, 1, 0)
    )
  end

  def test_time_compact_ja
    I18n.locale = 'ja'
    assert_equal '2014年1月1日', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2015, 1, 1, 0, 0, 0)
    )
    assert_equal '1月1日', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 2, 1, 0, 0, 0)
    )
    assert_equal '1日', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 2, 0, 0, 0)
    )
    assert_equal '0時0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 1, 0, 0)
    )
    assert_equal '0分', @object.time_compact(
      Time.new(2014, 1, 1, 0, 0, 0),
      Time.new(2014, 1, 1, 0, 1, 0)
    )
  end
end
