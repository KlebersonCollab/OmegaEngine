require 'socket'
require_relative 'src/Emitter'
require_relative 'src/UID'

class Listener < Emitter
  def initialize(ip='0.0.0.0',port,max_players: 1)
    @listener = Socket.new(2,1,6)
    @listener.bind(Addrinfo.tcp(ip, port))
    @clients = Array.new(max_players)
    @uid = UID.new
  end

  def can_accept
    !IO.select([@listener], nil, nil, 0).nil?
  end

  def accept
    @id = @uid.next
    @clients[@id] = @listener.accept[0]
  end

  def start
    @listener.listen(1)
  end

  def update
    accept if can_accept
    socket = @clients.select{ |c| !c.nil?}
    io = IO.select(socket, nil, socket, 0)
    unless io.nil?
      io[0].each do |client|
        buff = client.recv(1024)
        puts buff
        if buff.size == 0
          id = @clients.index(client)
          puts "Client #{id} disconnected"
          @clients[id] = nil
          @uid.free(id)
        end
      end
    end
  end

  def stop
    @listener.close
  end
end


$listener = Listener.new(5000, max_players: 100)
$listener.start
$listener.update while true
$listener.stop

