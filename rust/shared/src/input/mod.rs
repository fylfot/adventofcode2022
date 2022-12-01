use std::panic::set_hook;
use std::fs::File;
use std::io::{self, BufRead};

pub fn load_input() -> Vec<String> {
  let file = File::open("./input.txt").expect("File not found or unreadable");
  io::BufReader::new(file).lines().collect::<Result<_, _>>().unwrap()
}

pub fn setup_crashhook() {
  set_hook(Box::new(|info| {
    if let Some(s) = info.payload().downcast_ref::<String>() {
      println!("\x1b[37;41;1m[ERROR]\x1b[0m {}", s);
    }
  }));
}

pub fn print_red<P>(msg: P)
where P: ToString {
  println!("\x1b[37;41;1m{}\x1b[0m", msg.to_string());
}

pub fn print_green<P>(msg: P)
where P: ToString {
  println!("\x1b[32;1m{}\x1b[0m", msg.to_string());
}

pub fn print_yellow<P>(msg: P)
where P: ToString {
  println!("\x1b[33;1m{}\x1b[0m", msg.to_string());
}

#[test]
fn check_load() {
  let input = load_input();
  assert_eq!(input.len(), 5);
}

#[test]
fn check_print() {
  print_red("red");
  print_green("green");
  print_yellow("yellow");
}