require 'xcclinter'

describe XCCParser do
  context 'basic file structure' do
    it 'should parse one single key value' do
      expected = XCConfigFile.new
      expected.add XCVariable.new(name='NAME', value=XCString.new('libacdb'))
      pexpect('NAME=libacdb').to eq expected
    end

    it 'should parse two key values separate by semicolon or return' do
      expected = XCConfigFile.new
      expected.add XCVariable.new(name='NAME', value=XCString.new('libacdb'))
      expected.add XCVariable.new(name='CONFIG', value=XCString.new('Debug'))

      pexpect('NAME=libacdb;CONFIG=Debug').to eq expected
      pexpect("NAME=libacdb\nCONFIG=Debug").to eq expected
    end

    it 'should parse comments' do
      expected = XCConfigFile.new
      expected.add XCComment.new('this is a comment')
      pexpect('//this is a comment').to eq expected
    end

    it 'should parse includes' do
      expected = XCConfigFile.new
      expected.add XCInclude.new('aconfig.xcconfig')
      expected.add XCInclude.new('bconfig.xcconfig')
      pexpect(%q{
        #include "aconfig.xcconfig"
        #include "bconfig.xcconfig"
      }).to eq expected
    end

    it 'should parse mini structure' do
      text= %q{
        // This is a comment
        #include "someconfig.xcconfig"
        MY_VAR = $(MY_VAR) value "some other value"}

      expected = XCConfigFile.new
      expected.add XCComment.new(' This is a comment')
      expected.add XCInclude.new('someconfig.xcconfig')
      values = XCStringList.new(XCString.new('$(MY_VAR)'))
      values.add XCString.new('value')
      values.add XCString.new('some other value')
      expected.add XCVariable.new(name='MY_VAR', value=values)

      pexpect(text).to eq expected
    end

  end

  context 'different type of values' do
    it 'should parse quoted value' do
      expected = XCConfigFile.new
      expected.add XCVariable.new(name='NAME', value=XCString.new('some value'))
      pexpect('NAME="some value"').to eq expected
    end

    it 'should parse multi values separate by space, even with quoted string' do
      values = XCStringList.new
      values.insert_ahead XCString.new('GBIN64 ')
      values.insert_ahead XCString.new('/System/Library')
      values.insert_ahead XCString.new('$(CBIN)')

      expected = XCConfigFile.new
      expected.add XCVariable.new(name='PATHS', value=values)
      pexpect('PATHS=$(CBIN)   /System/Library "GBIN64 "').to eq expected
    end
  end

  def pexpect(str, debug=false)
    parser = XCCParser.new(XCCLex.new)
    expect(parser.parse(str, debug))
  end
end