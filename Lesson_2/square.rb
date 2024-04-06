# frozen_string_literal: true

puts 'Введите основание треугольника.'
a = gets.to_f

if a.positive?
  puts 'Введите высоту треугольника'
  h = gets.to_f
else
  puts 'Неверное значение. Основание может быть только положительным числом.'
end

if h.positive?
  s = (1.0 / 2) * a * h
  puts "Площадь треугольника равна #{s}"
else
  puts 'Неверное значение. Высота может быть только положительным числом.'
end
