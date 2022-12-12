require '../../shared/input'

print_green('Starting')

rows = []

read_input().each do |line|
  line = line.strip
  rows.push(line.split('').map(&:to_i))
end

def traverse(rows, direction)

  print_yellow("Direction #{['↘️', '↙️', '↗️', '↖️'][direction]}")

  rc = rows.size - 1
  cc = rows.first.size - 1
  ranges = [
    [(0..rc).to_a, (0..cc).to_a],
    [(0..rc).to_a.reverse, (0..cc).to_a],
    [(0..rc).to_a, (0..cc).to_a.reverse],
    [(0..rc).to_a.reverse, (0..cc).to_a.reverse],
  ]
  ir, jr = ranges[direction]

  accum = []
  ir.each do |i|
    max = -1
    jr.each do |j|
      height = rows[i][j]
      print_yellow("#{i}:#{j} #{height} vs (#{max})")
      if height > max
        max = height
        if i > 0 && j > 0 && i < rc && j < cc
          accum.push("#{i}|#{j}")   
          print_red("🌳 #{i}|#{j} - #{height}")
        end
      end
    end
  end
  accum
end

visible = (traverse(rows, 0) + traverse(rows, 1) + traverse(rows, 2) + traverse(rows, 3)).uniq
edges_visible = (rows.size * 2) + (rows.first.size * 2) - 4

print_green("Interior -> #{visible.size}")
print_green("Edges -> #{edges_visible}")
print_green("Answer -> #{visible.size + edges_visible}")