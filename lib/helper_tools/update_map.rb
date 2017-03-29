module UpdateMap
  def reset_screen
    print "\e[2J\e[H"
  end

  def reset_map
    self.presenting_map = dup_map
  end


  def place_character(alt_map=nil)
    if alt_map
      alt_map[current_square[0]][current_square[1]] = character
    else
      presenting_map[current_square[0]][current_square[1]] = character
    end
  end

  def print_map(map_array=nil)
    (map_array || presenting_map).each { |row| puts row.join("") }
  end

  def update_and_print
    reset_screen
    reset_map
    place_character
    print_map 
  end

private
  def deep_dup(array)
    dup_array = array.dup
    dup_array.map! { |element| element.dup }
  end

  def dup_map
    map.dup.map! { |e| deep_dup(e) }
  end
end