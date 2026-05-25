package Conway is
   Height : constant Positive := 10;
   Width  : constant Positive := 20;
   type State is range 0 .. 1;
   type Rows is mod Height;
   type Cols is mod Width;
   type Grid is array (Rows, Cols) of State;
   type Neighbors is range 0 .. 8;
   function Count_Neighbors(M : Grid; X : Rows; Y : Cols) return Neighbors;
   function Draw(Value : State) return Character;
   procedure Print(M : in  Grid);
   function Game_Logic(S : State; N : Neighbors) return State;
   function Step_Cell(M : Grid; X : Rows; Y : Cols) return State;
   function Simulate(M : Grid) return Grid;
   procedure Clear_Screen;
end Conway;
