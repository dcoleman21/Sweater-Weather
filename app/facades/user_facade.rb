class UserFacade
  def self.auth_key(key)
    User.find_by(api_key: key)
  end

  def self.auth(user_info)
    user = User.find_by(email: user_info[:email])
    return user if user && user.authenticate(user_info[:password])
  end

  def self.create(user_info)
    key = SecureRandom.hex
    User.create(user_info.merge(api_key: key))
  end
end
