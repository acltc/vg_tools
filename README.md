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

#### Convenence

- `:skip_intro` - setting to `true` will skip the report when starting a new wession

#### Add Challenge

- `:move_methods` - setting to `false` will require you to write the following methods to alter the `current_square` attribute. - `Maze#move_up`, `Maze#move_down`, `Maze#move_left`, `Maze#move_right`
- `:checking_methods` - setting to `false` will require you to write the following methods
  - `Maze#moved_to_a_valid_square?` - to check if you've moved `current_square` attribute into a coordinate holding a wall character.
  - `Maze#win?` - to check if `current_square` attribute has reached the target.

#### Customize Board

- `:character` - string value becomes the player character (example: `character: "$ "`)
- `:target` - string value becomes target character (example: `target: "X "`)
- `:starting_player_location` - takes in a 2 coordinate array, places player character on the given coordinates at the begining of the game. (example: `starting_player_location: [1,1]`)
- `:target_location` - takes in a 2 coordinate array, places target on the given coordinates. (example: `target_location: [7,11]`) 
  - note: target location and starting player location must be within map size
- `:map` - takes in a hash with two keys, `:rows` and `:cols` (example: `{rows: 12, cols: 9}`)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

