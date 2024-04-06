# frozen_string_literal: true

puts 'Введите 3 стороны треугольника через запятую'

data = gets.gsub(/\s+/, '').split(',')
a, b, c = data.sort.map(&:to_f)

if (a <= 0) || (b <= 0) || (c <= 0)
  puts 'Неправильное значение. Длина может быть только положительной.'
elsif c >= a + b
  puts 'Треугольник не существует'
elsif (a == b) && (b == c)
  puts 'Треугольник равносторонний'
elsif (a == b) || (b == c) || (c == a)
  puts 'Треугольник равнобедренный'
elsif c**2 == a**2 + b**2
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник разносторонний'
end