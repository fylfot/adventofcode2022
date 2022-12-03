package main

import (
	"fmt"
	. "shared"
	"strings"
)

func main() {

	rounds := LoadInput()

	// A
	// B
	// C

	// Y
	// X
	// Z

	// A X - rock
	// B Y - paper
	// C Z - Scrissors

	// Rock - 1
	// Paper - 2
	// Scrissors - 3

	// Draw - 3
	// Win - 6

	scores := 0

	// score_map := map[string]int{
	// 	"A": 1,
	// 	"B": 2,
	// 	"C": 3,
	// }

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

	const (
		OverrideLose = "lose"
		OverrideDraw = "draw"
		OverrideWin  = "win"
	)

	override_map := map[string]string{
		"X": OverrideLose,
		"Y": OverrideDraw,
		"Z": OverrideWin,
	}

	PrintYellow("Starting")
	for _, round := range rounds {
		pair := strings.Split(round, " ")
		l, r := emoji_map[pair[0]], emoji_map[pair[1]]

		switch override_map[pair[1]] {
		case OverrideLose:
			r = force_map[l]
		case OverrideDraw:
			r = l
		case OverrideWin:
			r = force_map[force_map[l]]
		}

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
