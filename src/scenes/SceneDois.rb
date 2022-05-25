class Scene_Dois < Scene_Base
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
    @texture = []
    @title_screen = OE.title("1024083")
    @texture << @title_screen
    @layout = [
      Rectangle.create(0, 0, @title_screen[:width], @title_screen[:height]),
      Rectangle.create(0, 0, GetScreenWidth(), GetScreenHeight()),
    ]
    @btn = Button.new(@centerX - 140, GetScreenHeight() - 230, 141, 123 / 3, "   Login  ", OE.gui("Button"), 3)
    @btn.on(:click_button) { SceneManager.goto(Scene_Title) }
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
