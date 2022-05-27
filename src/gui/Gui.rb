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
    @check = 0
    @click = 0
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
    @btn_bounds = btn_bounds
    if (CheckCollisionPointRec(@mouse_pos, btn_bounds))
      mouse_click
      mouse_on_click
      action
    else
      @btn_state = 0
    end
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
  def mouse_on_click
    if IsMouseButtonPressed(MOUSE_BUTTON_LEFT) && CheckCollisionPointRec(@mouse_pos, @btn_bounds)
      @btn_action = true
      @check = 1
      clicked?
    end
  end

  #------------------------------------------------------------------------------
  # * Check if CheckBock is Clicked
  #------------------------------------------------------------------------------
  def clicked?
    @click += 1
    emit(:checked)
    if @click > 1
      @click = 0
      @check = 0
      emit(:unchecked)
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
      emit(:mouse_on_event)
    end
  end

  def dispose
  end
end
