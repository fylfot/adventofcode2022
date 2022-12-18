require '../../shared/input'

print_green('Starting')

knots = Array.new(10) {|i| [0, 0] }

tail_history = []

def sign(val)
  if val >= 0
    return +1
  else
    return -1
  end
end

def draw(records, mode = :history)
  minx = records.map{|e|e[0]}.min
  miny = records.map{|e|e[1]}.min
  maxx = records.map{|e|e[0]}.max
  maxy = records.map{|e|e[1]}.max

  c = (maxx - minx) + 2
  l = (maxy - miny) + 2

  (-2..l).to_a.reverse.each do |y|
    (-2..c).to_a.each do |x|
      ax = x + minx
      ay = y + miny
      if mode == :history
        if records.include?([ax, ay])
          if ax == 0 && ay == 0
            print "🟩"
          else
            print "🟥"
          end
        else
          print "⬛️"
        end
      elsif mode == :rope
        idx = records.index([ax, ay])
        if idx
          if ax == 0 && ay == 0
            print "🟩"
          else
            print ["🧠", "1️⃣ ", "2️⃣ ", "3️⃣ ", "4️⃣ ", "5️⃣ ", "6️⃣ ", "7️⃣ ", "8️⃣ ", "9️⃣ "][idx]
          end
        else
          print "⬛️"
        end
      end
      
    end
    print "\n"
  end
end

# NOTE: orientation
# y
# ^
# |
# ----> x
# 
read_input().each do |line|
  line = line.strip
  command, repeats = line.split(' ')
  # print_green("Line #{line}")
  
  repeats.to_i.times do
    # print_green("Round")
    dx = 0
    dy = 0
    case command
    when 'U'
      dy = +1
    when 'R'
      dx = +1
    when 'D'
      dy = -1
    when 'L'
      dx = -1
    end

    head = knots[0]

    head[0] = head[0] + dx
    head[1] = head[1] + dy

    (1..knots.size - 1).each do |offset|
      head = knots[offset - 1]
      tail = knots[offset]

      if (head[0] == tail[0]) && (head[1] == tail[1])
        # Do nothing
        # print_green("Covered #{tail}--#{head}")
      elsif (head[0] == tail[0]) || (head[1] == tail[1])
        
        if (head[0] - tail[0]).abs > 1
          tail[0] = tail[0] + sign(head[0] - tail[0])
        end

        if (head[1] - tail[1]).abs > 1
          tail[1] = tail[1] + sign(head[1] - tail[1])
        end
        # print_yellow("Axis-aligned #{tail}--#{head}")
      else
        ddx = head[0] - tail[0]
        ddy = head[1] - tail[1]
        if ddx.abs + ddy.abs >= 3
          tail[0] = tail[0] + sign(ddx)
          tail[1] = tail[1] + sign(ddy)
        end
        # print_red("Diagonal #{tail}--#{head}")
      end

    end
    # draw(knots, :rope)
    tail_history.push(knots.last.clone)
  end
  # draw(knots, :rope)
end

draw(tail_history.uniq, :history)

print_green("Answer -> #{tail_history.uniq.count}")