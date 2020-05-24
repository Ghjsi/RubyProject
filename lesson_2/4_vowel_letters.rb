
alphabet = [] # массив для вложения подмассивов вида [буква, порядковый номер]

n = 1 # порядковый номер для буквы

for letter in 'a'..'z'  
  alphabet << [letter.to_sym, n] # формируем вложеннЫЕ массивы с конвертированием букв в символы
  n += 1
end

alphabet.to_h

vowel = ['a', 'e', 'i', 'o', 'u', 'y']
vowels_from_alphabet = {}

index = 0

alphabet.select do |letter, num| 
  for vowel_letter in vowel
    if letter.to_s == vowel[index]
      vowels_from_alphabet[letter] = num
      index += 1
    end
  end
end

puts vowels_from_alphabet
