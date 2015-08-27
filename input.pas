unit input;

interface

// keyboard input
function IsKeyDown(Key: Integer): Boolean;
function IsKeyJustDown(Key: Integer): Boolean;
procedure ResetKeys;
procedure RefreshKeys;
procedure RefreshKeyUp(Key: Integer);
procedure RefreshKeyDown(Key: Integer);

// mouse input
function IsMouseButtonDown(Button: Integer): Boolean;
function IsMouseButtonJustDown(Button: Integer): Boolean;
procedure ResetMouseButtons;
procedure RefreshMouseButtons;
procedure RefreshMouseButtonDown(Button: Integer);
procedure RefreshMouseButtonUp(Button: Integer);


implementation

uses
  Allegro5;

// Keyboard input
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

// mouse input
const
  MOUSE_BUTTON_MAX = 16;  // should be enough
var
  MouseButtons: Array [1..MOUSE_BUTTON_MAX] of Integer;

function IsMouseButtonDown(Button: Integer): Boolean;
begin
  Result := MouseButtons[Button] > 0;
end;

function IsMouseButtonJustDown(Button: Integer): Boolean;
begin
  Result := MouseButtons[Button] = 1;
end;

procedure ResetMouseButtons;
var
  I: Integer;
begin
  for I := 1 to MOUSE_BUTTON_MAX do
  begin
    MouseButtons[I] := 0;
  end;
end;

procedure RefreshMouseButtons;
var
  I: Integer;
begin
  for I := 1 to MOUSE_BUTTON_MAX do
  begin
    if MouseButtons[I] = 1 then
      MouseButtons[I] := 2;
  end;
end;

procedure RefreshMouseButtonDown(Button: Integer);
begin
  if MouseButtons[Button] < 2 then
    Inc(MouseButtons[Button]);
end;

procedure RefreshMouseButtonUp(Button: Integer);
begin
  MouseButtons[Button] := 0;
end;


end.
