puts 'Как Вас зовут?'
name = gets.chomp.capitalize!

puts 'Какой у Вас рост? (Введите в сантиметрах)'
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15


if  ideal_weight < 0
  puts "#{name}, Ваш вес уже оптимален!"
 else
  puts "#{name}, Ваш идеальный вес #{ideal_weight} кг!"
end