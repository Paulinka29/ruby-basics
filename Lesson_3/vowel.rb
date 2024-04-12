# frozen_string_literal: true

h = {}
letters = ('a'..'z').to_a
v = %w[a e i o u]
i = 0
while i < letters.length
  h[letters[i]] = i + 1 if v.include? letters[i]
  i += 1
end

p h
