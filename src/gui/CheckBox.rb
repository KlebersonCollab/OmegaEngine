class CheckBox < Gui
  def initialize(x, y, width, height, text, font_size = 20, check_size = 24, font_color = WHITE, space_between = 8)
    super()
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @check_size = check_size
    @font_size = font_size
    @font_color = font_color
    @space_between = space_between
    create_interface
  end

  def create_interface
    @btn_bounds = Rectangle.create(@x, @y, @width, @height)
  end

  def draw
    super()
    draw_check
    DrawRectangleLines(@x, @y, @check_size, @check_size, @font_color)
    DrawText(@text.rjust((@btn_bounds[:width] / @text.size)), @btn_bounds[:x], @btn_bounds[:y] + @space_between, @font_size, @font_color)
  end

  def draw_check
    if @check == 1
      DrawRectangle(@x + @space_between / 2, @y + @space_between / 2, @check_size - @space_between, @check_size - @space_between, RED)
    end
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
