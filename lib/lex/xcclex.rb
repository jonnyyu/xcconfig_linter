require 'rly'

class XCCLex < Rly::Lex
  ignore ' \t'

  token :INCLUDE, '#include'

  token :QUOTED_STRING, /"[^"]*"/ do |t|
    t.value = t.value[1...-1]
    t
  end

  token :STRING, /[^ ]+/


end