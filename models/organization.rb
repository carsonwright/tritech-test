class Organizations < Model
  attr_accessor :name
  attr_accessor :private_key
  attr_accessor :public_key

  def self.create(params)
    params[:private_key] = SecureRandom.base64(21)
    params[:public_key] = SecureRandom.base64(21)
    super(params)
  end

  def to_json(generator=OpenStruct.new)
    {
      id: self.id,
      name: self.name,
      public_key: self.public_key,
      private_key: self.private_key
    }.to_json
  end

  def self.authenticate!(id, private_key)
    self.find_by({id: id, private_key: private_key})
  end
end