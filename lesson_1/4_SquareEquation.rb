puts 'Введите коэффициент а'
a = gets.chomp.to_i

puts 'Введите коэффициент b'
b = gets.chomp.to_i
 
puts 'Введите коэффициент с'
c = gets.chomp.to_i

d = b**2 - 4 * a * c

if d > 0
	x1 = (-b + Math.sqrt(d))/2.0 * a 
	x2 = (-b - Math.sqrt(d))/2.0 * a
	puts "D = #{d}, x1 = #{x1}, x2 = #{x2}."

elsif d == 0
	x1 = -b/2.0 * a
  	puts "D = #{d}, x1 = #{x1}."

else 
	puts "D = #{d}. Корней нет."
end