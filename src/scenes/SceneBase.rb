class Scene_Base
  #--------------------------------------------------------------------------
  # * Processamento principal
  #--------------------------------------------------------------------------
  def main
    start
    update until scene_changing?
    terminate
  end

  #--------------------------------------------------------------------------
  # * Inicialização do processo
  #--------------------------------------------------------------------------
  def start
    @frames_counter = 0
    @center_x = GetScreenWidth() / 2
    @center_y = GetScreenHeight() / 2
  end

  #--------------------------------------------------------------------------
  # * Definição de mudança de cenas
  #--------------------------------------------------------------------------
  def scene_changing?
    SceneManager.scene != self
  end

  #--------------------------------------------------------------------------
  # * Atualização da tela
  #--------------------------------------------------------------------------
  def update
    BeginDrawing()
    ClearBackground(BLACK)
    update_basic
    EndDrawing()
    SceneManager.exit if IsKeyPressed(KEY_ESCAPE)
  end

  #--------------------------------------------------------------------------
  # * Atualização da tela (básico)
  #--------------------------------------------------------------------------
  def update_basic
    @frames_counter += 1
  end

  def terminate
  end

  #--------------------------------------------------------------------------
  # * Finalização do processo
  #--------------------------------------------------------------------------
  def dispose
  end

  #--------------------------------------------------------------------------
  # * Chamada de retorno de cena
  #--------------------------------------------------------------------------
  def return_scene
    SceneManager.return
  end
end
