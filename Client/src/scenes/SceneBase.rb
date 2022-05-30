class Scene_Base
  #--------------------------------------------------------------------------
  # * Processamento principal
  #--------------------------------------------------------------------------
  def initialize
    @network = Network.new
    start
  end

  #--------------------------------------------------------------------------
  # * Inicialização do processo
  #--------------------------------------------------------------------------
  def start
    @frames_counter = 0
    @center_x = GetScreenWidth() / 2
    @center_y = GetScreenHeight() / 2
    @network.send_message("Scene: #{self.class}")
  end

  #--------------------------------------------------------------------------
  # * Atualização da tela
  #--------------------------------------------------------------------------
  def update
    @frames_counter += 1
    draw
    SceneManager.exit if IsKeyPressed(KEY_ESCAPE)
    @network.update
  end

  def draw
  end

  #--------------------------------------------------------------------------
  # * Finalização do processo
  #--------------------------------------------------------------------------
  def dispose
    @network.stop
  end

  #--------------------------------------------------------------------------
  # * Chamada de retorno de cena
  #--------------------------------------------------------------------------
  def return_scene
    SceneManager.return
  end
end
