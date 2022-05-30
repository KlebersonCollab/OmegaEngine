require "socket"
require_relative "Emitter"
require_relative "UID"

class Listener < Emitter
  attr_accessor :disconnect
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(ip, port, max_players)
    super()
    @listener = Socket.new(2, 1, 6)
    @listener.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
    @listener.bind(Addrinfo.tcp(ip, port))
    @clients = Array.new(max_players)
    @queues = 5
    @uid = UID.new
    @hash = {}
    @thread = []
  end

  #--------------------------------------------------------------------------
  # * Management queues
  #--------------------------------------------------------------------------
  def start
    @listener.listen(@queues)
  end

  #--------------------------------------------------------------------------
  # * Check if client can accept
  #--------------------------------------------------------------------------
  def can_accept
    !IO.select([@listener], nil, nil, 0).nil?
  end

  #--------------------------------------------------------------------------
  # * Accept client
  #--------------------------------------------------------------------------
  def accept
    socket = @listener.accept[0]
    id = @uid.next
    @clients[id] = socket
    @clients[id].setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
    puts "Client #{id} connected"
    @hash[socket] = id
    emit(:client_connected, id)
  end

  #--------------------------------------------------------------------------
  # * Send message to client
  #--------------------------------------------------------------------------
  def send(id, message)
    @clients[id].send(message, 0)
  end

  #--------------------------------------------------------------------------
  # * Send message to all clients
  #--------------------------------------------------------------------------
  def send_to_all(message)
    @clients.each do |client|
      client.send(message, 0)
    end
  end

  #--------------------------------------------------------------------------
  # * Kick a client
  #--------------------------------------------------------------------------
  def kick_client(id)
    @clients[id].close
    @clients[id] = nil
    @hash.delete(id)
    @uid.free(id)
    puts "Client #{id} Kicked"
    emit(:client_kicked, id)
  end

  #--------------------------------------------------------------------------
  # * Update
  #--------------------------------------------------------------------------
  def update
    accept if can_accept
    socket = @clients.select { |c| !c.nil? }
    io = IO.select(socket, nil, socket, 0)
    unless io.nil?
      receive_message(io)
    end
  end

  #--------------------------------------------------------------------------
  # * receive_message for client
  #--------------------------------------------------------------------------
  def receive_message(io)
    io[0].each do |client|
      id = @hash[client]
      buff = client.recv(1024)
      puts buff
      emit(:message_received, buff, id)
      client_disconnected?(id, buff, client)
    end
  end

  #--------------------------------------------------------------------------
  # * Check if client disconnected
  #--------------------------------------------------------------------------
  def client_disconnected?(id, buff, client)
    if buff.size == 0
      puts "Client #{id} disconnected"
      @clients[id] = nil
      @hash.delete(client)
      @uid.free(id)
      emit(:client_disconnected, id)
    end
  end

  #--------------------------------------------------------------------------
  # * Stop Service
  #--------------------------------------------------------------------------
  def stop
    @listener.close
    emit(:listener_closed)
  end
end
