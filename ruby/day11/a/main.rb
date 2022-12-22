require '../../shared/input'

print_green('Starting')

class Monkey
  attr_accessor :name
  attr_accessor :items
  attr_accessor :effect
  attr_accessor :redirect_div
  attr_accessor :redirect_if_true
  attr_accessor :redirect_if_false
  attr_accessor :inspects_count

  def give_a_shit!(monkeys)
    loop do
      return if self.items.size == 0
      self.inspects_count += 1

      old = self.items.shift()
      new_val = 0
      eval(self.effect)
      new_val /= 3
      if (new_val % redirect_div) == 0
        monkeys[self.redirect_if_true].items << new_val
      else
        monkeys[self.redirect_if_false].items << new_val
      end

    end
  end
end

monkeys = []

read_input().each do |line|
  line = line.strip

  if line.start_with? 'Monkey '
    monkey = Monkey.new
    monkey.name = line.split('Monkey ').last.split(':').first
    monkey.inspects_count = 0
    monkeys << monkey
    
  elsif line.start_with? 'Starting items: '
    monkey = monkeys.last
    monkey.items = line.split('Starting items: ').last.split(',').map(&:to_i)

  elsif line.start_with? 'Operation: '
    monkey = monkeys.last
    monkey.effect = line.split('Operation: ').last.gsub('new', 'new_val')

  elsif line.start_with? 'Test: divisible by '
    monkey = monkeys.last
    monkey.redirect_div = line.split('Test: divisible by ').last.to_i

  elsif line.start_with? 'If true: throw to monkey '
    monkey = monkeys.last
    monkey.redirect_if_true = line.split('If true: throw to monkey ').last.to_i

  elsif line.start_with? 'If false: throw to monkey '
    monkey = monkeys.last
    monkey.redirect_if_false = line.split('If false: throw to monkey ').last.to_i
  
  elsif line == ''
    # Do nothing
    
  else
    throw 'WTF?'
  end
end

monkeys.each do |m|
  print_yellow("Monkey #{m.name} -> #{m.items}")
end

20.times do |round|
  monkeys.each do |m|
    m.give_a_shit!(monkeys)
  end
end

monkey_business = []
monkeys.each do |m|
  print_green("Monkey #{m.name} -> #{m.items} (#{m.inspects_count})")
  monkey_business << m.inspects_count
end

answer = monkey_business.sort.reverse[0..1].inject(:*)

print_green("Answer -> #{answer}")
