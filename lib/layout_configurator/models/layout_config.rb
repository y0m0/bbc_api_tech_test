class LayoutConfig

  include DataMapper::Resource

  property :id, String, key: true
  property :value, String
end
