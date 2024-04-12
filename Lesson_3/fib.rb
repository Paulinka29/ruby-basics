# frozen_string_literal: true

max = 100
fib = []
i1 = 0
i2 = 1

while i1 <= max
  fib << i1
  i1, i2 = i2, i1 + i2
end
print fib.to_s
