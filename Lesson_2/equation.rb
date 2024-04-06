# frozen_string_literal: true

puts 'Введите 3 коэффициента квадратного урвнения через запятую'

data = gets.gsub(/\s+/, '').split(',')
a, b, c = data.map(&:to_f)
d = b**2 - 4 * a * c

puts 'Корней нет!' if d.negative?

if d.zero?
  x1 = -b / (2 * a)
  puts "У квадратного уравнения единственный корень: #{x1}"
end

if d.positive?
  x1 = (-b + d**0.5) / (2 * a)
  x2 = (-b - d**0.5) / (2 * a)
  puts "Корни квадратного уравнения равны: #{x1.round(2)}, #{x2.round(2)}"
end
