require 'rly'
require 'rly/helpers'
require 'ast/ast'

class XCCParser < Rly::Yacc

  rule 'statements : statements EOL statement
                   | statements ";" statement
                   | statement' do |sts, st1, _, st2|
    sts.value = st2.nil? ? [st1.value] : st1.value + [st2.value]
  end

  rule 'statement : COMMENT
                  | STRING "=" value' do |st, p1, _, p3|
    if p1.type == :COMMENT
      st.value = XCComment.new(p1.value)
    else
      st.value = XCVariable.new(name=p1.value, value=p3.value)
    end
  end

  rule 'value : single_value
              | single_value value' do |v, v1, v2|
    if v2.nil?
      v.value = v1.value
    else
      string_list = v2.value
      if v2.value.is_a? XCString
        string_list = XCStringList.new v2.value
      end
      string_list.insert_head v1.value
      v.value = string_list
    end
  end

  rule 'single_value : STRING
                     | QUOTED_STRING' do |sv, s1|
      sv.value = XCString.new(s1.value)
  end

end