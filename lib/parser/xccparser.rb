require 'rly'
require 'rly/helpers'
require 'ast/ast'

class XCCParser < Rly::Yacc

  rule 'statements : statement_with_eol
                   | statement_with_eol statements' do |sts, st1, st3|
    if st3.nil?
      sts.value = XCConfigFile.new
      if st1.value != :EOL
        sts.value.add st1.value
      end
    else
      sts.value = st3.value
      if st1.value != :EOL
        sts.value.insert_ahead(st1.value)
      end
    end
  end

  rule 'statement_with_eol : EOL
                           | statement
                           | statement EOL' do |swe, s1, _|
    if s1.type == :EOL
      swe.value = :EOL
    else
      swe.value = s1.value
    end

  end

  rule 'statement : COMMENT
                  | INCLUDE QUOTED_STRING
                  | STRING "=" value
                  | STRING "=" value ";"' do |st, p1, p2, p3, _|
    if p1.type == :COMMENT
      st.value = XCComment.new(p1.value)
    elsif p1.type == :INCLUDE
      st.value = XCInclude.new(p2.value)
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
      string_list.insert_ahead v1.value
      v.value = string_list
    end
  end

  rule 'single_value : STRING
                     | QUOTED_STRING' do |sv, s1|
      sv.value = XCString.new(s1.value)
  end

end