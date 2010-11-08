require 'rubygems'
require 'net/http'
require 'json'
require 'MarkDevices'

def get_question_from(location)
  @answer_location = location
  url = 'http://minisculus.edendevelopment.co.uk/'
  response = Net::HTTP.get_response(URI.parse(url + location))
  case response
    when Net::HTTPSuccess     then response.body
    when Net::HTTPRedirection then 
      @answer_location = response['location']
      return get_question_from(@answer_location)
    
    else response.error!
  end
end

def put_answer(answer)
  url = 'http://minisculus.edendevelopment.co.uk' + @answer_location
  uri = URI.parse url
  request = Net::HTTP::Put.new(url, header = {"Content-Type" => "application/json"})
  request.body = JSON.generate 'answer' => answer
  response = Net::HTTP.new(uri.host, uri.port).start {|http|
    http.request(request)
  }
  raise "We have lost the war :(" if response.class == Net::HTTPNotAcceptable
  get_question_from(response['location'])
end

def resolve_first(challenge) 
  encoded_message = MarkI.encode(challenge['question'], 6)
  JSON.parse(put_answer(encoded_message))
end

def resolve_second(challenge)
  encoded_message = MarkII.encode(challenge['question'], 9, 3)
  JSON.parse(put_answer(encoded_message))
end

def resolve_third(challenge)
  encoded_message = MarkIV.encode(challenge['question'], 4, 7)
  JSON.parse(put_answer(encoded_message))
end

def resolve_fourth(challenge)
  decoded_message = MarkIV.decode(challenge['question'], 7, 2)
  JSON.parse(put_answer(decoded_message))
end

def resolve_final(challenge)
  10.times do |i|
    10.times do |j|
      decoded_message = MarkIV.decode(challenge['code'],i,j)
      if decoded_message.include?'FURLIN' and decoded_message.include?'BUNKER'
        return decoded_message
      end
    end
  end
end

challenge = JSON.parse(get_question_from('start'))
challenge = resolve_first(challenge)
challenge = resolve_second(challenge)
challenge = resolve_third(challenge)
challenge = resolve_fourth(challenge)
challenge = resolve_final(challenge)
puts challenge
