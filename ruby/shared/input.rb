
def read_input()
  File.readlines('./input.txt')
end

def print_red(msg)
  puts red(msg)
end

def print_green(msg)
  puts green(msg)
end

def print_yellow(msg)
  puts yellow(msg)
end

def red(msg)
  "\x1b[37;41;1m#{msg}\x1b[0m"
end

def green(msg)
  "\x1b[32;1m#{msg}\x1b[0m"
end

def yellow(msg)
  "\x1b[33;1m#{msg}\x1b[0m"
end

def test()
  throw "read input failured" unless read_input().size == 5

  print_red("red");
  print_green("green");
  print_yellow("yellow");
end