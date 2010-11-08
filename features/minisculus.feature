Feature: Win the war
  In order to know the german plans
  As an english codebreaker
  I want to break the german codes

  Scenario: Virtual Mark I device
	Given the message "Strong NE Winds!"
	When we set the first wheel position to 6
	And we use the Mark I device
  Then the encoded message must be "Yzxutm5TK5cotjy2"

  Scenario: Virtual Mark II device
  Given the message "abc"
  When we set the first wheel position to 2
  And we set the second wheel position to 5
  And we use the Mark II device
  Then the encoded message must be "STU"

  Scenario: Virtual Mark IV device
  Given the message "111"
  When we set the first wheel position to 0
  And we set the second wheel position to 0
  And we use the Mark IV device
  Then the encoded message must be "133"

  Scenario: Decoder device
  Given the encoded message "133"
  When we set the first wheel position to 0
  And we set the second wheel position to 0
  And we decoded it with the Mark IV device
  Then the original message is "111"
