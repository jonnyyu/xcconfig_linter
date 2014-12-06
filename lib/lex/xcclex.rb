require 'rly'
require 'rly/helpers'

class XCCLex < Rly::Lex
  ignore ' \t'

  literals '=,;'

  token :INCLUDE, '#include'

  token :EOL, /\n+/

  token :QUOTED_STRING, /"[^"]*"/ do |t|
    t.value = t.value[1...-1]
    t
  end

  token :COMMENT, /\/\/.*$/ do |t|
    t.value = t.value[2..-1]
    t
  end
  token :STRING, /[^ =,;\n]+/

  on_error do
    puts "Illegal character #{t.value}"
  end

end