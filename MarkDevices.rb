module Keyboard

  KEYBOARD = [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    ".", ",", "?", "!", "'", "\"", " "
  ]

  def Keyboard.index_of(key)
    KEYBOARD.find_index(key)
  end
  def Keyboard.key_from(index)
    KEYBOARD[index%KEYBOARD.length]
  end
end

module FirstWheel
  def FirstWheel.encode(character, wheel_position)
    Keyboard.key_from(Keyboard.index_of(character) + wheel_position)
  end
end
module SecondWheel
  def SecondWheel.encode(character, wheel_position)
    Keyboard.key_from(Keyboard.index_of(character) - 2*wheel_position)
  end
end
module ThirdWheel
  def ThirdWheel.encode(character, wheel_position)
    Keyboard.key_from(Keyboard.index_of(character) + 2*wheel_position)
  end
end

module MarkI
  def MarkI.encode(message, wheel_position)
    encoded_message = ''
    message.each_char{|s|
      encoded_char = FirstWheel.encode(s, wheel_position)
      encoded_message += encoded_char
    }
    encoded_message
  end
end

module MarkII
  def MarkII.encode(message, first_wheel_position, second_wheel_position)
    encoded_message = ''
    message.each_char{|s|
      encoded_char = FirstWheel.encode(s, first_wheel_position)
      encoded_char = SecondWheel.encode(encoded_char, second_wheel_position)
      encoded_message += encoded_char
    }
    encoded_message
  end
end

module MarkIV
  def MarkIV.encode(message, first_wheel_position, second_wheel_position)
    previous_position = 0
    encoded_message = ''
    message.each_char {|s|
      encoded_char = FirstWheel.encode(s, first_wheel_position)
      encoded_char = SecondWheel.encode(encoded_char, second_wheel_position)
      encoded_char = ThirdWheel.encode(encoded_char, previous_position)
      previous_position = Keyboard.index_of(s)
      encoded_message += encoded_char
    }
    encoded_message
  end
  def MarkIV.decode(message, first_wheel_position, second_wheel_position)
    decoded_message = ''
    decoded_char_index = 0
    message.each_char {|encoded_character|
      decoded_char_index = Keyboard.index_of(encoded_character) - 2*decoded_char_index + 2*second_wheel_position - first_wheel_position
      previous_position = decoded_char_index 
      decoded_message += Keyboard.key_from(decoded_char_index)
    } 
    decoded_message
  end
end
