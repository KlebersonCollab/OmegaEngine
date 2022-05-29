class Scene_Base
  #--------------------------------------------------------------------------
  # * Processamento principal
  #--------------------------------------------------------------------------
  def initialize
    start
    @socket = TCPSocket.new('127.0.0.1',5000)
    @socket.send("Hello", 0)
    @socket.close
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
  # * Atualização da tela
  #--------------------------------------------------------------------------
  def update
    @frames_counter += 1
    draw
    SceneManager.exit if IsKeyPressed(KEY_ESCAPE)
  end

  def draw
    #while message = @socket.gets
      #puts message.chomp
    #end
  end
  #--------------------------------------------------------------------------
  # * Finalização do processo
  #--------------------------------------------------------------------------
  def dispose
    @socket.close
  end
  #--------------------------------------------------------------------------
  # * Chamada de retorno de cena
  #--------------------------------------------------------------------------
  def return_scene
    SceneManager.return
  end
end
