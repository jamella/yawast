require 'minitest/autorun'
require File.dirname(__FILE__) + '/../lib/yawast'
require File.dirname(__FILE__) + '/base'

class TestCommandUtils < Minitest::Test
  include TestBase

  def test_valid_url
    args = ['http://www.apple.com']
    uri = Yawast::Commands::Utils.extract_uri args
    assert_equal uri.to_s, 'http://www.apple.com/'
  end

  def test_partial_url
    args = ['www.apple.com']
    uri = Yawast::Commands::Utils.extract_uri args
    assert_equal uri.to_s, 'http://www.apple.com/'
  end

  def test_invalid_url
    args = ['xxx:\invalid']

    assert_raises URI::InvalidURIError do
      Yawast::Commands::Utils.extract_uri args
    end
  end

  def test_unresolvable_url
    args = ['http://www.gjhgjhbmnbmnvgccf.com']

    assert_raises ArgumentError do
      Yawast::Commands::Utils.extract_uri args
    end
  end
end
