class District
  attr_reader :name,
              :dr
  def initialize(name, dr = nil)
    @name =  name[:name]
    @dr = dr
  end

  def enrollment
    @dr.enrollment(@name)
  end
end
