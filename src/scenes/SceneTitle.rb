class Scene_Title < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    SceneManager.clear
    load_music
    create_background
  end

  #--------------------------------------------------------------------------
  # * Load Background Texture
  #--------------------------------------------------------------------------
  def create_background
    @title_screen = OE.title("1024083")
    @layout = [
      Rectangle.create(0, 0, @title_screen[:width], @title_screen[:height]),
      Rectangle.create(0, 0, GetScreenWidth(), GetScreenHeight()),
    ]
    @btn = Button.new(@center_x - 140, GetScreenHeight() - 230, 141, 123 / 3, " Loginho ", OE.gui("Button"), 3, 20)
    @btn.on(:click_button) { SceneManager.goto(Scene_Dois) }
    @btn.on(:mouse_on) { self }
  end

  #--------------------------------------------------------------------------
  # * Load Scene Music
  #--------------------------------------------------------------------------
  def load_music
    @music = OE.music("Fantasy Medieval Music - Song of the North")
    PlayMusicStream(@music)
  end

  #--------------------------------------------------------------------------
  # * Update Basic
  #--------------------------------------------------------------------------
  def update_basic
    super
    draw_background
    draw_game_title
    UpdateMusicStream(@music)
    @btn.update
  end

  #--------------------------------------------------------------------------
  # * Draw Background
  #--------------------------------------------------------------------------
  def draw_background
    DrawTexturePro(@title_screen, @layout[0], @layout[1], Vector2.create(0, 0), 0.0, WHITE)
  end

  #--------------------------------------------------------------------------
  # * Draw Game Title
  #--------------------------------------------------------------------------
  def draw_game_title
    DrawText(TextSubtext("Omega Engine", 0, @frames_counter / 15), @center_x - 260, 60, 80, RAYWHITE)
  end

  #--------------------------------------------------------------------------
  # * Execute terminate process
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose
  end

  #--------------------------------------------------------------------------
  # * Dispose All Resources and Sounds
  #--------------------------------------------------------------------------
  def dispose
    super
    UnloadMusicStream(@music)
    @btn.dispose
  end
end
