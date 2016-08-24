class Products < Model
  attr_accessor :name
  attr_accessor :user_id
  attr_accessor :category

  def to_json(generator=OpenStruct.new)
    {
      id: self.id,
      name: self.name,
      user_id: self.user_id,
      category: self.category
    }.to_json
  end
end