require '../../shared/input'

print_green('Starting')

CRATE_WIDTH = 3
SEPARATOR = ' '

# NOTE: here is no crate definition because it's coming for any other situation
crane_definition = [' 0 ', ' 1 ', ' 2 ', ' 3 ', ' 4 ', ' 5 ', ' 6 ', ' 7 ', ' 8 ', ' 9 ']
instr_definition = ['move', 'from', 'to']

crate_store = []
crane_store = []
instr_store = []

read_input().each do |line|

  is_empty_line = line.strip.size <= 0
  is_crane_def = crane_definition.any?{ |x|line.start_with?(x) }
  is_instr_def = instr_definition.any?{ |x|line.start_with?(x) }

  if is_empty_line
    # NOTE: do nothing, obviously
  elsif is_crane_def
    crane_store = line.split(SEPARATOR)
  elsif is_instr_def
    instr_store << line.split(SEPARATOR)
  else
    crate_store << line.split('').each_slice(CRATE_WIDTH + 1).to_a.map{ |x| x.pop(); x }
  end
end

stacks = Array.new(crane_store.size) {|_| [] }

crate_store.reverse.each do |x|
  x.each_with_index do |y, i|
    symbol = y[1]
    if symbol != " "
      stacks[i].push(symbol)
    end
  end
end

instr_store.each do |x|
  case x[0]
  when 'move'
    count = x[1].to_i
    from = crane_store.index(x[3])
    to = crane_store.index(x[5])
    count.times do
      stacks[to].push(stacks[from].pop())
    end
  end
end

print_green("Answer -> " + stacks.map(&:last).join(''))
