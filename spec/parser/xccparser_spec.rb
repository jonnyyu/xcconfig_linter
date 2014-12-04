require 'xcclinter'

describe XCCParser do
  context 'single key value' do
    it 'should parse one single key value' do
      expect(p('NAME=libacdb')).to eql ['NAME = libacdb']
    end

    it 'should parse two key values separate by semicolon' do
      expect(p('NAME=libacdb;CONFIG=Debug')).to eql ['NAME = libacdb', 'CONFIG = Debug']
    end

    it 'should parse two key values separate by return' do
      expect(p('NAME=libacdb
                CONFIG=Debug')).to eql ['NAME = libacdb', 'CONFIG = Debug']
    end

    it 'should parse quoted value' do
      expect(p('NAME="some value"')).to eql ['NAME = some value']
    end


    def p(str)
      parser = XCCParser.new(XCCLex.new)
      parser.parse(str)
    end
  end

end