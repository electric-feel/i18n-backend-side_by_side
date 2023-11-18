require 'yaml'
require 'fileutils'

module I18n
  class SideBySideConverter
    LOCALE_SUFFIX_PATTERN = /\.([a-z]{2,3})(?:\.yml)$/ # To match '*.en.yml', '*.de.yml', etc.
    LOCALE_PREFIX = '_'

    def initialize(locales_dir)
      @locales_dir = locales_dir
    end

    def convert_to_side_by_side
      file_translation_pairs = prepare_conversion_to_side_by_side
      write_contents(file_translation_pairs)
    end

    def prepare_conversion_to_side_by_side
      grouped_files = group_files_by_basename
      grouped_files.map do |base_name, files|
        combined_translations = {}

        files.each do |file|
          lang_code = file.match(LOCALE_SUFFIX_PATTERN)[1]
          content = YAML.load_file(file)

          # Assuming the content always has one root key, e.g., 'en:', 'de:', etc.
          root_key = content.keys.first
          nested_insert_language_key(content[root_key], combined_translations, "#{LOCALE_PREFIX}#{lang_code}")
        end

        [base_name, { LOCALE_PREFIX => combined_translations }]
      end
    end

    private

    def group_files_by_basename
      translation_files = Dir[File.join(@locales_dir, '*.yml')]
      translation_files.group_by { |f| f.gsub(LOCALE_SUFFIX_PATTERN, '') }
    end

    def write_contents(file_base_translation_pairs)
      file_translation_pairs.each do |file_name_base, translations|
        File.open("#{file_name_base}.yml", 'w') do |file|
          file.write(translations.to_yaml)
        end
      end
    end

    def nested_insert_language_key(content, combined_translations, lang_key)
      content.each do |key, value|
        if value.is_a?(Hash)
          combined_translations[key] ||= {}
          nested_insert_language_key(value, combined_translations[key], lang_key)
        else
          combined_translations[key] ||= {}
          combined_translations[key][lang_key] = value
        end
      end
    end
  end
end
