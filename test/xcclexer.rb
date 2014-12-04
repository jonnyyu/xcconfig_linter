require '../lib/lex/xcclex'

lex = XCCLex.new(File.readlines(ARGV[0]).join())

while true
  tok = lex.next
  break if tok.nil?

  puts tok.type.to_s
  puts tok.value

end

