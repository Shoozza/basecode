unit input;

interface

function IsKeyDown(Key: Integer): Boolean;
function IsKeyJustDown(Key: Integer): Boolean;
procedure ResetKeys;
procedure RefreshKeys;
procedure RefreshKeyUp(Key: Integer);
procedure RefreshKeyDown(Key: Integer);


implementation

uses
  Allegro5;

var
  Keys: Array [0..ALLEGRO_KEY_MAX] of Integer;

function IsKeyDown(Key: Integer): Boolean;
begin
  Result := Keys[Key] > 0;
end;

function IsKeyJustDown(Key: Integer): Boolean;
begin
  Result := Keys[Key] = 1;
end;

procedure ResetKeys;
var
  I: Integer;
begin
  for I := Low(Keys) to High(Keys) do
    Keys[I] := 0;
end;

procedure RefreshKeys;
var
  I: Integer;
begin
  for I := Low(Keys) to High(Keys) do
    if Keys[I] = 1 then
      Keys[I] := 2;
end;

procedure RefreshKeyDown(Key: Integer);
begin
  if Keys[Key] < 2 then
    Inc(Keys[Key]);
end;

procedure RefreshKeyUp(Key: Integer);
begin
  Keys[Key] := 0;
end;

end.
