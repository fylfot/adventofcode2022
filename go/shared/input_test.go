package shared

import (
	"testing"
)

func TestLoad(t *testing.T) {
	input := LoadInput()
	if len(input) != 5 {
		t.Error("Input check failed")
	}
}

func TestPrint(t *testing.T) {
	PrintRed("red")
	PrintGreen("green")
	PrintYellow("yellow")
}
