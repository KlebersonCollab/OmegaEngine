class TextBox < Gui
  attr_accessor :text
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text = "", font_size: 20, font_color: WHITE, space_between: 8, max_input: 10, pass: false)
    super
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @real_text = ""
    @font_size = font_size
    @font_color = font_color
    @space_between = space_between
    @max_input =  max_input
    @pass = pass
    start
  end
  #--------------------------------------------------------------------------
  # * Start variables
  #--------------------------------------------------------------------------
  def start
    @frames_counter = 0
    @btn_bounds = Rectangle.create(@x, @y, @width, @height)
    @size_text = MeasureText(@text, @font_size)
  end
  #--------------------------------------------------------------------------
  # * Setter text
  #--------------------------------------------------------------------------
  def text=(text)
    @text = text
  end
  #--------------------------------------------------------------------------
  # * Getter text
  #--------------------------------------------------------------------------
  def text
    return @text
  end
  #--------------------------------------------------------------------------
  # * Getter real text
  #--------------------------------------------------------------------------
  def real_text
    return @real_text
  end
  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super
    DrawRectangleRec( @btn_bounds, LIGHTGRAY)
    DrawRectangleLines(@btn_bounds[:x], @btn_bounds[:y], @btn_bounds[:width], @btn_bounds[:height], WHITE) if @btn_state == 0
    DrawRectangleLines(@btn_bounds[:x], @btn_bounds[:y], @btn_bounds[:width], @btn_bounds[:height], MAROON) if @active or @btn_state == 1
    DrawText(@text, @btn_bounds[:x] + 5, @btn_bounds[:y] + 8, @font_size, WHITE) if @active or @btn_state == 0
    DrawText(@text, @btn_bounds[:x] + 5, @btn_bounds[:y] + 8, @font_size, MAROON) if @active or @btn_state == 1
    draw_blinking
  end
  #--------------------------------------------------------------------------
  # * Draw blinking
  #--------------------------------------------------------------------------
  def draw_blinking
    return if !@active
    #Draw looping 2 sec
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
    get_key_pressed
  end
  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def get_key_pressed
    return if !@active
    @key = GetCharPressed()
    while (@key > 0)
      if ((@key >= 32) && (@key <= 125) && (@text.size < @max_input)) && !@pass
        @text += @key.chr
      end
      if ((@key >= 32) && (@key <= 125) && (@text.size < @max_input)) && @pass
        @text += "*"
        @real_text += @key.chr
      end
      @key = GetCharPressed()
    end
    if IsKeyPressed(KEY_BACKSPACE)
      @text = @text.chop! if @text.size > 0
      @real_text = @real_text.chop! if @real_text.size > 0
    end
  end
  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    super
  end
end
