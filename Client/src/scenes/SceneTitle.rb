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
    @user = TextBox.new(@center_x - 240, @center_y + 100, 300, 30,"", max_input:20,font_size:20)
    @pass = TextBox.new(@center_x - 240, @center_y + 150, 300, 30,"", max_input:20,font_size:20, pass:true)
    @btn = Button.new(@center_x - 150, @center_y + 260, 141, 32, "Loginho")
    @btn.on(:clicked) { SceneManager.call(Scene_Dois) }
    @btn.on(:clicked) { p"#{@user.text} - #{@pass.real_text}"}
    #@btn.on(:clicked) {SetMasterVolume(0.1)}
    #@btn.on(:clicked) {TakeScreenshot("print/Screenshot.png")}
    @check = CheckBox.new(@center_x - 240, @center_y + 200, "Lembrar?", check_size: 20, icon_color: BLACK)
    @check.on(:checked) { $draw_bunnies=true}
    @check.on(:unchecked) { $draw_bunnies=false}
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
  def update
    super
    UpdateMusicStream(@music)
    @btn.update
    @check.update
    @pass.update
    @user.update
  end
  #--------------------------------------------------------------------------
  # * Draw
  #--------------------------------------------------------------------------
  def draw
    super
    draw_background
    draw_game_title
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
  # * Dispose All Resources and Sounds
  #--------------------------------------------------------------------------
  def dispose
    super
    UnloadMusicStream(@music)
    @btn.dispose
    @check.dispose
    @pass.dispose
  end
end
