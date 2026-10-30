program HelloWorld(output);
begin
    WriteLn('Hello, World!')
end.

{mkdir -p bin}
{fpc -FEbin conway.pas}
{./bin/conway}
