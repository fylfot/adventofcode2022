require '../../shared/input'

print_green('Starting')

WINDOW_WIDTH = 4

read_input().each do |line|
  marker = nil
  (line.size - WINDOW_WIDTH).times do |i|
    marker = i + WINDOW_WIDTH
    subroutine = line[i, WINDOW_WIDTH]
    print_yellow("Subroutine: #{subroutine}")
    break if subroutine.split('').uniq.size == WINDOW_WIDTH
  end
  print_green("Marker at -> #{marker}")
end
