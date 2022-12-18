require '../../shared/input'

print_green('Starting')

head = [0, 0]
tail = [0, 0]

tail_history = []

def sign(val)
  if val >= 0
    return +1
  else
    return -1
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
  
  repeats.to_i.times do
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

    head[0] = head[0] + dx
    head[1] = head[1] + dy

    if (head[0] == tail[0]) && (head[1] == tail[1])
      # Do nothing
      print_green("Covered #{tail}--#{head}")
    elsif (head[0] == tail[0]) || (head[1] == tail[1])
      if (head[0] - tail[0]).abs + (head[1] - tail[1]).abs >= 2
        tail[0] = tail[0] + dx
        tail[1] = tail[1] + dy
      end
      print_yellow("Axis-aligned #{tail}--#{head}")
    else
      ddx = head[0] - tail[0]
      ddy = head[1] - tail[1]
      if ddx.abs + ddy.abs >= 3
        tail[0] = tail[0] + sign(ddx)
        tail[1] = tail[1] + sign(ddy)
      end
      print_red("Diagonal #{tail}--#{head}")
    end

    tail_history.push(tail.clone)
  end
end

print_green("Answer -> #{tail_history.uniq.count}")