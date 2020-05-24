

purchase = {}

loop do
puts 'Введите название товара (Для выхода из корзины введите stop)'
good = gets.chomp.to_s
break if good == "stop"

puts 'Введите цену за единицу товара'
price = gets.chomp.to_f

puts 'Введите количество товара'
amount = gets.chomp.to_f

cost = price * amount
purchase[good] = { price: price, amount: amount }
end

total_cost = 0

purchase.each do |k, v|
  cost = purchase[k][:price] * purchase[k][:amount]
  total_cost += cost
  puts "Товар #{k}. Стоимость товара #{cost}(Цена = #{purchase[k][:price]}, Количество = #{purchase[k][:amount]}.)"
end

puts "Итоговая сумма: #{total_cost}"