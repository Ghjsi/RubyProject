module Manufacturer
  attr_writer :manufacturer

  def manufacturer
    puts "Произведено компанией \"#{@manufacturer}\""
  end
end
