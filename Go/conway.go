package main

import (
	"fmt"
	"time"
)

const HEIGHT = 10
const WIDTH = 20

type Grid = [HEIGHT][WIDTH]int

func Mod(x int, y int) int {
	if x > 0 {
		return x % y
	}
	if x < 0 {
		return y + x%y
	}
	return 0
}

func Query(grid Grid, x int, y int) int {
	return grid[Mod(x, HEIGHT)][Mod(y, WIDTH)]
}

func Assign(grid *Grid, x int, y int, state int) {
	grid[Mod(x, HEIGHT)][Mod(y, WIDTH)] = state
}

func CountNeighbors(grid Grid, x int, y int) int {
	var n  = Query(grid, x + 1, y    )
	var ne = Query(grid, x + 1, y + 1)
	var e  = Query(grid, x,     y + 1)
	var se = Query(grid, x - 1, y + 1)
	var s  = Query(grid, x - 1, y    )
	var sw = Query(grid, x - 1, y - 1)
	var w  = Query(grid, x,     y - 1)
	var nw = Query(grid, x + 1, y - 1)
	return n + ne + e + se + s + sw + w + nw
}

func Draw(value int) byte {
	if value == 1 {
		return '#'
	} else {
		return '.'
	}
}

func Print(grid Grid) {
	for i := range grid {
		for j := range grid[i] {
			fmt.Printf("%c", Draw(grid[i][j]))
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

func StepCell(grid Grid, x int, y int) int {
	var state = Query(grid, x, y)
	var neighbors = CountNeighbors(grid, x, y)
	var nextState = GameLogic(state, neighbors)
	return nextState
}

func Simulate(grid Grid) Grid {
	var newGrid Grid
	for x := range grid {
		for y := range grid[x] {
			newGrid[x][y] = StepCell(grid, x, y)
		}
	}
	return newGrid
}

func ClearScreen() {
	fmt.Println("\x1B[2J")
}

func main() {
	var grid Grid

	Assign(&grid, 0, 3, 1)
	Assign(&grid, 1, 4, 1)
	Assign(&grid, 2, 2, 1)
	Assign(&grid, 2, 3, 1)
	Assign(&grid, 2, 4, 1)

	Print(grid)

	for {
		ClearScreen()
		grid = Simulate(grid)
		Print(grid)
		time.Sleep(100 * time.Millisecond)
	}
}

// go run conway.go
