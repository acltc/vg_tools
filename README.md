# Ruby Video Game Tools

VG Tools is a gem built as a learning tool for Anyone Can Learn to Code - Meet Up group.

These tools will allow you to build a video game in basic ruby and play it in the terminal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vg_tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vg_tools

## Setup

To begin a Maze session type in the following code.

```ruby
session = Maze.session
```

You can modify the session to allow for a more personalized game or to make the lesson more advanced.

####Convenence
`:skip_intro` - setting to `true` will skip the report when starting a new wession

####Add Challenge
`:move_methods` - setting to `false` will require you to write the following methods to alter the `current_square` attribute.
  - `Maze#move_up`, `Maze#move_down`, `Maze#move_left`, `Maze#move_right`
`:checking_methods` - setting to `false` will require you to write the following methods to 

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

