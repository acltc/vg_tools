module PlaceBlocks

  def add_block(row,col,want_print=true,options={color: :purple})
    block_placement("▒ ",row,col,want_print,options)
  end

  def remove_block(row,col,want_print=true,options={color: :purple})
    block_placement("¤ ",row,col,want_print,options)
  end

  def add_many_blocks(block_array,want_print=true)
    many_blocks_placement("▒ ", block_array, want_print)
  end

  def remove_many_blocks(block_array,want_print=true)
    many_blocks_placement("¤ ", block_array, want_print)
  end

  #write method to report the custom settinges
  def print_settings
    @settings[:starting_player_location] = current_square
    @settings[:blocks] = []
    map.each_with_index do |row|
      row.each_with_index do |col|
          
      end
    end
  end

private

  def block_update_print(character,row,col,color)
    show_map = dup_map
    show_map[row][col] = character.send(color)
    print_map(show_map)
  end

  def block_placement(character,row,col,want_print,options)
    map[row][col] = character
    block_update_print(character,row,col,options[:color]) if want_print
    options[:alt_map][row][col] = character.send(options[:color]) if options[:alt_map]
  end

  def many_blocks_placement(character, block_array, want_print)
    block_array.each { |block| block_placement("▒ ",block[0],block[1],false,{color: :purple})}
    if want_print
      show_map = dup_map
      block_array.each { |block| block_placement("▒ ",block[0],block[1], false, alt_map: show_map, color: :purple)}
      print_map(show_map)
    end
  end
end