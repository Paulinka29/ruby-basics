# frozen_string_literal: true

puts 'Укажите ваше имя'
name = gets.capitalize.chomp

puts "#{name}, укажите ваш рост."
height = gets.to_f
weight = ((height - 110) * 1.15).round(2)

if weight.positive?
  puts "#{name}, ваш идеальный вес - #{weight} кг :)"
else puts 'Ваш вес уже оптимальный.'
end
