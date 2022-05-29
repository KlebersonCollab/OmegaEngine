require 'socket'
require_relative 'Emitter'
require_relative 'UID'

class Listener < Emitter
  #--------------------------------------------------------------------------
  # * Initialize
  #--------------------------------------------------------------------------
  def initialize(ip,port,max_players)
    super()
    @listener = Socket.new(2,1,6)
    @listener.setsockopt(Socket::IPPROTO_TCP,Socket::TCP_NODELAY,1)
    @listener.bind(Addrinfo.tcp(ip, port))
    @clients = Array.new(max_players)
    @queues = 5
    @uid = UID.new
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
    id = @uid.next
    @clients[id] = @listener.accept[0]
    @clients[id].setsockopt(Socket::IPPROTO_TCP,Socket::TCP_NODELAY,1)
    puts "Client #{id} connected"
    emit(:client_connected, id)
  end
  #--------------------------------------------------------------------------
  # * Update
  #--------------------------------------------------------------------------
  def update
    accept if can_accept
    socket = @clients.select{ |c| !c.nil?}
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
      buff = client.recv(1024)
      emit(:message_received, buff, client)
      client_disconnected?(io,buff, client)
    end
  end
  #--------------------------------------------------------------------------
  # * Check if client disconnected
  #--------------------------------------------------------------------------
  def client_disconnected?(io,buff,client)
    if buff.size == 0
      id = @clients.index(client)
      puts "Client #{id} disconnected"
      @clients[id] = nil
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
