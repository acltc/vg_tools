require "vg_tools/version"
require 'helper_tools/move_methods'
require 'helper_tools/update_map'
require 'helper_tools/place_blocks'
require 'helper_tools/checking_methods'

class String
  {red: 31, green: 32, yellow: 33, blue: 34, purple: 35, teal: 36, white: 37, black: 30}.each { |color, key| define_method("#{color}") { "\e[#{key}m#{self}\e[0m" }}
end


class Maze
  include UpdateMap
  include PlaceBlocks

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
    extend CheckingMethods unless options_hash[:checking_methods] == false
    extend MoveMethods unless options_hash[:move_methods] == false
    @character = options_hash[:character] || "$ ".red
    @target = options_hash[:target] || "@ ".red
    @current_square = options_hash[:starting_player_location] ? check_coordinates("player", options_hash[:starting_player_location],options_hash[:map]) : [1,1]
    @target_location = options_hash[:target_location] ? check_coordinates("target", options_hash[:target_location],options_hash[:map]) : [7,11]
    @map = build_map(options_hash[:map])
    add_many_blocks(options_hash[:blocks],false) if options_hash[:blocks]
    @not_finished = true
    @error_message = @winner = false
    @settings = options_hash
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
    start_time = Time.now.to_f
    yield(self)
    end_time = Time.now.to_f
    time_difference = (end_time - start_time).round(3)
    # minutes = time_difference / 60
    # seconds = time_difference % 60
    # total_time = ""
    # total_time += "#{minutes} Minute" if minutes > 0
    # total_time += "s" if minutes > 1
    # total_time += ", " if minutes > 0 && seconds > 0
    # total_time += "#{seconds} Second" if seconds > 0
    # total_time += "s" if seconds > 1
    puts "Total Time: #{time_difference}"
  end

private

  def build_map(map_options)
    if map_options && map_options[:rows] > 0 && map_options[:cols] > 0
      column_count = map_options[:cols]
      row_count = map_options[:rows]
      if current_square[0] <= row_count && current_square[1] <= column_count && target_location[0] <= row_count && target_location[1] <= column_count
        map_array = []
        map_array << ["╔═"] + ["══"] * column_count + ["╗"]
        row_count.times { map_array << ["║ "] + ["¤ "] * column_count + ["║"] }
        map_array << ["╚═"] + ["══"] * column_count + ["╝"]
      else
        reset_screen
        puts <<-dmap_problem
  There was a problem!

  Map must be big enough to include show character and target.
        dmap_problem
        exit
      end
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
     map_array[target_location[0]][target_location[1]] = target
     map_array
  end

  def check_coordinates(subject, coord_array, map_options)
    if map_options && map_options[:rows] > 0 && map_options[:cols] > 0
        if map_options[:rows] >= coord_array[0] && coord_array[0] > 0 && map_options[:cols] >= coord_array[1] && coord_array[1] > 0
          coord_array
        else
          reset_screen
          puts <<-cmap_problem
    There was a problem!

    You are trying to place your #{subject} on row #{coord_array[0]}, column #{coord_array[1]}
    Map size is currently: #{map_options[:rows]} Rows x #{map_options[:cols]} Columns

    Please adjust your settings and try again
          cmap_problem
          exit
        end
    else
      if 7 >= coord_array[0] && coord_array[0] > 0 && 12 >= coord_array[1] && coord_array[1] > 0
          coord_array
        else
          reset_screen
          puts <<-dmap_problem
    There was a problem!

    You are trying to place your #{subject} on row #{coord_array[0]}, column #{coord_array[1]}
    The default map size is: 7 Rows x 12 Columns

    Please adjust your settings and try again
          dmap_problem
          exit
        end
    end
  end
end


