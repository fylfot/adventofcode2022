package main

import (
	"fmt"
	. "shared"
	"strings"
)

func main() {

	rounds := LoadInput()
	scores := 0

	// NOTE: whitespaces needed here to prevent issues with
	//  invalid UTF-8 length calc for printing for some emojis
	emoji_map := map[string]string{
		"A": "🪨 ",
		"B": "🧻",
		"C": "✂️ ",
		"X": "🪨 ",
		"Y": "🧻",
		"Z": "✂️ ",
	}

	force_map := map[string]string{
		"🪨 ":  "✂️ ",
		"🧻":   "🪨 ",
		"✂️ ": "🧻",
	}

	energy_map := map[string]int{
		"🪨 ":  1,
		"🧻":   2,
		"✂️ ": 3,
	}

	PrintYellow("Starting")
	for _, round := range rounds {
		pair := strings.Split(round, " ")
		l, r := emoji_map[pair[0]], emoji_map[pair[1]]
		round_score := energy_map[r]
		if l == r {
			round_score = round_score + 3
		} else if force_map[r] == l {
			round_score = round_score + 6
		}
		scores = scores + round_score
		PrintGreen(fmt.Sprintf("Round: %s vs %s (%d)", l, r, round_score))
	}
	PrintYellow("--------------------")
	PrintRed(fmt.Sprintf("Scores: %d", scores))
}
