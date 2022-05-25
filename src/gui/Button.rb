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
    @frameHeight = (@button[:height] / @number_frames)
    @sourceRec = Rectangle.create(0, 0, @button[:width], @frameHeight)
    @btnBounds = Rectangle.create(@x, @y, @button[:width], @frameHeight)
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super()
    DrawTextureRec(@button, @sourceRec, Vector2.create(@btnBounds[:x], @btnBounds[:y]), WHITE)
    DrawText(@text.center((@btnBounds[:width] / @text.size)), @btnBounds[:x], @btnBounds[:y] + @space_between, @font_size, @font_color)
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    super
    update_state
    draw
    @sourceRec[:y] = @btnState * @frameHeight
  end

  #--------------------------------------------------------------------------
  # * Update state of a Button
  #--------------------------------------------------------------------------
  def update_state
    in_area(@btnBounds)
  end

  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    super()
    UnloadSound(@fxButton)
  end
end
