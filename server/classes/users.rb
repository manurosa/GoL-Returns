require_relative 'user'

class Users
  def initialize
    @users_list = {}
  end

  def has?(id)
    @users_list.key?(id)
  end

  def get_user(id)
    @users_list.fetch(id)
  end

  def set(id, user)
    @users_list[id] = user
  end

  def add(socket)
    user = User.new(socket)
    users_list[id] = user
  end

  def remove(id)
    user = @users_list.get_user(id)
    @users_list.delete(id) if user
  end
end
