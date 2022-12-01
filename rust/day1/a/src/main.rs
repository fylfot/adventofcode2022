use shared::input::{setup_crashhook, print_yellow, print_red, print_green, load_input};

fn main() {
    setup_crashhook();

    let elf_loads = load_input();

    let mut load_current = 0;
    let mut load_largest = 0;
    print_yellow("Starting");
    for record in elf_loads {
        if record.len() <= 0 {
            print_green(format!("Current load: {}", load_current));
            if load_current > load_largest {
                load_largest = load_current;
            }
            load_current = 0;
        } else {
            load_current += record.parse::<i32>().unwrap();
        }
    }
    print_yellow("--------------------");
    print_red(format!("Largest load: {}", load_largest));
}
