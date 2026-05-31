proc newgrid {height width} {
    set grid {}
    for {set row 0} {$row < $height} {incr row} {
        for {set column 0} {$column < $width} {incr column} {
            lappend grid 0
        }
    }
    return $grid
}

proc query {grid i j height width} {
    set row [expr $i % $height]
    set column [expr $j % $width]
    set value [lindex $grid [expr $row * $width + $column]]
    return $value
}

proc assign {grid i j width value} {
    lset grid [expr $i * $width + $j] $value
    return $grid
}

proc countneighbors {grid x y height width} {
    set n  [query $grid [expr $x + 1]       $y      $height $width]
    set ne [query $grid [expr $x + 1] [expr $y + 1] $height $width]
    set e  [query $grid       $x      [expr $y + 1] $height $width]
    set se [query $grid [expr $x - 1] [expr $y + 1] $height $width]
    set s  [query $grid [expr $x - 1]       $y      $height $width]
    set sw [query $grid [expr $x - 1] [expr $y - 1] $height $width]
    set w  [query $grid       $x      [expr $y - 1] $height $width]
    set nw [query $grid [expr $x + 1] [expr $y - 1] $height $width]
    set result [expr $n + $ne + $e + $se + $s + $sw + $w + $nw]
    return $result
}

proc draw {value} {
    if {$value == 1} {
        return "#"
    } else {
        return "."
    }
}

proc printgrid {grid height width} {
    for {set row 0} {$row < $height} {incr row} {
        for {set column 0} {$column < $width} {incr column} {
            set value [draw [lindex $grid [expr $row * $width + $column]]]
            puts -nonewline $value
        }
        puts {}
    }
}

proc gamelogic {state neighbors} {
    if {$state == 1} {
        if {$neighbors < 2} {
            return 0
        }
        if {$neighbors > 3} {
            return 0
        }
        return $state
    } else {
        if {$neighbors == 3} {
            return 1
        }
        return $state
    }
}

proc stepcell {grid x y height width} {
    set state [query $grid $x $y $height $width]
    set neighbors [countneighbors $grid $x $y $height $width]
    set nextstate [gamelogic $state $neighbors]
    return $nextstate
}

proc simulate {grid height width} {
    set newnewgrid [newgrid $height $width]
    for {set row 0} {$row < $height} {incr row} {
        for {set column 0} {$column < $width} {incr column} {
            set nextstate [stepcell $grid $row $column $height $width]
            set newnewgrid [assign $newnewgrid $row $column $width $nextstate]
        }
    }
    return $newnewgrid
}

proc clearscreen {} {
    puts "\x1B\x5B\x32\x4A\x1B\x5B\x30\x3B\x30\x48"
}

set height 10
set width 20

set g [newgrid $height $width]

set g [assign $g 0 3 $width 1]
set g [assign $g 1 4 $width 1]
set g [assign $g 2 2 $width 1]
set g [assign $g 2 3 $width 1]
set g [assign $g 2 4 $width 1]

printgrid $g $height $width

while {1} {
    clearscreen
    set g [simulate $g $height $width]
    printgrid $g $height $width
    after 100
}

# tclsh conway.tcl
