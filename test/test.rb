$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'i18n/backend/shiftpush'
require 'minitest/autorun'

I18n.load_path = Dir['test/locales/*.yml']
I18n.backend = I18n::Backend::Shiftpush.new

class Test < Minitest::Test
  def test_simple
    assert_equal('Hi',    I18n.t('foo.bar', locale: :en))
    assert_equal('Hallo', I18n.t('foo.bar', locale: :de))
  end

  def test_hash
    assert_equal({ key: 'value' }, I18n.t('foo.hash', locale: :en))
    assert_equal({ key: 'Wert' },  I18n.t('foo.hash', locale: :de))
  end

  def test_count
    assert_equal('none',  I18n.t('foo.count', count: 0, locale: :en))
    assert_equal('keine', I18n.t('foo.count', count: 0, locale: :de))
  end
end
