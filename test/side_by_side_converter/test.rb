$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'i18n/side_by_side_converter'
require 'minitest/autorun'

class Test < Minitest::Test
  def test_converting_to_side_by_side
    converter = I18n::SideBySideConverter.new('test/side_by_side_converter/standard_locales')
    assert_equal(
      converter.prepare_conversion_to_side_by_side,
      [
        ["test/side_by_side_converter/standard_locales/book",
          {
            "_" => {
              "book" => {
                "title" => {
                  "_de" => "Titel",
                  "_en" => "Title"
                },
                "sales"=> {
                  "one" => {
                    "_de" => "eins",
                    "_en" => "one"
                  },
                  "zero" => {
                    "_de" => "keine",
                    "_en" => "none"
                  },
                  "other" => {
                    "_de" => "viele",
                    "_en" => "many"
                  }
                }
              }
            }
          }
        ],
        ["test/side_by_side_converter/standard_locales/user",
          {
            "_" => {
              "user" => {
                "name" => {
                  "_de" => "Name",
                  "_en" => "Name",
                  "_fr" => "Nom"
                },
                "birthdate" => {
                  "_de" => "Geburtsdatum",
                  "_en" => "Birthdate",
                  "_fr" => "Date de naissance"
                },
                "address" => {
                  "_de" => "Adresse",
                  "_en" => "Address",
                  "_fr" => "Adresse"
                }
              }
           }
          }
        ]
      ])
  end
end
