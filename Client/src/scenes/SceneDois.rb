class Scene_Dois < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    SceneManager.clear
    init_music
    create_background
  end
  #--------------------------------------------------------------------------
  # * Load Background Texture
  #--------------------------------------------------------------------------
  def create_background
    @texture = []
    @title_screen = OE.title("asian-girl-fantasy-artwork-4k-j3-1920x1080")
    @texture << @title_screen
    @layout = [
      Rectangle.create(0, 0, @title_screen[:width], @title_screen[:height]),
      Rectangle.create(0, 0, GetScreenWidth(), GetScreenHeight()),
    ]
    @btn = Button.new(@center_x - 140, GetScreenHeight() - 230, 141, 123 / 3, "Login")
    @btn.on(:clicked) { SceneManager.goto(Scene_Title) }
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
  def update
    super
    UpdateMusicStream(@music)
    @btn.update
  end
  #--------------------------------------------------------------------------
  # * Draw
  #--------------------------------------------------------------------------
  def draw
    super
    draw_background
  end
  #--------------------------------------------------------------------------
  # * Draw Background
  #--------------------------------------------------------------------------
  def draw_background
    DrawTexturePro(@title_screen, @layout[0], @layout[1], Vector2.create(0, 0), 0.0, WHITE)
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
