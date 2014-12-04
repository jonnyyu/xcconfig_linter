require 'xcclinter'

describe XCCParser do
  context 'basic file structure' do
    it 'should parse one single key value' do
      pexpect('NAME=libacdb').to eql ['NAME = libacdb']
    end

    it 'should parse two key values separate by semicolon' do
      pexpect('NAME=libacdb;CONFIG=Debug').to eql ['NAME = libacdb', 'CONFIG = Debug']
    end

    it 'should parse two key values separate by return' do
      pexpect('NAME=libacdb
               CONFIG=Debug').to eql ['NAME = libacdb', 'CONFIG = Debug']
    end

    it 'should parse comments' do
      pexpect('//this is a comment').to eql ['this is a comment']
    end
  end

  context 'different type of values' do
    it 'should parse quoted value' do
      pexpect('NAME="some value"').to eql ['NAME = some value']
    end
  end

  def pexpect(str)
    parser = XCCParser.new(XCCLex.new)
    expect(parser.parse(str))
  end

end