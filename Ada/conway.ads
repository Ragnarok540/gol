package Conway is
   type State is mod 2;
   type Height is mod 10;
   type Width is mod 20;
   type Grid is array (Height, Width) of State;
   type Neighbors is range 0 .. 8;
   procedure Initialize(M : in out Grid);
   function Count_Neighbors(M : in Grid; X : Height; Y : Width) return Neighbors;
   function Draw(Value : State) return Character;
   procedure Print(M : in  Grid);
   function Game_Logic(S : State; N : Neighbors) return State;
   function Step_Cell(M : Grid; X : Height; Y : Width) return State;
   function Simulate(M : Grid) return Grid;
   procedure Clear_Screen;
end Conway;
