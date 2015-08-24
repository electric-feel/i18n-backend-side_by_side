# i18n-backend-shiftpush

**Tired of jumping between language files when translating keys? Stop jumping
and have all the languages side by side.**

This gem is a subclass of the default `I18n::Backend::Simple` backend. It
changes the way translations get loaded from files in order to support
specifying the language code anywhere along the key path as opposed to the root
key. This allows for all languages being defined next to each other,
making it easier to translate between them.

## How It Works

Let's assume your app supports English, Spanish, and German. You probably have
one file per language:

```
locales/
  view.en.yml
  view.es.yml
  view.de.yml
```

The files might look something like this (e.g. `locales/en.yml`):

```yaml
en:
  view:
    title: Welcome
    inbox:
      zero: You have no messages
      one: You have one message
      other: 'You have %{count} messages'
```

Whenever you have to add or modify a key, you have to edit all files. Also, you
can't see all translations at once for a specific key. With this gem you can
merge all the files and specify the translation for a key at that key:

```yaml
_:
  view:
    title:
      _en: Welcome
      _es: Bienvenido
      _de: Willkommen
    inbox:
      _en:
        zero: You have no messages
        one: You have one message
        other: 'You have %{count} messages'
      _es:
        zero: No tiene mensajes
        one: Tienes un mensaje
        other: 'Tienes %{count} messajes'
      _de:
        zero: Du hast keine Nachrichten
        one: Du hast eine Nachricht
        other: 'Du hast %{count} Nachrichten'
```

Two things to note here:

1. The root key is an underscore. Omitting it results in the file being
   processed as a regular translation file, without support for side-by-side
   translations.

2. The language codes are prefixed with an underscore. This is needed in order
   to distinguish a language code key from a normal key. This also means that
   regular keys can't start with an underscore.

When the files get loaded, they're transformed on the fly to the original format
by moving the language code to the beginning of the key path:

```
_.foo.bar._en            => en.foo.bar
_.foo.bar._en-UK.abc.xyz => en-UK.foo.bar.abc.xyz
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n-backend-shiftpush'
```

Set up `I18n` to use an instance of this backend:

```ruby
I18n.backend = I18n::Backend::Shiftpush.new
```

That's it. Continue using `I18n` as you're used to. Happy translating!

## Authors

- Pratik Mukerji ([pmukerji](https://github.com/pmukerji))
- Philipe Fatio ([fphilipe](https://github.com/fphilipe))
