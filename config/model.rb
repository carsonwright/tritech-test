class Model
  @@conn = PG.connect(dbname: ENV["DB_NAME"])
  def self.execute(sql)
    @@conn.exec(sql)
  end
  attr_accessor :id
  attr_accessor :created_at
  attr_accessor :updated_at

  def initialize(params)
    params.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.where(params)
    (execute where_sql(params)).to_a.collect { |item| self.new(item)}
  end

  def self.find_by(params)
    self.new (execute find_by_sql(params)).to_a[0]
  end

  def self.find(id)
    self.new (execute find_by_sql(id: id)).to_a[0]
  end

  def self.all
    execute(select_sql).to_a.collect { |item| self.new(item) }
  end

  def self.create(params)
    id = SecureRandom.uuid
    keys = params.keys.join(", ")
    values = params.values.collect do |v| 
      if v.class.name == 1.class.name
        v
      else
        "'#{v}'"
      end
    end.join(", ")
    sql = "
      INSERT INTO #{self.name.downcase} 
        (id, #{keys}, created_at, updated_at) 
        VALUES 
        ('#{id}', #{values}, now(), now())
      RETURNING *
    "
    self.new(execute(sql).to_a[0])
  end

  def self.last
    self.new(execute(select_sql + order_by({created_at: :DESC}) + limit_sql).to_a[0])
  end

  class << self
    private
    def where_sql(params)
      sql = "SELECT * FROM #{self.name.downcase} WHERE "
      sql += params.collect do |key, value|
        if value.class.name == "Integer" 
          "#{key} = #{value}"
        else
          "#{key} = '#{value}'"
        end
      end.join(" AND ")
    end

    def find_by_sql(params)
      [where_sql(params), " LIMIT 1"].join("")
    end

    def select_sql
      "SELECT * FROM #{self.name.downcase}"
    end

    def limit_sql
      " LIMIT 1"
    end

    def order_by(option)
      " ORDER BY #{option.keys.first} #{option.values.first}"
    end
  end
end
