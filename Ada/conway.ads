package Conway is
   type State is mod 2;
   type Height is range 1 .. 10;
   type Width is range 1 .. 20;
   type Grid is array (Height, Width) of State;
   procedure Initialize (M : in out Grid);
   procedure Print (M : in  Grid);
end Conway;
