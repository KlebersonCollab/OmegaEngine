class Button < Gui
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text = "", font_size: 20, font_color: WHITE, space_between: 8)
    super
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @font_size = font_size
    @font_color = font_color
    @size_text = MeasureText(@text, @font_size)
    @space_between = space_between
    @button = OE.gui("Button")
    @frame_height = @button[:height]/3
    @btn_bounds = Rectangle.create(@x, @y, @width, @height)
    @source_rect =  Rectangle.create(0, 0, @button[:width], @frame_height)
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super
    DrawTextureRec(@button, @source_rect, Vector2.create(@btn_bounds[:x], @btn_bounds[:y]), WHITE)
    DrawText(@text, @x + (@width / 2) - (@size_text / 2), @btn_bounds[:y] + @space_between + @text.size/2, @font_size, @font_color)
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    super
    in_area?(@btn_bounds)
    @source_rect[:y] = @btn_state * @frame_height
  end

  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    super
    UnloadSound(@fx_button)
  end
end
