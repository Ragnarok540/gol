package main

import (
	"fmt"
	"time"
)

const HEIGHT = 10
const WIDTH = 20

func Mod(x int, y int) int {
	if x > 0 {
		return x % y
	}
	if x < 0 {
		return y + x%y
	}
	return 0
}

func Query(matrix [HEIGHT][WIDTH]int, x int, y int) int {
	return matrix[Mod(x, HEIGHT)][Mod(y, WIDTH)]
}

func Assign(matrix *[HEIGHT][WIDTH]int, x int, y int, state int) {
	matrix[Mod(x, HEIGHT)][Mod(y, WIDTH)] = state
}

func CountNeighbors(matrix [HEIGHT][WIDTH]int, x int, y int) int {
	var n = Query(matrix, x+1, y)
	var ne = Query(matrix, x+1, y+1)
	var e = Query(matrix, x, y+1)
	var se = Query(matrix, x-1, y+1)
	var s = Query(matrix, x-1, y)
	var sw = Query(matrix, x-1, y-1)
	var w = Query(matrix, x, y-1)
	var nw = Query(matrix, x+1, y-1)
	return n + ne + e + se + s + sw + w + nw
}

func Draw(value int) byte {
	if value == 1 {
		return '#'
	} else {
		return '.'
	}
}

func Print(matrix [HEIGHT][WIDTH]int) {
	for i := range matrix {
		for j := range matrix[i] {
			fmt.Printf("%c", Draw(matrix[i][j]))
		}
		fmt.Println()
	}
}

func GameLogic(state int, neighbors int) int {
	if state == 1 {
		if neighbors < 2 {
			return 0
		}
		if neighbors > 3 {
			return 0
		}
		return state
	} else {
		if neighbors == 3 {
			return 1
		}
		return state
	}
}

func StepCell(matrix [HEIGHT][WIDTH]int, x int, y int) int {
	var state = Query(matrix, x, y)
	var neighbors = CountNeighbors(matrix, x, y)
	var nextState = GameLogic(state, neighbors)
	return nextState
}

func Simulate(matrix [HEIGHT][WIDTH]int) [HEIGHT][WIDTH]int {
	var newMatrix [HEIGHT][WIDTH]int
	for x := range matrix {
		for y := range matrix[x] {
			newMatrix[x][y] = StepCell(matrix, x, y)
		}
	}
	return newMatrix
}

func ClearScreen() {
	fmt.Println("\x1B[2J")
}

func main() {
	var matrix [HEIGHT][WIDTH]int

	Assign(&matrix, 0, 3, 1)
	Assign(&matrix, 1, 4, 1)
	Assign(&matrix, 2, 2, 1)
	Assign(&matrix, 2, 3, 1)
	Assign(&matrix, 2, 4, 1)

	Print(matrix)

	for {
		ClearScreen()
		matrix = Simulate(matrix)
		Print(matrix)
		time.Sleep(100 * time.Millisecond)
	}
}

// go run conway.go
