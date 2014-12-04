require 'rly'
require 'rly/helpers'

class XCCLex < Rly::Lex
  ignore ' \t'

  literals ',;'

  token :INCLUDE, '#include'

  token :QUOTED_STRING, /"[^"]*"/ do |t|
    t.value = t.value[1...-1]
    t
  end

  token :COMMENT, /\/\/.*$/
  token :STRING, /[^ ,;]+/

end