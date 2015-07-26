unit game;

interface

procedure Run;

procedure Load;
procedure Quit;


implementation

uses
  SysUtils,
  Allegro5,
  al5font,
  al5ttf,
  al5primitives,
  al5audio,
  globals,
  logger,
  input;

type
  TPlayer = record
    x, y, vx, vy: Single;
  end;

  TEntity = record
    active: Boolean;
    x, y, vx, vy: Single;
  end;
var
  I: Integer;
  Player: TPlayer;
  Entities: Array [0..10] of TEntity;

procedure Enter;
begin
  ResetKeys;

  for I := Low(Entities) to High(Entities) do
  begin
    Entities[I].active := True;
  end;
end;

procedure Leave;
begin
end;

procedure Load;
begin
  Font := al_load_ttf_font_stretch('assets' + PathDelim + 'font.ttf', 26, 20,
    ALLEGRO_TTF_MONOCHROME or
    ALLEGRO_TTF_NO_KERNING or
    ALLEGRO_TTF_NO_AUTOHINT or
    0);
  if Font = nil then
    ErrorQuit('Font');

  Image := al_load_bitmap('assets' + PathDelim + 'image.png');
  if Image = nil then
    ErrorQuit('Image');

  Sound := al_load_sample('assets' + PathDelim + 'sound.wav');
  if Sound = nil then
    ErrorQuit('Sound');

  {
  // not yet ready
  Music := al_load_audio_stream('assets' + PathDelim + 'music.ogg', 4, 2048);
  if Music = nil then
    ErrorQuit('Music');

  al_register_event_source(queue, al_get_audio_stream_event_source(Music));
  }

  al_play_sample(Sound, 1, 0, 1, ALLEGRO_PLAYMODE_ONCE, nil);
end;

procedure Quit;
begin
end;

procedure DrawPlayer;
begin
  al_draw_bitmap(Image, Player.x, Player.y, 0);
end;

procedure DrawEntities;
begin
  for I := Low(Entities) to High(Entities) do
  begin
    if Entities[I].active then
      al_draw_bitmap(Image, Entities[I].x, Entities[I].y, 0);
  end;
end;

procedure Draw;
begin
  al_clear_to_color(BackgroundColor);

  DrawPlayer;
  DrawEntities;

  al_draw_text(Font, al_map_rgb(0, 0, 0),
    11.0, 11.0, ALLEGRO_ALIGN_LEFT, 'The Game');
  al_draw_text(Font, al_map_rgb(113, 249, 129),
    10.0, 10.0, ALLEGRO_ALIGN_LEFT, 'The Game');

  al_flip_display;
end;

procedure HandleInput;
begin
  if IsKeyJustDown(ALLEGRO_KEY_ESCAPE) then
    IsRunning := False;

  RefreshKeys;
end;

procedure UpdatePlayer;
begin
  Player.x := Player.x + Player.vx;
  Player.y := Player.y + Player.vy;

  if Player.vx > 0 then
  begin
    Player.vx := Player.vx - 1;
  end else
  begin
    Player.vx := 0;
  end;

  if Player.vy > 0 then
  begin
    Player.vy := Player.vy - 1;
  end else
  begin
    Player.vy := 0;
  end;
end;

procedure UpdateEntities;
begin
  for I := Low(Entities) to High(Entities) do
  begin
    if Entities[I].active then
    begin
      Entities[I].x := Entities[I].x + Entities[I].vx;
      Entities[I].y := Entities[I].y + Entities[I].vy;

      if Entities[I].vx > 0 then
      begin
        Entities[I].vx := Entities[I].vx - 1;
      end else
      begin
        Entities[I].vx := 0;
      end;

      if Entities[I].vy > 0 then
      begin
        Entities[I].vy := Entities[I].vy - 1;
      end else
      begin
        Entities[I].vy := 0;
      end;
    end;
  end;
end;

procedure Update;
begin
  HandleInput;

  UpdatePlayer;
  UpdateEntities;
end;

procedure Run;
var
  NeedsRedraw: Boolean;
  Event: ALLEGRO_EVENT;
begin
  Enter;

  NeedsRedraw := True;
  IsRunning := True;

  while IsRunning do
  begin
    al_wait_for_event(Queue, Event);

    case Event._Type of
      ALLEGRO_EVENT_TIMER:
      begin
        NeedsRedraw := True;
      end;

      ALLEGRO_EVENT_DISPLAY_CLOSE:
      begin
        IsRunning := False;
      end;

      ALLEGRO_EVENT_KEY_DOWN:
      begin
        RefreshKeyDown(Event.keyboard.keycode);
      end;

      ALLEGRO_EVENT_KEY_UP:
      begin
        RefreshKeyUp(Event.keyboard.keycode);
      end;

      ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
      begin
      end;

      ALLEGRO_EVENT_MOUSE_BUTTON_UP:
      begin
      end;
    end;

    if NeedsRedraw and al_is_event_queue_empty(Queue) then
    begin
      NeedsRedraw := False;
      Update;
      Draw;
    end;
  end;
  Leave;
end;


end.
