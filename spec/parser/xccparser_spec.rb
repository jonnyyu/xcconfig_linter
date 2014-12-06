require 'xcclinter'

describe XCCParser do
  context 'basic file structure' do
    it 'should parse one single key value' do
      pexpect('NAME=libacdb').to eq [XCVariable.new(name='NAME', value=XCString.new('libacdb'))]
    end

    it 'should parse two key values separate by semicolon or return' do
      expected = [
          XCVariable.new(name='NAME', value=XCString.new('libacdb')),
          XCVariable.new(name='CONFIG', value=XCString.new('Debug'))
      ]
      pexpect('NAME=libacdb;CONFIG=Debug').to eq expected
      pexpect('NAME=libacdb;CONFIG=Debug').to eq expected
    end

    it 'should parse comments' do
      pexpect('//this is a comment').to eq [XCComment.new('this is a comment')]
    end
  end

  context 'different type of values' do
    it 'should parse quoted value' do
      pexpect('NAME="some value"').to eq [XCVariable.new(name='NAME', value=XCString.new('some value'))]
    end

    it 'should parse multi values separate by space, even with quoted string' do
      values = XCStringList.new
      values.insert_head XCString.new('GBIN64 ')
      values.insert_head XCString.new('/System/Library')
      values.insert_head XCString.new('$(CBIN)')

      expected = [XCVariable.new(name='PATHS', value=values)]
      pexpect('PATHS=$(CBIN)   /System/Library "GBIN64 "').to eq expected
    end
  end

  def pexpect(str, debug=false)
    parser = XCCParser.new(XCCLex.new)
    expect(parser.parse(str, debug))
  end

end