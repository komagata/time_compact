# TimeCompact

Displays time compactly.

for example:

    # default locale
    2014/1/2 # on other year.
    1/2      # on same year.
    8:16     # on same day.

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

You can customize the format.

    # config/locales/en.yml:
    en:
      time_compact:
        same_year:  '%1m/%1d'
        same_month: '%1m/%1d'
        same_day:   '%1H:%M'
        same_hour:  '%1M min'
        other:      '%Y/%1m/%1d'

    # config/locales/ja.yml:
    ja:
      time_compact:
        same_year:  '%1m月%1d日'
        same_month: '%1d日'
        same_day:   '%1H時%1M分'
        same_hour:  '%1M分'
        other:      '%Y年%1m月%1d日'

## Contributing

1. Fork it ( https://github.com/komagata/time_compact/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
