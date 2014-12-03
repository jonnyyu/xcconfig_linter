require 'xcclinter'

describe XCCLex do
  context 'Basic lexer' do
    it 'should lex simple key = value' do

      lex = XCCLex.new('PRODUCT_NAME = libAcDb')

      tok = lex.next
      expect(tok.type).to eql :STRING
      expect(tok.value).to eql 'PRODUCT_NAME'

      tok = lex.next
      expect(tok.value).to eql '='

      tok = lex.next
      expect(tok.type).to eql :STRING
      expect(tok.value).to eql 'libAcDb'

      expect(lex.next).to be_nil
    end

    it 'should lex quoted value' do
      lex = XCCLex.new('"some file path"')

      tok = lex.next
      expect(tok.type).to eql :QUOTED_STRING
      expect(tok.value).to eql 'some file path'
      expect(lex.next).to be_nil
    end

    it 'should accept value with $()' do
      lex = XCCLex.new('$(CBIN_OBJ)')

      tok = lex.next
      expect(tok.type).to be :STRING
      expect(tok.value).to eql '$(CBIN_OBJ)'
      expect(lex.next).to be_nil
    end

    it 'should accept value with ${}' do
      lex = XCCLex.new('${CBIN64}')

      tok = lex.next
      expect(tok.type).to be :STRING
      expect(tok.value).to eql '${CBIN64}'
      expect(lex.next).to be_nil
    end

    it 'should support #include ' do
      lex = XCCLex.new('#include "somefile"')

      tok = lex.next
      expect(tok.type).to be :INCLUDE
      expect(tok.value).to eql '#include'

      tok = lex.next
      expect(tok.type).to be :QUOTED_STRING
      expect(tok.value).to eql 'somefile'

      expect(lex.next).to be_nil
    end
  end

  context 'Complex scenario' do

  end
end