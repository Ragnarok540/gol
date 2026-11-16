Sub DrawV(value As Integer)
    If value = 1 Then
        Print "#" ;
    Else 
        Print "." ;
    End If
End Sub

Sub PrintGrid(grid() As Integer)
    For row As Integer = LBound(grid) To UBound(grid)
        For col As Integer = LBound(grid, 2) To UBound(grid, 2)
            DrawV(grid(row, col))
        Next
        Print ""
    Next
End Sub

Function FloorMod(x As Integer, y As Integer) As Integer
    If x > 0 Then
        Return x mod y
    End If
    If x < 0 Then
        Return y + x mod y
    End If
    Return 0
End Function

Sub Assign(grid() As Integer, row as Integer, col as Integer, value as Integer)
    grid(FloorMod(row, UBound(grid) + 1), FloorMod(col, UBound(grid, 2) + 1)) = value
End Sub

Function Query(grid() As Integer, row as Integer, col as Integer) As Integer
    Return grid(FloorMod(row, UBound(grid) + 1), FloorMod(col, UBound(grid, 2) + 1))
End Function

Function CountNeighbors(grid() As Integer, row As Integer, col As Integer) As Integer
    Dim As Integer n, ne, e, se, s, sw, w, nw
    n  = Query(grid(), row + 1, col    )
    ne = Query(grid(), row + 1, col + 1)
    e  = Query(grid(), row,     col + 1)
    se = Query(grid(), row - 1, col + 1)
    s  = Query(grid(), row - 1, col    )
    sw = Query(grid(), row - 1, col - 1)
    w  = Query(grid(), row,     col - 1)
    nw = Query(grid(), row + 1, col - 1)
    Return n + ne + e + se + s + sw + w + nw
End Function

Function GameLogic(state As Integer, neighbors As Integer) As Integer
    If state = 1 Then
        If neighbors < 2 Or neighbors > 3 Then
            Return 0
        End If
        Return state
    Else
        If neighbors = 3 Then
            Return 1
        End If
        Return state
    End If
End Function

Function StepCell(grid() As Integer, row As Integer, col As Integer) As Integer
    Dim As Integer state, neighbors, nextState = 0
    state = Query(grid(), row, col)
    neighbors = CountNeighbors(grid(), row, col)
    nextState = GameLogic(state, neighbors)
    return nextState
End Function

Sub Simulate(grid() As Integer)
    Dim newGrid(LBound(grid) To UBound(grid), LBound(grid, 2) To UBound(grid, 2)) As Integer

    For row As Integer = LBound(grid) To UBound(grid)
        For col As Integer = LBound(grid, 2) To UBound(grid, 2)
            Assign(newGrid(), row, col, StepCell(grid(), row, col))
        Next
    Next

    For row As Integer = LBound(grid) To UBound(grid)
        For col As Integer = LBound(grid, 2) To UBound(grid, 2)
            Assign(grid(), row, col, newGrid(row, col)) 
        Next
    Next
End Sub

Dim grid(0 To 9, 0 To 19) As Integer 

Assign(grid(), 1, 4, 1)
Assign(grid(), 2, 5, 1)
Assign(grid(), 3, 3, 1)
Assign(grid(), 3, 4, 1)
Assign(grid(), 3, 5, 1)

PrintGrid(grid())

While True
    cls
    Simulate(grid())
    PrintGrid(grid())
    Sleep 100
WEnd

' mkdir -p bin
' fbc -x bin/conway conway.bas
' ./bin/conway
