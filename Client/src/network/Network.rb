class Network
  def initialize
    @socket = TCPSocket.new("127.0.0.1", 5000)
    @socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
  end

  def update
    io = IO.select([@socket], nil, nil, 0)
    unless io.nil?
      p io
    end
  end

  def send_message(message)
    @socket.send(message, 0)
  end

  def stop
    @socket.close
  end
end
