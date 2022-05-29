class UID
  def initialize
    @available_indices = []
    @highest_index = -1
  end

  def next
    return @available_indices.pop if @available_indices.size > 0
    @highest_index += 1
    return @highest_index
  end

  def free(id)
    @available_indices << id
  end
end
=begin
uid = UID.new
puts(uid.next)
puts(uid.next)
uid.free(0)
puts(uid.next)
puts(uid.next)
=end
