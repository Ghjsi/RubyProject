array = [1, 1]

index = 1

while  array[index] + array[index - 1] < 100 do
  array[index + 1] = array[index] + array[index - 1]
  index += 1
end

puts array