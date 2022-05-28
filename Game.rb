require_relative 'util/setup_dll'
require_relative 'src/modules/OE'

require_relative "src/scenes/SceneManager"
require_relative "src/scenes/SceneBase"
require_relative "src/scenes/SceneTitle"
require_relative "src/scenes/SceneDois"

require_relative "src/gui/Emitter"
require_relative "src/gui/Gui"
require_relative "src/gui/Button"
require_relative "src/gui/CheckBox"


MAX_BATCH_ELEMENTS = 8192
MAX_BUNNIES = 10000#50000
Bunny = Struct.new(:position, :speed, :color, keyword_init: true)

class Game

  def initialize(screenWidth, screenHeight)
    @screenWidth = screenWidth
    @screenHeight = screenHeight
    create_window
    set_bunnies
    SceneManager.run
  end
  #Create Window
  def create_window
    InitWindow(@screenWidth, @screenHeight, "Ruby-raylib bindings - bunnymark")
    SetTargetFPS(60)
    InitAudioDevice()
    SetWindowMonitor(1)
  end
  #Set bunnies
  def set_bunnies
    # Load bunny texture
    @texBunny = OE.system("wabbit_alpha")
    @bunnies = []
  end
  #Check mouse pressed
  def check_mouse_pressed
    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      # Create more bunnies
      100.times do
        if @bunnies.length < MAX_BUNNIES
          @bunnies << Bunny.new(position: GetMousePosition(), speed: Vector2.create(GetRandomValue(-250, 250)/60.0, GetRandomValue(-250, 250)/60.0), color: Color.from_u8(GetRandomValue(50, 240), GetRandomValue(80, 240), GetRandomValue(100, 240), 255))
        end
      end
    end
  end
  #Update bunnies
  def update_bunnies
    # Update bunnies
    @bunnies.each do |bunny|
      bunny.position[:x] += bunny.speed[:x]
      bunny.position[:y] += bunny.speed[:y]

      if ((bunny.position[:x] + @texBunny[:width]/2) > GetScreenWidth()) || ((bunny.position[:x] + @texBunny[:width]/2) < 0)
        bunny.speed[:x] *= -1
      end

      if ((bunny.position[:y] + @texBunny[:height]/2) > GetScreenHeight()) || ((bunny.position[:y] + @texBunny[:height]/2 - 40) < 0)
        bunny.speed[:y] *= -1
      end
    end
  end
  #Draw bunnies
  def draw_bunnies
    @bunnies.each do |bunny|
      DrawTexture(@texBunny, bunny.position[:x], bunny.position[:y], bunny.color)
    end
  end
  #Draw info
  def draw_info_benchmark
    DrawRectangle(0, 0, @screenWidth, 40, BLACK)
    DrawText(TextFormat("bunnies: %i", :int, @bunnies.length), 120, 10, 20, GREEN)
    DrawText(TextFormat("batched draw calls: %i", :int, 1 + @bunnies.length/MAX_BATCH_ELEMENTS), 320, 10, 20, MAROON)

    DrawText("Scene Actual:#{SceneManager.scene}",GetScreenWidth()/2, 10, 20, MAROON)

    DrawFPS(10, 10)
  end
  #Game Loop
  def update
    until WindowShouldClose()
      check_mouse_pressed
      update_bunnies
      SceneManager.update
      BeginDrawing()
        ClearBackground(BLACK)
        draw_bunnies
        draw_info_benchmark
      EndDrawing()
    end
  end
  #Dispose
  def dispose
    UnloadTexture(@texBunny)
    @bunnies = []
    SceneManager.exit
    CloseAudioDevice()
    CloseWindow()
  end

end

@Game = Game.new(1920, 1080)
@Game.update
@Game.dispose
