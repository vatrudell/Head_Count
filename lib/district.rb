class District
  def initialize(input)
    @input = input
  end

  def name
    @input.values.pop.upcase
  end
end
