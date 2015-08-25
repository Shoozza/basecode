unit collision;

interface

function AABB(ax, ay, aw, ah, bx, by, bw, bh: Single): Boolean;
function IAABB(ax, ay, aw, ah, bx, by, bw, bh: Integer): Boolean;

function CCI(ax, ay, ar, bx, by, br: Single): Boolean;
function ICCI(ax, ay, ar, bx, by, br: Integer): Boolean;


implementation

function AABB(ax, ay, aw, ah, bx, by, bw, bh: Single): Boolean;
begin
  Result := (ax+aw > bx) and (bx+bw > ax) and (ay+ah > by) and (by+bh > ay);
end;

function IAABB(ax, ay, aw, ah, bx, by, bw, bh: Integer): Boolean;
begin
  Result := (ax+aw > bx) and (bx+bw > ax) and (ay+ah > by) and (by+bh > ay);
end;


function CCI(ax, ay, ar, bx, by, br: Single): Boolean;
var
  r, x, y: Single;
begin
  r := ar + br;
  x := ax - bx;
  y := ay - by;

  Result := (r * r > (x * x) + (y * y));
end;

function ICCI(ax, ay, ar, bx, by, br: Integer): Boolean;
var
  r, x, y: Single;
begin
  r := ar + br;
  x := ax - bx;
  y := ay - by;

  Result := (r * r > (x * x) + (y * y));
end;


end.
