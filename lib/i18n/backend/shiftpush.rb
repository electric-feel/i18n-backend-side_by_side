require 'i18n'

module I18n
  module Backend
    class Shiftpush < Simple
      VERSION = File.read(File.expand_path('../../../../VERSION', __FILE__))
      LOCALE_PREFIX = '_'

      protected

      def load_file(filename)
        type = File.extname(filename).tr('.', '').downcase
        raise UnknownFileType.new(type, filename) unless respond_to?(:"load_#{type}", true)
        data = send(:"load_#{type}", filename)
        unless data.is_a?(Hash)
          raise InvalidLocaleData.new(filename, 'expects it to return a hash, but does not')
        end

        if data.first.first == LOCALE_PREFIX
          _process([], data[LOCALE_PREFIX].deep_symbolize_keys)
        else
          data.each { |locale, d| store_translations(locale, d || {}) }
        end
      end

      private

      def _process(path, hash)
        if _contains_locales?(hash)
          hash.each do |locale, value|
            _store([_strip_locale_prefix(locale)] + path, value)
          end
        else
          hash.each { |key, value| _process(path + [key], value) }
        end
      end

      def _store(path, value)
        *keys, last_key = path
        target = keys.inject(translations) do |hash, key|
          hash[key] ||= {}
          hash[key]
        end
        target[last_key] = value
      end

      def _contains_locales?(hash)
        hash.first.first[0] == LOCALE_PREFIX
      end

      def _strip_locale_prefix(locale)
        locale[LOCALE_PREFIX.length..-1].to_sym
      end
    end
  end
end
