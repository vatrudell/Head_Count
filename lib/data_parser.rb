class DataParser
  def parser(input)
    file = input[:enrollment][:kindergarten]  #thats probably hardcoded in there

    @data = CSV.open(file, headers: true, header_converters: :symbol)
    input.each do ||

  end
end



{enrollment => {kinderguarden => file, high_school => file }}
