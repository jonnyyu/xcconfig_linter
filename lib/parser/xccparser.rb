require 'rly'
require 'rly/helpers'

class XCCParser < Rly::Yacc

  rule 'statements : statements EOL statement
                   | statements ";" statement
                   | statement' do |sts, st1, _, st2|
    sts.value = st2.nil? ? [st1.value] : st1.value + [st2.value]
  end

  rule 'statement : STRING "=" STRING
                  | STRING "=" QUOTED_STRING
                  | COMMENT' do |st, p1, _, p3|
    if p1.type == :COMMENT
      st.value = p1.value
    else
      st.value = "#{p1.value} = #{p3.value}"
    end

  end

end