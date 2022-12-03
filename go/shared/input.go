package shared

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func LoadInput() []string {
	file, err := os.Open("./input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	results := []string{}

	for scanner.Scan() {
		results = append(results, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return results
}

func PrintRed(msg string) {
	fmt.Println("\x1b[37;41;1m", msg, "\x1b[0m")
}

func PrintGreen(msg string) {
	fmt.Println("\x1b[32;1m", msg, "\x1b[0m")
}

func PrintYellow(msg string) {
	fmt.Println("\x1b[33;1m", msg, "\x1b[0m")
}
