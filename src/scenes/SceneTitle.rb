class Scene_Title < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    SceneManager.clear
    @centerX = GetScreenWidth() / 2
    @centerY = GetScreenHeight() / 2
    init_music
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
    @btn = Button.new(0, 0, 20, 20, "", OE.gui("Button"), 3)
    @btn.on(:clickbutton) { SceneManager.goto(Scene_Dois) }
  end

  #--------------------------------------------------------------------------
  # * Load Scene Music
  #--------------------------------------------------------------------------
  def init_music
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
    DrawText("Omega Engine", @centerX - 60, 0, 20, LIGHTGRAY)
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
