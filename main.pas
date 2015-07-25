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
  Log('Start');

  framework.Load;
  game.Load;

  game.Run;

  game.Quit;
  framework.Quit;

  Log('End');
end;

end.
