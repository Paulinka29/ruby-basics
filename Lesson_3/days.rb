# frozen_string_literal: true

def leap?(year)
  (year % 4).zero? && (year % 100 != 0) || (year % 400).zero?
end

puts 'Введите дату в формате dd.mm.yyyy'
d, m, y = gets.split('.').map(&:to_i)

h = {
  1 => 31,
  2 => 29,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

days = if leap?(y)
         h.values.first(m.to_i - 1).sum + d
       else
         h.merge(2 => 28).values.first(m.to_i - 1).sum + d
       end

p days
