require 'rly'
require 'rly/helpers'

class XCCParser < Rly::Yacc

  rule 'statements : statements EOL statement
                   | statements ";" statement
                   | statement' do |sts, st1, _, st2|
    sts.value = st2.nil? ? [st1.value] : st1.value + [st2.value]
  end

  rule 'statement : STRING "=" STRING
                  | STRING "=" QUOTED_STRING' do |st, name, _, value|
    st.value = "#{name.value} = #{value.value}"
  end

end