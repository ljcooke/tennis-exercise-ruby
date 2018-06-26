# Tennis Exercise

This is a Ruby library that provides a scoring system for a tennis tournament.

An example match is provided in [spec/match_spec.rb](spec/match_spec.rb), which can be tested using RSpec.

## Usage Example

First, add the [lib](lib) directory to the load path:

```ruby
$LOAD_PATH.unshift File.expand_path('lib', __dir__)
```

Afterwards, you can import the [tennis](lib/tennis) library and start a [`Tennis::Match`](lib/tennis/match.rb).

```ruby
require 'tennis'

match = Tennis::Match.new('player 1', 'player 2')

match.point_won_by('player 1')
match.point_won_by('player 2')
puts match.score # 0-0, 15-15

match.point_won_by('player 1')
match.point_won_by('player 1')
puts match.score # 0-0, 40-15

match.point_won_by('player 2')
match.point_won_by('player 2')
puts match.score # 0-0, Deuce

match.point_won_by('player 1')
puts match.score # 0-0, Advantage player 1

match.point_won_by('player 1')
puts match.score # 1-0
```

## Testing

To install the dependencies for testing, run:

```
gem install bundler
bundle
```

Then test the specs by running the following:

```
bundle exec rspec
```
