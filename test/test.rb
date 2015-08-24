$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'i18n/backend/side_by_side'
require 'minitest/autorun'

I18n.load_path = Dir['test/locales/*.yml']
I18n.backend = I18n::Backend::SideBySide.new

class Test < Minitest::Test
  def test_oldschool
    assert_equal('Still here',      I18n.t('oldschool', locale: :en))
    assert_equal('Immer noch hier', I18n.t('oldschool', locale: :de))
  end

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

  def test_partially_missing
    assert_equal('some value', I18n.t('foo.only_en.some_key', locale: :en))
    assert_equal({ some_key: 'some value' }, I18n.t('foo.only_en', locale: :en))
    assert_raises { I18n.t('foo.only_en.some_key', locale: :de, raise: true) }
    assert_raises { I18n.t('foo.only_en', locale: :de, raise: true) }
  end
end
