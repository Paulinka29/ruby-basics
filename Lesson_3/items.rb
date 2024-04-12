# frozen_string_literal: true

name = nil
h = {}

while name != 'cтоп'
  puts 'Введите название товара'

  name = gets.chomp

  break if name == 'стоп'

  puts 'Введите количество товара'
  amount = gets.to_f
  puts 'Введите цену товара'
  price = gets.to_f

  h[name] = { amount: amount, price: price }
end

p h
sum = 0
h.each do |key, value|
  puts "Название товара: #{key}. Сумма: #{value[:amount] * value[:price]}"
  sum += (value[:amount] * value[:price])
end
puts "Общая сумма в вашей корзине = #{sum}"
