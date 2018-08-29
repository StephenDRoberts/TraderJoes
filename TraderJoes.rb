require_relative "funcs"

system "clear"
foods  = {
"Tomatoes" => 20,
 "Apples" => 40,
 "Pears" => 10,
}




options = ["Show prices", "Buy some product","Sell some products","Move locations","Show inventory"]

locations = ["Manhatten", "Brooklyn","Queens"]

#set starting conditions
currentLocation = "Manhatten"
currentBalance = {"value" => 100}
myProducts = {
"Tomatoes" => 0,
 "Apples" => 0,
 "Pears" => 0,
}

myBasketSpace = {"Total" => 50}

day = 1
dayLimit = 10

msgs = {"intro" => false,
	"std" => false,
	"lastDayShown" => false}

msg = "Welcome to #{currentLocation}! It's day #{day}\n\nWhat would you like to do today?\n"

loop do
	#checkLastDay(day, currentBalance, msgs)

	if checkLastDay(day, dayLimit, currentBalance, msgs)
		break
	end
	#asks user what they would liek to do today (buy/sell/move)
	if msgs["std"] == false
		puts "#{msg}\n"
		#resets prices if not seen before
	end

	if msgs["intro"] == false
		foods["Tomatoes"] = (1..40).to_a.sample #avg = 20
		foods["Apples"] = (20..60).to_a.sample #avg = 40
		foods["Pears"] = (1..15).to_a.sample #avg = 84
	end

	options.each_with_index{ |val, index| 
		puts "#{index+1}. #{val}"
	}

	input = gets.strip.to_i

	case input

	when 1 #show prices
	system "clear"
	1.times do
		puts "Today's prices are:\n"
		foodsArray = foods.to_a

		foodsArray.each_with_index{ |val, index| 
			puts "#{index+1}. #{val[0]} : #{val[1]}\n"
		}

		puts "\nWhat would you like to do?\n"


	 	msgs["intro"] = true
	 	msgs["std"] = true
 	end

	when 2 #buy loop
	system "clear"
	puts "\nWhat would you like to buy?\n\n"
	foodsArray = foods.to_a

	foodsArray.each_with_index{ |val, index| 
		puts "#{index+1}. #{val[0]} : #{val[1]}"
	}

	#gets input from the client
	product = gets.strip.to_i

	#switches product number to type
	case product
		when 1
			product = "Tomatoes"
		when 2
			product = "Apples"
		when 3
			product = "Pears"
		when 9
			system "clear"
			break
		else
			puts "Please enter a valid product number"
			product = gets.strip.to_i
		end

	remaining = []
	remaining.push(currentBalance["value"]/foods[product])
	remaining.push(myBasketSpace["Total"])
	remaining = remaining.min
	puts "How many units? Your available balance is $#{currentBalance["value"]} and you have #{myBasketSpace["Total"]} spaces remaining\nYou can buy #{remaining} units"
	amount = gets.strip.to_i

		1.times do
			if checkCanBuyAmount(product, amount, currentBalance, foods, myBasketSpace)
				msg =  "Here are your available options again:\n"
				break
			else
			buyProducts(product, amount, currentBalance, foods, myProducts, myBasketSpace)
			msgs["std"] = false
			msgs["intro"] = true
			msg = "What next?\n"
			system = "clear"
			end
		end

	when 3 # selling items loop
	system "clear"	
	puts "What would you like to sell?\n"
	myProductsArray = myProducts.to_a

	myProducts.each_with_index{ |val, index| 
		puts "#{index+1}. #{val[0]} : #{val[1]}"
	}

	#gets input from the client
	product = gets.strip.to_i

	#switches product number to type
	case product
		when 1
			product = "Tomatoes"
		when 2
			product = "Apples"
		when 3
			product = "Pears"
		when 9
			system "clear"
			break
		else
			puts "Please enter a valid product number"
			product = gets.strip.to_i
		end


	puts "How many units?"
	amount = gets.strip.to_i

		1.times do
			if checkCanSellAmount(product, amount, myProducts)
				msg =  "Here are your available options again:\n"
				break
			else
			sellProducts(product, amount, currentBalance, foods, myProducts, myBasketSpace)
			msg = "What next?\n"
			msgs["intro"] = true
			system = "clear"
			end
		end

	when 4 #move locations and update day
		system "clear"
		puts "Where would you like to move to?"

		locations.each_with_index{ |val, index| 
		puts "#{index+1}. #{val}"
		}

		newLocation = gets.strip.to_i
		
		currentLocation = locations[newLocation-1]
		day +=1
		system "clear"
		msgs["std"] = false
		msgs["intro"] = false
		msg = "Welcome to #{currentLocation}! It's day #{day}\nWhat would you like to do today?"
	
	when 5 #show your inventory and give options again
		system "clear"
		puts myProducts
		puts "Your current balance is $#{currentBalance["value"]}"
		puts "\nWhat would you like to do?\n"
		msgs["std"] = true
		msgs["intro"] = true
	when 9
		system "clear"
		break
	else
		puts "Invalid"
	end

	#loops through size of foods to output names and prices

end

