puts 'Введите длину основания (a) треугольника'
a = gets.chomp.to_i

puts 'Введите длину высоты (h) треугольника'
h = gets.chomp.to_i

s = 1.0/2 * a * h

puts "Площадь треугольника составляет #{s}."