# frozen_string_literal: true

prob = {
  Jan: 31,
  Feb: 28,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  Aug: 31,
  Sept: 30,
  Oct: 31,
  Nov: 30,
  Dec: 31
}

prob_new = prob.select { |_months, days| days == 30 }

prob_new.each do |months, _days|
  puts months
end
