module MoveMethods
  def move_up
    current_square[0] -= 1
  end

  def move_down
    current_square[0] += 1 
  end

  def move_left
    current_square[1] -= 1 
  end

  def move_right
    current_square[1] += 1 
  end
end