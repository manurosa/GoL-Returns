class User
  @@guest_num_overall

  def initialize(socket)
    @socket = socket
    socket.user = self
    @guest_num = guest_num_generator
    @name = 'Guest ' + @guest_num
    generate_id
    # @ips = WTF
    # @current_ip = is this necessary?
    @bacteria_prototype = { owner: self }
    default_proto
  end

  def guest_num_generator
    @@guest_num_overall += 1
  end

  def default_proto
    # TODO: Implement me
  end

  def generate_id
    text = '' + @name
    @id = text.downcase.replace(/[^a-z0-9]+/, '')
  end
end
