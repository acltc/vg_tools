require "vg_tools/version"
require 'helper_tools/move_methods'
require 'helper_tools/update_map'
require 'helper_tools/place_blocks'
require 'helper_tools/checking_methods'

class String
  {red: 31, green: 32, yellow: 33, purple: 34, pink: 35, blue: 36, white: 37, black: 30}.each { |color, key| define_method("#{color}") { "\e[#{key}m#{self}\e[0m" }}
end


class Maze

  attr_accessor :character, 
                :not_finished, 
                :current_square, 
                :target, 
                :error_message, 
                :map, 
                :target_location, 
                :winner,
                :presenting_map

  def initialize(options_hash={})
    extend UpdateMap unless options_hash[:update_map] == false
    extend PlaceBlocks unless options_hash[:place_blocks] == false
    extend CheckingMethods unless options_hash[:checking_methods] == false
    extend MoveMethods unless options_hash[:move_methods] == false
    @character = options_hash[:character] || "🚶 "
    @target = options_hash[:target] || "🍪 "
    @current_square = options_hash[:starting_square] || [1,1]
    @target_location = options_hash[:target_location] || [7,11]
    @map = build_map(options_hash[:map])
    add_many_blocks(options_hash[:blocks],false) if options_hash[:blocks]
    @not_finished = true
    @error_message = false
    @winner = false
  end

  def self.session(options_hash={})
    game_session = self.new(options_hash)
    unless options_hash[:skip_intro]
      dots = ""
      4.times do
        game_session.reset_screen
        puts "Starting New Session#{dots}"
        sleep 0.6
        dots += "."
      end
      game_session.reset_screen

puts <<-oview
            Game Created
=========================================
 Charater: #{game_session.character}
 Starting Space:
                Row: #{game_session.current_square[0]}
                Col: #{game_session.current_square[1]}
 Target: #{game_session.target}
 Target Location:
                 Row: #{game_session.target_location[0]}
                 Col: #{game_session.target_location[1]}
=========================================
oview

      game_session.reset_map
      game_session.place_character
      game_session.print_map
      sleep 2
    end
    game_session
  end

  def play
    # reset_screen; 
    yield(self)
  end

private

  def build_map(map_options)
    if map_options && map_options[:rows] > 0 && map_options[:cols] > 0
      column_count = map_options[:cols]
      puts column_count
      row_count = map_options[:rows]
      puts row_count
      map_array = []
      map_array << ["╔═"] + ["══"] * column_count + ["╗"]
      row_count.times { map_array << ["║ "] + ["¤ "] * column_count + ["║"] }
      map_array << ["╚═"] + ["══"] * column_count + ["╝"]
    else
      map_array = [["╔═","══","══","══","══","══","══","══","══","══","══","══","══","╗"],
                   ["║ ","¤ ","▒ ","¤ ","¤ ","▒ ","¤ ","¤ ","¤ ","▒ ","¤ ","¤ ","¤ ","║"],
                   ["║ ","¤ ","▒ ","▒ ","¤ ","¤ ","¤ ","▒ ","¤ ","▒ ","¤ ","▒ ","¤ ","║"],
                   ["║ ","¤ ","▒ ","▒ ","▒ ","¤ ","▒ ","▒ ","¤ ","▒ ","¤ ","▒ ","¤ ","║"],
                   ["║ ","¤ ","¤ ","¤ ","¤ ","¤ ","▒ ","¤ ","¤ ","▒ ","¤ ","▒ ","¤ ","║"],
                   ["║ ","¤ ","▒ ","¤ ","▒ ","¤ ","¤ ","¤ ","▒ ","¤ ","¤ ","▒ ","¤ ","║"],
                   ["║ ","¤ ","▒ ","¤ ","▒ ","▒ ","▒ ","▒ ","▒ ","¤ ","▒ ","▒ ","¤ ","║"],
                   ["║ ","¤ ","▒ ","¤ ","¤ ","¤ ","¤ ","¤ ","¤ ","¤ ","▒ ","¤ ","¤ ","║"],
                   ["╚═","══","══","══","══","══","══","══","══","══","══","══","══","╝"]]
     end
     # p target_location
     map_array[target_location[0]][target_location[1]] = target
     map_array
  end
end


