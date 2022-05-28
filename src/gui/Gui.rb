#------------------------------------------------------------------------------
# * Master class for GUI
#------------------------------------------------------------------------------
class Gui < Emitter
  #------------------------------------------------------------------------------
  # * Initial
  #------------------------------------------------------------------------------
  def initialize(*args)
    super()
    @mouse_pos = Vector2.create(0, 0)
    @fx_button = OE.sound("decision")
    @btn_state = 0
    @btn_action = false
    @font = GetFontDefault()
    @check = 0
    @click = 0
    @active = false
    @in_area = false
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
    update_status
    draw
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
  def in_area?(btn_bounds)
    @in_area = CheckCollisionPointRec(@mouse_pos, @btn_bounds)
    if @in_area
      @btn_state = 1
    else
      @btn_state = 0
    end
  end
  #------------------------------------------------------------------------------
  # * Check if Mouse Clicked
  #------------------------------------------------------------------------------
  def mouse_click
    return IsMouseButtonPressed(MOUSE_BUTTON_LEFT)
  end
  #------------------------------------------------------------------------------
  # * Update Status
  #------------------------------------------------------------------------------
  def update_status
    clicked?
    checked?
    active?
  end
  #------------------------------------------------------------------------------
  # * Clicked in area GUI
  #------------------------------------------------------------------------------
  def clicked?
    if @in_area && mouse_click
      play_click_sound
      @btn_state = 2
      emit(:clicked)
    end
  end
  #------------------------------------------------------------------------------
  # * Checked / Unchecked
  #------------------------------------------------------------------------------
  def checked?
    if @in_area && mouse_click
      @click += 1
      if @click > 1
        @click = @check = 0
        emit(:unchecked)
      else
        @check = 1
        emit(:checked)
      end
    end
  end
  #------------------------------------------------------------------------------
  # * Active / Inactive
  #------------------------------------------------------------------------------
  def active?
    if @in_area && mouse_click
      @active = true
      emit(:active)
    end
    if !@in_area && mouse_click
      @active = false
      emit(:inactive)
    end
  end

  def dispose
  end
end
