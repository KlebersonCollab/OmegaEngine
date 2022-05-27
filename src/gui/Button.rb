class Button < Gui
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height, text = "",
                 font_size: 20, font_color: WHITE, space_between: 8, border_color: WHITE, border_size: 2, normal: RED, hover: MAROON, click: ORANGE, radius: 20.0)
    super()
    @x = x
    @y = y
    @width = width
    @height = height
    @text = text
    @font_size = font_size
    @font_color = font_color
    @size_text = MeasureText(@text, @font_size)
    @border_color = border_color
    @border_size = border_size
    @radius = radius
    @space_between = space_between
    @state_button = {
      Normal: normal,
      Hover: hover,
      Click: click,
    }
    @btn_bounds = Rectangle.create(@x, @y, @width, @height)
  end

  #--------------------------------------------------------------------------
  # * Draw Button
  #--------------------------------------------------------------------------
  def draw
    super()
    case @btn_state
    when 0
      DrawRectangleRounded(@btn_bounds, @radius, @border_size * 2, @state_button[:Normal])
    when 1
      DrawRectangleRounded(@btn_bounds, @radius, @border_size * 2, @state_button[:Hover])
    when 2
      DrawRectangleRounded(@btn_bounds, @radius, @border_size * 2, @state_button[:Click])
    end
    DrawRectangleRoundedLines(@btn_bounds, @radius, @border_size + 4, @border_size, @border_color)
    DrawText(@text, @x + (@width / 2) - (@size_text / 2), @btn_bounds[:y] + @space_between - @border_size, @font_size, @font_color)
  end

  #--------------------------------------------------------------------------
  # * Update a Button
  #--------------------------------------------------------------------------
  def update
    super
    in_area(@btn_bounds)
    draw
  end

  #--------------------------------------------------------------------------
  # * Dispose sound
  #--------------------------------------------------------------------------
  def dispose
    super()
    UnloadSound(@fx_button)
  end
end
