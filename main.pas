unit main;

interface

procedure Run;


implementation

uses
  game,
  framework,
  logger;

procedure Run;
begin
  framework.Load;
  game.Load;

  game.Run;

  game.Quit;
  framework.Quit;
end;

end.
