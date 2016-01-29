unit fcGraphics;

interface

uses Windows, Graphics;

function PaletteFromDIBColorTable(DIBHandle: THandle; ColorTable: Pointer;
  ColorCount: Integer): HPalette;
procedure ByteSwapColors(var Colors; Count: Integer);

implementation

procedure ByteSwapColors(var Colors; Count: Integer);
var   // convert RGB to BGR and vice-versa.  TRGBQuad <-> TPaletteEntry
  SysInfo: TSystemInfo;
begin
  GetSystemInfo(SysInfo);
  asm
        MOV   EDX, Colors
        MOV   ECX, Count
        DEC   ECX
        JS    @@END
        LEA   EAX, SysInfo
        CMP   [EAX].TSystemInfo.wProcessorLevel, 3
        JE    @@386
  @@1:  MOV   EAX, [EDX+ECX*4]
        BSWAP EAX
        SHR   EAX,8
        MOV   [EDX+ECX*4],EAX
        DEC   ECX
        JNS   @@1
        JMP   @@END
  @@386:
        PUSH  EBX
  @@2:  XOR   EBX,EBX
        MOV   EAX, [EDX+ECX*4]
        MOV   BH, AL
        MOV   BL, AH
        SHR   EAX,16
        SHL   EBX,8
        MOV   BL, AL
        MOV   [EDX+ECX*4],EBX
        DEC   ECX
        JNS   @@2
        POP   EBX
    @@END:
  end;
end;

function SystemPaletteOverride(var Pal: TMaxLogPalette): Boolean;
var
  DC: HDC;
  SysPalSize: Integer;
begin
  Result := False;
  if SystemPalette16 <> 0 then
  begin
    DC := GetDC(0);
    try
      SysPalSize := GetDeviceCaps(DC, SIZEPALETTE);
      if SysPalSize >= 16 then
      begin
        { Ignore the disk image of the palette for 16 color bitmaps.
          Replace with the first and last 8 colors of the system palette }
        GetPaletteEntries(SystemPalette16, 0, 8, Pal.palPalEntry);
        GetPaletteEntries(SystemPalette16, 8, 8, Pal.palPalEntry[Pal.palNumEntries - 8]);
        Result := True;
      end
    finally
      ReleaseDC(0,DC);
    end;
  end;
end;

function PaletteFromDIBColorTable(DIBHandle: THandle; ColorTable: Pointer;
  ColorCount: Integer): HPalette;
var
  DC: HDC;
  Save: THandle;
  Pal: TMaxLogPalette;
begin
  Result := 0;
  Pal.palVersion := $300;
  if DIBHandle <> 0 then
  begin
    DC := CreateCompatibleDC(0);
    Save := SelectObject(DC, DIBHandle);
    Pal.palNumEntries := GetDIBColorTable(DC, 0, 256, Pal.palPalEntry);
    SelectObject(DC, Save);
    DeleteDC(DC);
  end
  else
  begin
    Pal.palNumEntries := ColorCount;
    Move(ColorTable^, Pal.palPalEntry, ColorCount * 4);
  end;
  if Pal.palNumEntries = 0 then Exit;
  if (Pal.palNumEntries <> 16) or not SystemPaletteOverride(Pal) then
    ByteSwapColors(Pal.palPalEntry, Pal.palNumEntries);
  Result := CreatePalette(PLogPalette(@Pal)^);
end;

end.
