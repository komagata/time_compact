# TimeCompact

Show time in compact style.

for example:

    # default locale
    2014/1/2 # when other year.
    1/2      # when same year.
    8:16     # when same day.

    # 日本語ロケール
    2014年1月2日 # 違う年の時
    1月2日       # 同じ年の時
    8時16分      # 同じ日の時

## Installation

Add this line to your application's Gemfile:

    gem 'time_compact'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_compact

## Usage

    require 'time_compact'

    include TimeCompact
    time_compact Time.new(2014, 1, 1, 0, 0, 0) # => 5/2

In rails

    <%= time_compact @post.created_at %>

## Contributing

1. Fork it ( https://github.com/[my-github-username]/time_compact/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
