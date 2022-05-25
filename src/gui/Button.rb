class Button < Emitter
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text, texture, number_frames = 3)
    super()
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @texture = texture
    @number_frames = number_frames
    create_interface
  end

  #--------------------------------------------------------------------------
  # * Create a interface
  #--------------------------------------------------------------------------
  def create_interface
    @button = @texture #
    @frameHeight = (@button[:height] / @number_frames)
    @sourceRec = Rectangle.create(0, 0, @button[:width], @frameHeight)
    @btnBounds = Rectangle.create(GetScreenWidth() / 2.0 - @button[:width] / 2.0, GetScreenHeight() / 2.0 - @button[:height] / @number_frames / 2.0, @button[:width], @frameHeight)
    @btnState = 0
    @btnAction = false
    @mouse_pos = Vector2.create(0, 0)
    @fxButton = OE.sound("decision")
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    DrawTextureRec(@button, @sourceRec, Vector2.create(@btnBounds[:x], @btnBounds[:y]), WHITE)
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    @mouse_pos = GetMousePosition()
    @btnAction = false
    update_state
    @sourceRec[:y] = @btnState * @frameHeight
    draw
  end

  #--------------------------------------------------------------------------
  # * Update state of a Button
  #--------------------------------------------------------------------------
  def update_state
    if (CheckCollisionPointRec(@mouse_pos, @btnBounds))
      if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
        @btnState = 2
      else
        @btnState = 1
      end
      if IsMouseButtonReleased(MOUSE_BUTTON_LEFT)
        @btnAction = true
      end
    else
      @btnState = 0
    end
    if @btnAction
      PlaySound(@fxButton)
      emit(:clickbutton)
    end
  end

  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    UnloadSound(@fxButton)
  end
end
