class CheckBox < Gui
  def initialize(x, y, text = "",
                 check_size: 24, font_color: WHITE, space_between: 8, icon_color: WHITE, border_size: 2)
    super()
    @x = x
    @y = y
    @height = check_size
    @text = text
    @check_size = check_size
    @font_color = font_color
    @icon_color = icon_color
    @border_size = border_size
    @space_between = space_between
    calculate_responsivity
  end

  def calculate_responsivity
    @size_text = MeasureText(@text, @check_size)
    @width = @size_text + @check_size + @border_size
    @btn_bounds = Rectangle.create(@x, @y, @width, @height + @space_between)
    # Load Font Awesome and Unicode Chars
    @simbols = [0xf14a, 0xf0c8].pack("LL") # Necessary to convert the codepoints to a string
    @font_solid = LoadFontEx("resources/fonts/fa_font_solid.otf", @check_size, @simbols, 2)
    @font_line = LoadFontEx("resources/fonts/fa_font.otf", @check_size, @simbols, 2)
  end

  def draw
    super()
    draw_check
    DrawText(@text, @x + (@width / 2) - (@size_text / 2) + @space_between + @border_size, @btn_bounds[:y] + @space_between - @border_size, @check_size, @font_color)
  end

  def draw_check
    if @check == 1
      DrawTextCodepoint(@font_solid, 0xf14a, Vector2.create(@x, @y + @space_between - @border_size), @check_size, @icon_color)
    end
    DrawTextCodepoint(@font_line, 0xf0c8, Vector2.create(@x, @y + @space_between - @border_size), @check_size, @icon_color)
  end

  def update
    super
    draw
    in_area(@btn_bounds)
  end

  def dispose
    super()
  end
end
