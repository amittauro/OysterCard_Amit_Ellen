In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

objects | messages

constant fare = 3
deduct

In order to get through the barriers
As a customer
I need to touch in and out

object | messages
card | touch_out ()


In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

objects | messages
card
(const: min amount (3))



In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

objects | messages
card | touch_out

In order to pay for my journey
As a customer
I need to know where I've travelled from

objects | messages
card | touched_in_at


In order to know where I have been
As a customer
I want to see to all my previous trips

objects | messages
card | journey_history


In order to know how far I have travelled
As a customer
I want to know what zone a station is in

objects | messages
station | zone


In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

objects | messages
card | touch_in, touch_out 


In order to be charged the correct amount
As a customer
I need to have the correct fare calculated

objects | messages
card | touch_out {calculate a fare}
