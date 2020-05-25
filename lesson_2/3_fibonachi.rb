array = [1, 1]

while array[-1] + array[-2] < 100 do
  array.push array[-1] + array[-2]
end

puts array