# MdParser

A WIP markdown table parser. -- may never be finished.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'md_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install md_parser

## Usage

  beautify_table("|some | text|\n |in a md |table| \n")  # => same table but pretty

  table_to_hash("|some | text|\n |in a md |table| \n") # => hash of the table content.
  
## Contributing

1. Fork it ( https://github.com/nigelthorne/md_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
