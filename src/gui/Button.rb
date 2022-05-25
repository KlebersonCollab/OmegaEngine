class Button < Gui
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text, texture, number_frames = 3, font_size = 20, font_color = WHITE, space_between = 8)
    super()
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @texture = texture
    @number_frames = number_frames
    @space_between = space_between
    @font_size = font_size
    @font_color = font_color
    create_interface
  end

  #--------------------------------------------------------------------------
  # * Create a interface
  #--------------------------------------------------------------------------
  def create_interface
    @button = @texture
    @frame_height = (@button[:height] / @number_frames)
    @source_rec = Rectangle.create(0, 0, @button[:width], @frame_height)
    @btn_bounds = Rectangle.create(@x, @y, @button[:width], @frame_height)
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super()
    DrawTextureRec(@button, @source_rec, Vector2.create(@btn_bounds[:x], @btn_bounds[:y]), WHITE)
    DrawText(@text.center((@btn_bounds[:width] / @text.size)), @btn_bounds[:x], @btn_bounds[:y] + @space_between, @font_size, @font_color)
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    super
    update_state
    draw
    @source_rec[:y] = @btn_state * @frame_height
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
