class XCConfigFile
  attr_accessor :elements

  def initialize
    @elements = []
  end

  def add(element)
    @elements << element
  end

  def insert_ahead(element)
    @elements.insert(0, element)
  end

  def ==(other)
    other.is_a? XCConfigFile and other.elements == @elements
  end
end

class XCComment
  attr_accessor :comment
  def initialize(comment)
    @comment = comment
  end

  def ==(other)
    other.is_a? XCComment and other.comment == @comment
  end
end

class XCInclude
  attr_accessor :file
  def initialize(file=nil)
    @file = file
  end

  def ==(other)
    other.is_a? XCInclude and other.file == @file
  end
end

class XCVariable
  attr_accessor :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ==(other)
    other.is_a? XCVariable and other.name == @name and other.value == @value
  end
end

class XCValue

end

class XCString < XCValue
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def ==(other)
    other.is_a? XCString and other.value == @value
  end

end

class XCStringList < XCValue
  attr_accessor :values

  def initialize(first_value=nil)
    @values = first_value.nil? ? [] : [first_value]
  end

  def insert_ahead(value)
    @values.insert(0, value)
  end

  def add(value)
    @values << value
  end

  def ==(other)
    other.is_a? XCStringList and other.values == @values
  end

end
