module UpdateMap
  def reset_screen
    print "\e[2J\e[H"
  end

  def reset_map
    self.presenting_map = dup_map
  end


  def place_character
    presenting_map[current_square[0]][current_square[1]] = character
  end

  def print_map(map_array=nil)
    (map_array || presenting_map).each { |row| puts row.join("") }
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