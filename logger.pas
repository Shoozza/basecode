unit logger;

interface

procedure Log(text: string);
procedure ErrorQuit(text: string);

implementation

procedure Log(text: string);
begin
  WriteLn(text);
end;

procedure ErrorQuit(text: string);
begin
  Log('Error: ' + text);
  Halt(1);
end;

end.
