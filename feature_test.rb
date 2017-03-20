require './lib/oystercard'
card = Oystercard.new
"Test top-up function"
card.top_up(50)
"Test limit of card"
card.top_up(50)

"New card with higher limit"
card2 = Oystercard.new(150)
card2.top_up(150)
"Checks limit of new card"
card2.top_up(150)
