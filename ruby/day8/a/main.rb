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

def traverse(rows, direction)

  print_yellow("Direction #{['↘️', '↙️', '↗️', '↖️'][direction]}")

  rc = rows.size - 1
  cc = rows.first.size - 1
  ranges = [
    [false, (0..rc).to_a, (0..cc).to_a],
    [true, (0..rc).to_a, (0..cc).to_a],
    [false, (0..rc).to_a, (0..cc).to_a.reverse],
    [true, (0..rc).to_a, (0..cc).to_a.reverse],
  ]
  rev, ir, jr = ranges[direction]

  accum = []

  if rev
    ir.each do |j|
      max = -1
      jr.each do |i|
        height = rows[i][j] || -1
        # print_yellow("#{i}:#{j} #{height} vs (#{max})")
        if height > max
          max = height
          accum.push("#{i}|#{j}")
          # print_red("🌳 #{i}|#{j} - #{height}")
        end
      end
    end
  else
    ir.each do |i|
      max = -1
      jr.each do |j|
        height = rows[i][j] || -1
        # print_yellow("#{i}:#{j} #{height} vs (#{max})")
        if height > max
          max = height
          accum.push("#{i}|#{j}")
          # print_red("🌳 #{i}|#{j} - #{height}")
        end
      end
    end
  end

  accum
end

def print_map(rows, visible)
  i = 0
  rows.each do |r|
    line = []
    j = 0
    r.each do |x|
      if visible.include?("#{i}|#{j}")
        line.push(red(x))
      else
        line.push(x)
      end
      j += 1
    end
    puts line.join('')
    i += 1
  end
end

t0 = traverse(rows, 0)
t1 = traverse(rows, 1)
t2 = traverse(rows, 2)
t3 = traverse(rows, 3)

print_map(rows, t0)
print_map(rows, t1)
print_map(rows, t2)
print_map(rows, t3)

visible = (t0 + t1 + t2 + t3).uniq

print_green("Answer -> #{visible.size}")