module CheckingMethods
  def moved_to_a_valid_square?
    %w{▒ ╔ ═ ╗ ╝ ╚ ║}.none? { |character| current_square_on_map.include?(character) }
  end

  def win?
    current_square_on_map == target
  end

private

  def current_square_on_map
    map[current_square[0]][current_square[1]]
  end
end