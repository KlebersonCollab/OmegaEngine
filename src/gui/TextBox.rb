class TextBox < Gui
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text = "", font_size: 20, font_color: WHITE, space_between: 8, max_input: 10)
    super
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @font_size = font_size
    @font_color = font_color
    @space_between = space_between
    @max_input =  max_input
    start
  end

  def start
    @letter_count = 0
    @frames_counter = 0
    @btn_bounds = Rectangle.create(@x, @y, @width, @height)
    @size_text = MeasureText(@text, @font_size)
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super
    case @btn_state
      when 0
        DrawRectangleLines(@btn_bounds[:x], @btn_bounds[:y], @btn_bounds[:width], @btn_bounds[:height], RED)
      when 1
        DrawRectangleLines(@btn_bounds[:x], @btn_bounds[:y], @btn_bounds[:width], @btn_bounds[:height], MAROON)
    end
    DrawText(@text, @btn_bounds[:x] + 5, @btn_bounds[:y] + 8, @font_size, MAROON)
    return if !@active
    if (@frames_counter/20) % 2 == 0
      DrawText("_", @btn_bounds[:x] + 8 + MeasureText(@text, @font_size), @btn_bounds[:y] + 12, @font_size, MAROON)
    end
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    super
    @frames_counter += 1
    in_area?(@btn_bounds)
    get_input
  end

  def get_input
    return if !@active
    @key = GetCharPressed()
    while (@key > 0)
      if ((@key >= 32) && (@key <= 125) && (@text.size < @max_input))
        @text += @key.chr
      end
      @key = GetCharPressed()
    end
    if IsKeyPressed(KEY_BACKSPACE)
      @text = @text.chop! if @text.size > 0
    end
  end
  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    super
  end
end
