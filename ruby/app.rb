require 'http'
require 'sinatra'

get '/:input' do
  inp = params[:input].to_i(10)

  if inp <= 1
    HTTP.get('http://base-factorial.apps.internal:8080').body.to_s
  else
    prec = HTTP
      .get("http://factorial.apps.internal:8080/#{inp - 1}")
      .body
      .to_s
      .to_i(10)
    (inp * prec).to_s
  end
end
