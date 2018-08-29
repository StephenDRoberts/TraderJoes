def checkCanBuyAmount(product, amount, balance, foods, myBasketSpace)
		puts "\n"
	if foods[product]*amount>balance["value"]
		puts "I'm sorry, you don't have enough money, you have $#{balance["value"]} remaining"
		puts "Please choose a different amount or another option"
		return true
	elsif amount>myBasketSpace["Total"]
		puts "I'm sorry, you don't have enough space in your basket"
		puts "You have #{myBasketSpace["Total"]} spaces left"
		puts "Please choose fewer items"
		return true
	elsif amount ==0
		system "clear"
		puts "You didn't buy anything"
		return true
	else
		return false	
	end
end

def buyProducts(product, amount, balance, foods, myProducts, myBasketSpace)
	totalPrice = foods[product] * amount
 	

	balance["value"] = balance["value"] - totalPrice
	myProducts[product] += amount
	myBasketSpace["Total"] -= amount
	system "clear"
	puts "You bought some #{product}\n"
	puts "Your remaining balance is $#{balance["value"]}\n"
	puts "Your current inventory is #{myProducts}"
	
end

def checkCanSellAmount(product, amount, myFoods)
	
		puts "\n"
	if amount ==0
		system "clear"
		puts "You didn't sell anything"
		return true

	elsif myFoods[product]<amount
		puts "I'm sorry, you don't have enough product to sell, you have $#{myFoods} to sell"
		puts "Please choose a different amount or product"
		return true

	else
		return false	
	end
end

def sellProducts(product, amount, balance, foods, myProducts, myBasketSpace)
	totalSale = foods[product] * amount
 	

	balance["value"] = balance["value"] + totalSale
	myProducts[product] -= amount
	myBasketSpace["Total"] += amount
	system "clear"
	puts "You sold some #{product}\n"
	puts "Your remaining balance is $#{balance["value"]}\n"
	puts "Your current inventory is #{myProducts}"
end

def checkLastDay(day, dayLimit, balance, msgs)
	if day === dayLimit
		if msgs["lastDayShown"] == false
			puts "THIS IS YOUR LAST DAY!!!\n\n"
			msgs["lastDayShown"] = true
		end
		return false
	elsif day>dayLimit
		
		puts "Time's up. Final score: $#{balance["value"]}"
		return true
	else
		return false
	end
end
