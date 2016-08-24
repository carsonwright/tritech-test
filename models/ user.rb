class Users < Model
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :email
  attr_accessor :organization_id


  def to_json(generator=OpenStruct.new)
    {
      id: self.id,
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email
    }.to_json
  end

  def create_product(params)
    params[:user_id] = self.id
    Products.create(params)
  end

  def products
    Products.where(user_id: self.id)
  end
end