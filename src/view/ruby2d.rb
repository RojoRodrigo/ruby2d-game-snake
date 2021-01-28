require "ruby2d"
require_relative "../model/state"

module View
  class Ruby2dView
    def initialize(app)
      @pixel_sise = 50
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "snake",
        width: @pixel_sise * state.grid.cols,
        height: @pixel_sise * state.grid.rows
      )
      on :key_down do |event|
        handle_key_event(event)
      end
      show
    end

    def render(state)
      extend Ruby2D::DSL
      close if state.game_finished

      render_food(state)
      render_snake(state)
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

    def handle_key_event(event)
      case event.key
      when "up"
        @app.send_action(:change_direction, Model::Direction::UP)
      when "down"
        @app.send_action(:change_direction, Model::Direction::DOWN)
      when "left"
        @app.send_action(:change_direction, Model::Direction::LEFT)
      when "right"
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      end
    end
  end
end