# Ripify

This provides a simple binary that allows you to generate
[Ripper](http://ruby-doc.org/stdlib-2.3.0/libdoc/ripper/rdoc/Ripper.html)
output.

**Example Usage:**
```sh
$ ripify lex < file.rb > file.lex.out # Lex file.rb, output into file.lex.out
$ ripify parse < file.rb # Lex file.rb, output to stdout
```

Find out more with:
```sh
$ ripify --help
```

## Installation

Currently it's best to install this locally.  Run:

```sh
$ git clone git@github.com:jmcdonald-ut/ripify.git
$ cd ripify
$ bundle install
$ bundle exec rake install
```

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
