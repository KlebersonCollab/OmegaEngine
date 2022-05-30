require_relative "src/Listener"

class GameServer
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(ip = "0.0.0.0", port, max_players: 1)
    @listener = Listener.new(ip, port, max_players)
  end

  #--------------------------------------------------------------------------
  # * start listening
  #--------------------------------------------------------------------------
  def start
    @listener.start
  end

  #--------------------------------------------------------------------------
  # * Update
  #--------------------------------------------------------------------------
  def update
    @listener.update while true
  end

  def kick(id)
    @listener.kick_client(id)
  end

  #--------------------------------------------------------------------------
  # * Stop Service
  #--------------------------------------------------------------------------
  def stop
    @listener.stop
  end
end

$server = GameServer.new(5000, max_players: 100)
$server.start
$server.update
