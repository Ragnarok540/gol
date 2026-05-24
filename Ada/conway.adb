-- https://www.youtube.com/watch?v=qJAuyoDt03A

with Ada.Text_IO;
with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;

package body Conway is
   use Ada.Text_IO;
   V : State;
   Matrix : Grid;

   procedure Initialize(M : in out Grid) is
   begin
      for I in Height loop
         for J in Width loop
            M(I, J) := 0;
         end loop;
      end loop;
   end;

   function Count_Neighbors(M : Grid; X : Height; Y : Width) return Neighbors is
      N, NE, E, SE, S, SW, W, NW : Neighbors;
   begin
      N  := Neighbors(M(X + 1, Y));
      NE := Neighbors(M(X + 1, Y + 1));
      E  := Neighbors(M(X,     Y + 1));
      SE := Neighbors(M(X - 1, Y + 1));
      S  := Neighbors(M(X - 1, Y));
      SW := Neighbors(M(X - 1, Y - 1));
      W  := Neighbors(M(X,     Y - 1));
      NW := Neighbors(M(X + 1, Y - 1));
      return N + NE + E + SE + S + SW + W + NW;
   end;

   function Draw(Value : State) return Character is
   begin
      if Value = 1 then
         return '#';
      else
         return '.';
      end if;
   end;

   procedure Print(M : Grid) is
   begin
      for I in Height loop
         for J in Width loop
            V := M(I, J);
            Put(Draw(V));
         end loop;
         New_Line;
      end loop;
   end;

   function Game_Logic(S : State; N : Neighbors) return State is
   begin
      if S = 1 then
         if N < 2 then
            return 0;
         end if;
         if N > 3 then
            return 0;
         end if;
         return S;
      else
         if N = 3 then
            return 1;
         end if;
         return S;
      end if;
   end;

   function Step_Cell(M : Grid; X : Height; Y : Width) return State is
      S : State;
      N : Neighbors;
      Next_S : State;
   begin
      S := M(X, Y);
      N := Count_Neighbors(M, X, Y);
      Next_S := Game_Logic(S, N);
      return Next_S;
   end;

   function Simulate(M : Grid) return Grid is
      New_M : Grid;
   begin
      Initialize(New_M);

      for I in Height loop
         for J in Width loop
            New_M(I, J) := Step_Cell(M, I, J);
         end loop;
      end loop;

      return New_M;
   end;

   procedure Clear_Screen is
   begin
      Put(Ada.Characters.Latin_1.ESC & "[" & Ada.Strings.Fixed.Trim("10", Ada.Strings.Left) & "A");
      Put(Ada.Characters.Latin_1.ESC & "[" & Ada.Strings.Fixed.Trim("20", Ada.Strings.Left) & "D");
   end;

begin
   Initialize(Matrix);

   Matrix(0, 3) := 1;
   Matrix(1, 4) := 1;
   Matrix(2, 2) := 1;
   Matrix(2, 3) := 1;
   Matrix(2, 4) := 1;

   Print(Matrix);

   while True loop
      Clear_Screen;
      Matrix := Simulate(Matrix);
      Print(Matrix);
      delay 0.1;
   end loop;
end Conway;

-- mkdir -p bin
-- gnatmake -gnatwa -o bin/conway -z conway.adb
-- ./bin/conway
