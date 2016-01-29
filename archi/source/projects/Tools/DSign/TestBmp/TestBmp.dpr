program TestBmp;

uses
  SysUtils,
  
  Graphics
  ;

function CheckBitmap(const aFileName: TFileName): Integer;
var
 l_Stat     : array [0..2, 0..2, Boolean] of Integer;
 l_Bitmap   : TBitmap;
 l_X, l_Y   : Integer;
 l_C        : TColor;
 l_Ci       : Integer;
 l_Comp     : Integer;
 l_BitNum   : Integer;
 l_Interval : Integer;
 l_Ofs      : Integer;
 l_Bit      : Boolean;
begin
 Result := 0;
 FillChar(l_Stat, SizeOf(l_Stat), 0);
 l_Bitmap := TBitmap.Create;
 try
  l_Bitmap.LoadFromFile(aFileName);
  for l_X := 0 to Pred(l_Bitmap.Width) do
   for l_Y := 0 to Pred(l_Bitmap.Height) do
   begin
    l_C := l_Bitmap.Canvas.Pixels[l_X, l_Y];
    for l_Ci := 0 to 2 do
    begin
     l_Comp := (l_C shr (l_Ci * 8)) AND $FF;
     l_BitNum := 0;
     l_Ofs := 0;
     for l_Interval := 0 to 7 do
     begin
      if (l_Comp < l_Ofs + 32 - 4) OR (l_Interval = 7) then
      begin
       if (l_Comp >= High(Byte) - 12) then
       begin
        if (l_BitNum = 1) then
         l_BitNum := 2;
        l_Bit := l_Comp <= (High(Byte) - 5);
       end
       else
       begin
{        if (l_Comp >= l_Ofs + 32 - 8) then
         break
        else}
         l_Bit := l_Comp >= l_Ofs + 10;
       end;//l_Comp >= High(Byte) - 16
       Inc(l_Stat[l_Ci, l_BitNum, l_Bit]);
       break;
      end;//l_C[l_Ci] < l_Ofs + 32
      Inc(l_Ofs, 32);
      if (l_BitNum = 2) then
       l_BitNum := 0
      else
       Inc(l_BitNum);
     end;//for l_Interval
    end;//for l_Ci
   end;//for l_Y
   for l_Ci := 2 downto 0 do
    for l_BitNum := 2 downto 0 do
    begin
     Result := Result shl 1;
     if (l_Stat[l_Ci, l_BitNum, false] < l_Stat[l_Ci, l_BitNum, true]) then
      Result := Result or 1;
    end;//l_BitNum := 2
 finally
  FreeAndNil(l_Bitmap);
 end;//try..finally
end;

begin
 if (ParamCount < 1) then
  WriteLn('usage: TestBmp filename')
 else
  WriteLn(CheckBitmap(ParamStr(1)));
end.
