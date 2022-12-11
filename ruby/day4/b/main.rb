require '../../shared/input'

print_green('Starting')
pairs = 0
read_input().each do |pair|
  small, large = pair.strip.split(',').map do |x|
    from, to = x.split('-').map(&:to_i)
    (from..to).to_a
  end.sort_by(&:size)
  
  intersection_size = large.intersection(small).size
  print_green("#{small} ∩ #{large} -> #{intersection_size}")
  pairs += 1 if intersection_size > 0
end
print_yellow("Pairs count: #{pairs}")