class LayoutConfig

  include DataMapper::Resource

  property :id, String, key: true
  property :value, String

  validates_presence_of :value
  validates_primitive_type_of :value
end
