require '../../shared/input'

print_green('Starting')

rx_queue = []

read_input().each do |line|
  line = line.strip

  if line.start_with? 'noop'
    rx_queue.push(nil)
  elsif line.start_with? 'addx '
    av = line['addx '.size..-1].to_i
    rx_queue.push(nil)
    rx_queue.push(av)
  else
    throw 'WTF?'
  end

end

rx = 1
cycle = 0
rx_queue.each do |acc|

  if cycle == (rx - 1) || cycle == (rx) || cycle == (rx + 1)
    print ["🟥", "🟧", "🟨", "🟩", "🟦", "🟪", "🟫"].sample
  else
    print "⬛️"
  end
  
  unless acc.nil?
    # print_green("##{cycle} rx: #{rx}")
    rx += acc
    # print_yellow("##{cycle} rx: #{rx}")
  end

  cycle += 1
  if cycle % 40 == 0
    print "\n"
    cycle -= 40
  end
end

# print_green("\nAnswer -> #{signal_sum}")
