require "ruby2d"

module View
  class Ruby2dView
    def initialize
      @pixel_sise = 50
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "snake",
        width: @pixel_sise * state.grid.cols,
        height: @pixel_sise * state.grid.rows
      )
      show
    end

    def render(state)
      render_snake(state)
      render_food(state)
    end

    private
    def render_food(state)
      @food.remove if @food

      extend Ruby2D::DSL

      food = state.food

      @food = Square.new(
        x: food.col * @pixel_sise,
        y: food.row * @pixel_sise,
        size: @pixel_sise,
        color: 'red'
      )
    end

    private
    def render_snake(state)
      @snake_positions.each(&:remove) if @snake_positions
      extend Ruby2D::DSL

      snake = state.snake

      @snake_positions = snake.positions.map do |position|
        Square.new(
          x: position.col * @pixel_sise,
          y: position.row * @pixel_sise,
          size: @pixel_sise,
          color: 'green'
        )
      end
    end
  end
end