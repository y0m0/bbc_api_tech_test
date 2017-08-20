class LayoutConfig

  include DataMapper::Resource

  property :id, String, key: true
  property :value, String

  validates_presence_of :value
  validates_with_method :id, method: :valid_id?

  def id=(id)
    super id.downcase
  end

  def valid_id?
    return true if /^[a-z-]+(-\d+)?$/.match?(@id)
    [false, 'Invalid Id format']
  end
end
