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

signal_sum = 0
rx = 1
cycle = 0
rx_queue.each do |acc|
  cycle += 1
  if (cycle + 20) % 40 == 0
    signal_sum += rx * cycle
    print_red("##{cycle} rx: #{rx * cycle}")
  end
  unless acc.nil?
    # print_green("##{cycle} rx: #{rx}")
    rx += acc
    # print_yellow("##{cycle} rx: #{rx}")
  end
end

print_green("Answer -> #{signal_sum}")
