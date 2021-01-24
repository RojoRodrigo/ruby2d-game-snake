module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)
    
    if position_is_valid?(state, next_position)
      move_snake_to(state, next_position)
    else
      end_game(state)
    end
  end

  private
  def calc_next_position(state)
    current_position = state.snake.positions.first

    case state.next_direction
    when UP
      # decrement row
      return Model::Cord.new(
        current_position.row - 1,
        current_position.col
      )
    when RIGHT
      # increment col
      return Model::Cord.new(
        current_position.row,
        current_position.col + 1
      )
    when DOWN
      # increment row
      return Model::Cord.new(
        current_position.row + 1,
        current_position.col
      )
    when LEFT
      # decrement col
      return Model::Cord.new(
        current_position.row,
        current_position.col - 1
      )
    end
  end

  private
  def position_is_valid?(state, position)
    is_invalid = (
      (position.row >= state.grid.rows || position.row < 0) ||
      (position.col >= state.grid.cols || position.col < 0)
    )

    return false if is_invalid

    return !(state.snake.positions.include? position)
  end

  private
  def move_snake_to(state, next_position)
    new_positions = [next_position] + state.snake.positions[0...-1]
    state.snake.positions = new_positions
    state
  end

  private
  def end_game
    state.game_finished = true
    state
  end
end