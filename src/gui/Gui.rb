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
    @fx_button = OE.sound("decision")
    @btn_state = 0
    @btn_action = false
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
    @btn_action = false
  end

  #------------------------------------------------------------------------------
  # * Play Click Sound
  #------------------------------------------------------------------------------
  def play_click_sound
    PlaySound(@fx_button)
  end

  #------------------------------------------------------------------------------
  # * Check Mouse Position in area GUI
  #------------------------------------------------------------------------------
  def in_area(btn_bounds)
    if (CheckCollisionPointRec(@mouse_pos, btn_bounds))
      mouse_click
      mouse_on
    else
      @btn_state = 0
    end
    action
  end

  #------------------------------------------------------------------------------
  # * Check Mouse Click
  #------------------------------------------------------------------------------
  def mouse_click
    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      @btn_state = 2
    else
      @btn_state = 1
    end
  end

  #------------------------------------------------------------------------------
  # * Check Mouse Click
  #------------------------------------------------------------------------------
  def mouse_on
    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT) #IsMouseButtonReleased(MOUSE_BUTTON_LEFT)
      @btn_action = true
    end
  end

  #------------------------------------------------------------------------------
  # * Actions
  #------------------------------------------------------------------------------
  def action
    # Mouse Click in event
    if @btn_action
      play_click_sound
      emit(:click_button)
    end
    # Mouse on event
    if @btn_state == 1
      emit(:mouse_on)
    end
  end

  def dispose
  end
end
