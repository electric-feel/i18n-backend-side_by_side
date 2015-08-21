$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'i18n/backend/shiftpush'
require 'minitest/autorun'

I18n.load_path = Dir['test/locales/*.yml']
I18n.config.backend = I18n::Backend::Shiftpush.new
I18n.enforce_available_locales = false

class Test < Minitest::Test
  def test_simple
    assert_equal(I18n.t('foo.bar', locale: :en), 'Hi')
    assert_equal(I18n.t('foo.bar', locale: :de), 'Hallo')
  end

  def test_hash
    assert_equal(I18n.t('foo.hash', locale: :en), key: 'value')
    assert_equal(I18n.t('foo.hash', locale: :de), key: 'Wert')
  end

  def test_count
    assert_equal(I18n.t('foo.count', locale: :en, count: 0), 'none')
    assert_equal(I18n.t('foo.count', locale: :de, count: 0), 'keine')
  end
end
