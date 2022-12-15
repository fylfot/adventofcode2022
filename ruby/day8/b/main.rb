require '../../shared/input'

print_green('Starting')

rows = []

read_input().each do |line|
  line = line.strip
  row = line.split('').map(&:to_i)
  row.prepend(nil)
  row.push(nil)
  rows.push(row)
end

rows.prepend([nil] * rows.first.size)
rows.push([nil] * rows.first.size)

def count_visiblity(rows, x, y, direction)

  dx = 0
  dy = 0
  case direction
  when 0
    dx = -1
  when 1
    dy = -1
  when 2
    dx = +1
  when 3
    dy = +1
  end

  max = rows[x][y]
  return 0 if max.nil?
  score = 0
  loop do
    x += dx
    y += dy
    row = rows[x]
    break if row.nil?
    height = row[y]
    break if height.nil?
    score += 1 
    print_green("#{height} vs #{max}")
    break if height >= max
    
  end

  score
  
end

max = 0
# i = 4
# j = 3

rows.size.times do |j|  
  rows.first.size.times do |i|
    sum = count_visiblity(rows, i, j, 0) * count_visiblity(rows, i, j, 1) * count_visiblity(rows, i, j, 2) * count_visiblity(rows, i, j, 3)
    puts(red("#{i}:#{j}") + yellow(" -> #{sum}"))
    if sum > max
      max = sum
    end
  end
end

print_green("Answer -> #{max}")