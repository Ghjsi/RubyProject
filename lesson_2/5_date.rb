puts 'Укажите число дату'
date = gets.chomp.to_i

puts 'Укажите месяц числом'
month = gets.chomp.to_i

puts 'Укажите год'
year = gets.chomp.to_i 

days_in_month  = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 4 == 0
  days_in_month[1] = 29
end

num_of_day = days_in_month.take(month - 1).sum + date

puts "Порядковый номер указанной даты: #{num_of_day}"
