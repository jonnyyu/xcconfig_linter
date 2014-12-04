require 'rly'
require 'rly/helpers'

class XCCLex < Rly::Lex
  ignore ' \t'

  literals '=,;'

  token :INCLUDE, '#include'

  token :EOL, /\n+/ do |t|
    t
  end

  token :QUOTED_STRING, /"[^"]*"/ do |t|
    t.value = t.value[1...-1]
    t
  end

  token :COMMENT, /\/\/.*$/
  token :STRING, /[^ =,;\n]+/

  on_error do
    puts "Illegal character #{t.value}"
  end

end