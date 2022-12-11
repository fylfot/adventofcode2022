require '../../shared/input'

print_green('Starting')

SPACE_TOTAL = 70000000
SPACE_NEEDS = 30000000

dirs = {}
cursor = [dirs]

read_input().each do |line|
  line = line.strip
  if line.start_with? '$ '
    print_green(line)
    if line.start_with? '$ cd '
      if line.start_with? '$ cd ..'
        cursor.pop()
      else
        current_dir = cursor.last
        dir_name = line.split('$ cd ').last
        current_dir[dir_name] = current_dir[dir_name] || { '@kind' => :folder }
        cursor.push(current_dir[dir_name])
      end
    elsif line.start_with? '$ ls'
      # NOTE: just ignore this
    end
  elsif line.start_with? 'dir'
    print_red(line)
    # NOTE: just ignore this
  else
    print_yellow(line)
    size, item_name = line.split(' ')
    current_dir = cursor.last
    current_dir[item_name.to_sym] = { '@size' => size.to_i, '@kind' => :object }
  end
end

def print_dir(dir, tabulation)
  prefix = ' ' * (tabulation)
  sorted_keys = dir.keys.filter{|y|!y.start_with?('@')}.sort_by{|y| "#{dir[y]['@kind']}-#{y}" }

  sorted_keys.each do |k|
    o = dir[k]
    if o['@kind'] == :folder
      print_yellow("#{prefix}└📁 #{k}")
      print_dir(o, tabulation + 1)
    else
      symbol = (sorted_keys.last == k) ? '└' : '├'
      print_green("#{prefix}#{symbol}📄 #{k} (#{o['@size']})")
    end
  end
end

def filter_dirs(name, dir, maxsize, fit_sizes)
  filtered_keys = dir.keys.filter{|y|!y.start_with?('@')}

  size = 0
  filtered_keys.each do |k|
    o = dir[k]
    if o['@kind'] == :folder
      size += filter_dirs(k, o, maxsize, fit_sizes)
    else
      size += o['@size']
    end
  end

  if size >= maxsize
    print_yellow("filtered folder - #{name} (#{size})")
    fit_sizes.push(size)
  end
  size
end

print_green("Hierarchy: ")
print_dir(dirs['/'], 0)

sizes = []
size_taken = filter_dirs('/', dirs['/'], 0, [])
print_red("size_taken -> #{size_taken}")
filter_dirs('/', dirs['/'], SPACE_NEEDS - (SPACE_TOTAL - size_taken), sizes)
print_green("Answer -> #{sizes.min}")
