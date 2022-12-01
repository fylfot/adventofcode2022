use shared::input::{setup_crashhook, print_yellow, print_red, print_green, load_input};

fn main() {
    setup_crashhook();

    let elf_loads = load_input();

    let mut loads = Vec::new();
    let mut load_current = 0;
    print_yellow("Starting");
    for record in elf_loads {
        if record.len() <= 0 {
            print_green(format!("Current load: {}", load_current));
            loads.push(load_current * -1);
            load_current = 0;
        } else {
            load_current += record.parse::<i32>().unwrap();
        }
    }
    loads.sort();
    print_yellow("--------------------");
    print_red(format!("Largest 3 loads sum: {}", (loads[0] + loads[1] + loads[2]) * -1));
}
