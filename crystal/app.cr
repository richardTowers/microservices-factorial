require "http/client"
require "http/server"

puts "starting"
server = HTTP::Server.new([
  HTTP::ErrorHandler.new,
  HTTP::LogHandler.new,
]) do |context|
  inp_str = context.request.path.split("/")
               .select { |x| x.size > 0 }.concat(["1"]).first

  begin
    inp = inp_str.to_i32
  rescue ArgumentError
    inp = 1
  end

  if inp <= 1
    puts HTTP::Client.get("http://base-factorial.apps.internal:8080").body.to_s
  else
    prec = HTTP::Client.get("http://factorial.apps.internal:8080/#{inp - 1}").body.to_s.to_i32
    context.response.print (inp * prec).to_s
  end

end

puts "binding to 8080"
server.bind_tcp 8080

puts "listening on 0.0.0.0/8080"
server.listen
