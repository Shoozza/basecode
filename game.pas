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

procedure Enter;
begin
  ResetKeys;
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

procedure Draw;
var
  w, h: single;
begin
  al_clear_to_color(BackgroundColor);

  al_draw_bitmap(Image, 0, 40, 0);

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

procedure Update;
begin
  HandleInput;
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
