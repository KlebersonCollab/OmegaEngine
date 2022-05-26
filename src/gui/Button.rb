class Button < Gui
  attr_accessor :x, :y, :width, :height, :btn_bounds
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text, texture, font_size = 20, font_color = WHITE, space_between = 8)
    super()
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @button = texture
    @font_size = font_size
    @font_color = font_color
    @space_between = space_between
    create_interface
  end

  #--------------------------------------------------------------------------
  # * Create a interface
  #--------------------------------------------------------------------------
  def create_interface
    @btn_bounds = Rectangle.create(@x, @y, @width, @height)
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super()
    case @btn_state
    when 0 # Mouse
      DrawRectangle(@x, @y, @width, @height, RED)
    when 1
      DrawRectangle(@x, @y, @width, @height, MAROON)
    when 2
      DrawRectangle(@x, @y, @width, @height, ORANGE)
    end
    DrawRectangleLines(@x, @y, @width, @height, @font_color)
    DrawRectangleLines(@x, @y, @width + 1, @height + 1, WHITE)
    DrawText(@text.center((@btn_bounds[:width] / @text.size)), @btn_bounds[:x], @btn_bounds[:y] + @space_between, @font_size, @font_color)
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    super
    update_state
    draw
  end

  #--------------------------------------------------------------------------
  # * Update state of a Button
  #--------------------------------------------------------------------------
  def update_state
    in_area(@btn_bounds)
  end

  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    super()
    UnloadSound(@fx_button)
  end
end
