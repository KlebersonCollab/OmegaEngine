#------------------------------------------------------------------------------
# * Master class for GUI
#------------------------------------------------------------------------------
class Gui < Emitter
  #------------------------------------------------------------------------------
  # * Initial
  #------------------------------------------------------------------------------
  def initialize()
    super()
    @mouse_pos = Vector2.create(0, 0)
    @fxButton = OE.sound("decision")
    @btnState = 0
    @btnAction = false
    @centerX = GetScreenWidth() / 2
    @centerY = GetScreenHeight() / 2
    @font = GetFontDefault()
  end

  #------------------------------------------------------------------------------
  # * Draw Method
  #------------------------------------------------------------------------------
  def draw
  end

  #------------------------------------------------------------------------------
  # * Update
  #------------------------------------------------------------------------------
  def update
    @mouse_pos = GetMousePosition()
    @btnAction = false
  end

  #------------------------------------------------------------------------------
  # * Play Click Sound
  #------------------------------------------------------------------------------
  def play_click_sound
    PlaySound(@fxButton)
  end

  #------------------------------------------------------------------------------
  # * Check Mouse Position in area GUI
  #------------------------------------------------------------------------------
  def in_area(btn_bounds)
    if (CheckCollisionPointRec(@mouse_pos, btn_bounds))
      mouse_click
      mouse_on
    else
      @btnState = 0
    end
    action
  end

  #------------------------------------------------------------------------------
  # * Check Mouse Click
  #------------------------------------------------------------------------------
  def mouse_click
    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      @btnState = 2
    else
      @btnState = 1
    end
  end

  #------------------------------------------------------------------------------
  # * Check Mouse released
  #------------------------------------------------------------------------------
  def mouse_on
    if IsMouseButtonReleased(MOUSE_BUTTON_LEFT)
      @btnAction = true
    end
  end

  #------------------------------------------------------------------------------
  # * Action if status action = true
  #------------------------------------------------------------------------------
  def action
    if @btnAction
      play_click_sound
      emit(:clickbutton)
    end
  end

  def dispose
  end
end
