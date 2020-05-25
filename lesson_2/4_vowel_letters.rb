abc = ('a'..'z').to_a
vowel = ['a', 'e', 'i', 'o', 'u', 'y']

vowels_hash = {}

abc.each_with_index { |letter, index| vowels_hash[letter] = index + 1  if vowel.include? letter}

puts vowels_hash