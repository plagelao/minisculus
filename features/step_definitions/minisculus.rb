require 'MarkDevices'

Given /^the message "([^"]*)"$/ do |message|
  @plain_message = message
end

When /^we set the first wheel position to (\d+)$/ do |position|
  @first_wheel_position =  position.to_i
end

When /^we set the second wheel position to (\d+)$/ do |position|
  @second_wheel_position = position.to_i
end

When /^we use the Mark I device$/ do
  @encoded_message = MarkI.encode(@plain_message, @first_wheel_position)
end

When /^we use the Mark II device$/ do
  @encoded_message = MarkII.encode(@plain_message, @first_wheel_position, @second_wheel_position)
end

When /^we use the Mark IV device$/ do
  @encoded_message = MarkIV.encode(@plain_message, @first_wheel_position, @second_wheel_position)
end

Then /^the encoded message must be "([^"]*)"$/ do |expected_encoded_message|
   raise @encoded_message unless expected_encoded_message == @encoded_message
end

Given /^the encoded message "([^"]*)"$/ do |encoded_message|
  @encoded_message = encoded_message
end

When /^we decoded it with the Mark IV device$/ do
  @decoded_message = MarkIV.decode(@encoded_message, @first_wheel_position, @second_wheel_position)
end

Then /^the original message is "([^"]*)"$/ do |original_message|
  raise @decoded_message unless original_message == @decoded_message
end


