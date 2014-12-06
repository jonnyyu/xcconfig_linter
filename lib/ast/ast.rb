class XCConfigFile

end

class XCComment
  attr_accessor :comment
  def initialize(comment)
    @comment = comment
  end

  def ==(other)
    other.comment == @comment
  end
end

class XCInclude

end

class XCVariable
  attr_accessor :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def ==(other)
    other.name == @name and other.value == @value
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
    other.value == @value
  end

end

class XCStringList < XCValue
  attr_accessor :values

  def initialize(first_value=nil)
    @values = first_value.nil? ? [] : [first_value]
  end

  def insert_head(value)
    @values.insert(0, value)
  end

  def ==(other)
    other.values == @values
  end

end
