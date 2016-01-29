
{*****************************************************}
{                                                     }
{             EldoS Themes Support Library            }
{                                                     }
{           (C) 2002-2003 EldoS Corporation           }
{                http://www.eldos.com/                }
{                                                     }
{*****************************************************}

{$include elpack2.inc}

{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit ElThemesGraphics;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Windows,
  Graphics;

procedure AlphaDrawRect(DestDC: HDC; X: integer; Y: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer);
procedure AlphaStretchRect(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  LM: integer; TM: integer; RM: integer; BM: integer; BorderOnly: boolean = False);
procedure DrawRect(DestDC: HDC; X: integer; Y: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  TransparentColor: TColor = clNone);
procedure StretchIcon(Icon: HIcon; DC: HDC; X: integer; Y: integer; W: integer;
  H: integer);
procedure StretchRect(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  LM: integer; TM: integer; RM: integer; BM: integer;
  TransparentColor: TColor = clNone; BorderOnly: boolean = False);
procedure TileRect(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  LM: integer; TM: integer; RM: integer; BM: integer;
  TransparentColor: TColor = clNone; BorderOnly: boolean = False);
procedure FixAlphaImage(Image: TBitmap);

{$ENDIF}

implementation

{$IFDEF ELPACK_THEME_ENGINE}

uses
  Classes, ElVCLUtils, SysUtils, ElTools;

type
  TColorRGB = packed record
    R, G, B, A: Byte;
  end;
  PColorRGB = ^TColorRGB;

type
  TAlphaBlendProc = function (DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
    SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
    Func: BLENDFUNCTION): longbool; stdcall;
  TStretchBltProc = function (DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
    SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
    ROP: cardinal): longbool; stdcall;
  TTransparentBltProc = function (DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
    SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
    TransparentColor: cardinal): longbool; stdcall;

const
  StretchMult = $8000;

var
  UseMMX: boolean;
  AlphaBlend: TAlphaBlendProc;
  StretchBlt: TStretchBltProc;
  TransparentBlt: TTransparentBltProc;

procedure MakeAlpha(PBits, DBits: pointer; N: DWord);
const
  A1: array [0..3] of word = (0, 0, 0, $FFFF);
  A2: array [0..3] of word = (256, 256, 256, 0);
begin
  if N = 0 then
    exit;
  if useMMX then
  begin
    asm
      pushad;
      mov esi,PBits;
      mov edi,DBits;

      lea eax,a1[0];
      db $0F,$6F,$38           /// movq mm7,[eax]
      lea eax,a2[0];
      db $0F,$6F,$30           /// movq mm6,[eax]
      db $0F,$EF,$ED           /// pxor mm5,mm5

      mov eax,n;
    @l:
//      mov byte ptr [esi+3],128; //Alpha:=50% (test)

      db $0F,$6E,$06           /// movd mm0,[esi]
      db $0F,$6E,$0F           /// movd mm1,[edi]

      db $0F,$60,$C5           /// punpcklbw mm0,mm5
      db $0F,$60,$CD           /// punpcklbw mm1,mm5

      db $0F,$6F,$D0           /// movq mm2,mm0
      db $0F,$DB,$D7           /// pand mm2,mm7
      {a,0,0,0}

      db $0F,$69,$D2           /// punpckhwd mm2,mm2
      db $0F,$69,$D2           /// punpckhwd mm2,mm2
      db $0F,$73,$D2,$10       /// psrlq mm2,16
      {0,a,a,a}

      db $0F,$6F,$DE           /// movq mm3,mm6
      db $0F,$F9,$DA           /// psubw mm3,mm2

      db $0F,$D5,$C2           /// pmullw mm0,mm2
       add edi,4;
      db $0F,$D5,$CB           /// pmullw mm1,mm3
      db $0F,$DD,$C1           /// paddusw mm0,mm1

      db $0F,$71,$D0,$08       /// psrlw mm0,8

      db $0F,$67,$C5           /// packuswb mm0,mm5

      db $0F,$7E,$06           /// movd [esi],mm0
      add esi,4;

      dec eax;
      jne @l;

      db $0F,$77               /// emms
      popad;
    end;
  end
  else
  begin
    asm
      pushad;
      mov esi,PBits;
      mov edi,DBits;
    @l:
      mov eax,[esi];
      mov edx,eax;
      movzx ecx,byte ptr[edi];
      movzx eax,al;
      shr edx,24;
//mov edx,128  Alpha:=50% (test)
      sub eax,ecx;
      imul eax,edx;
      shl ecx,8;
      add eax,ecx;
      mov byte ptr[esi],ah;

      movzx eax,byte ptr[esi+1];
      movzx ecx,byte ptr[edi+1];
      sub eax,ecx;
      imul eax,edx;
      shl ecx,8;
      add eax,ecx;
      mov byte ptr[esi+1],ah;

      movzx eax,byte ptr[esi+2];
      movzx ecx,byte ptr[edi+2];
      sub eax,ecx;
      imul eax,edx;
      shl ecx,8;
      add eax,ecx;

      shr eax,8;
      mov [esi+2],ax;

      add esi,4;
      add edi,4;

      dec n;
      jne @l;
      popad;
    end;
  end;
end;

function AlphaBlendProc(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  Func: BLENDFUNCTION): longbool; stdcall;
var
  TmpBitmap, DstBitmap: TBitmap;
  PBits, DBits: pointer;
  I: integer;
begin
  TmpBitmap:=TBitmap.Create;
  try
    TmpBitmap.PixelFormat:=pf32Bit;
    TmpBitmap.Width:=SrcW;
    TmpBitmap.Height:=SrcH;
    DstBitmap:=TBitmap.Create;
    try
      DstBitmap.PixelFormat:=pf32Bit;
      DstBitmap.Width:=SrcW;
      DstBitmap.Height:=SrcH;
      BitBlt(TmpBitmap.Canvas.Handle, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
      BitBlt(DstBitmap.Canvas.Handle, 0, 0, SrcW, SrcH, DestDC, X, Y, SRCCOPY);
      for I := 0 to SrcH - 1 do
      begin
        PBits := TmpBitmap.ScanLine[I];
        DBits := DstBitmap.ScanLine[I];
        MakeAlpha(PBits, DBits, SrcW);
      end;
      BitBlt(DestDC, X, Y, SrcW, SrcH, TmpBitmap.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      DstBitmap.Free;
    end;
  finally
    TmpBitmap.Free;
  end;
  Result := True;
end;

procedure StretchBitmap(SrcBmp, DstBmp: TBitmap);
var
  SrcYM, SrcXMDelta, SrcYMDelta, SrcXMStep, SrcYMStep: integer;
  SrcY1, SrcY2, DstY, WeightY: integer;
  SrcScanLine1, SrcScanLine2, DstPixel: pointer;
  WG: array [0..6] of longword;
  XS, XS0: longword;
  C1, XS1, DTY, YS1: integer;
begin
  XS := DstBmp.Width;
  SrcXMDelta := (SrcBmp.Width * $4000) div DstBmp.Width;
  SrcYMDelta := (SrcBmp.Height * $4000) div DstBmp.Height;

  if SrcXMDelta = $4000 then
    SrcXMStep := 0
  else if SrcXMDelta > $4000 then
    SrcXMStep := SrcXMDelta div 2
  else
    SrcXMStep := $4000;

  if SrcYMDelta = $4000 then
    SrcYMStep := 0
  else if SrcYMDelta > $4000 then
    SrcYMStep := SrcYMDelta div 2
  else
    SrcYMStep := $4000;

  SrcYM := 0;

  XS1 := SrcBmp.Width - 1;
  YS1 := SrcBmp.Height - 1;
  for DstY := 0 to DstBmp.Height - 1 do
  begin
    asm
      mov ecx, SrcYM;
      mov eax, ecx;
      add eax, SrcYMDelta;
      mov SrcYM, eax;
      mov eax, ecx;
      shr eax, 14;
      mov SrcY1, eax;
      mov eax, SrcYMStep;
      add eax, ecx;
      shr eax, 14;
      cmp eax, YS1;
      jbe @l;
      mov eax, YS1;
    @l:
      mov SrcY2, eax;
      and ecx, $3FFF;
      mov WeightY, ecx;
      mov eax, $4000;
      sub eax, WeightY;
      mov C1, eax;
    end;

    SrcScanLine1 := SrcBmp.ScanLine[SrcY1];
    SrcScanLine2 := SrcBmp.ScanLine[SrcY2];
    DstPixel := DstBmp.ScanLine[DstY];

    if UseMMX then
    begin
      asm
        pushad;
        mov eax,dword(SrcScanLine2);
        sub eax,dword(SrcScanLine1);
        mov dty,eax;
        xor esi,esi; {SrcXM}
        db $0F,$EF,$FF           /// pxor mm7,mm7
        mov edi,DstPixel;
        mov eax,SrcScanLine1;
        db $0F,$6E,$C0           /// movd mm0,eax
        mov eax,xs;
        mov xs0,eax;
      @l:
        mov ecx,esi;
        mov ebx,SrcXMStep;
        add ebx,ecx;
        shr ecx,14;    {SrcX1}
        shr ebx,14;    {SrcX2}
        cmp ebx,xs1
        jbe @m;
        mov ebx,xs1;
      @m:
        shl ecx,2;
        shl ebx,2;
        db $0F,$7E,$C0           /// movd eax,mm0
        add ecx,eax;
        add ebx,eax;
        db $0F,$6E,$09           /// movd mm1,[ecx]
        db $0F,$6E,$13           /// movd mm2,[ebx]
        add ecx,dty;
        add ebx,dty;
        db $0F,$60,$CA           /// punpcklbw mm1,mm2
        db $0F,$6E,$19           /// movd mm3,[ecx]
        db $0F,$6F,$D1           /// movq mm2,mm1
        db $0F,$6E,$23           /// movd mm4,[ebx]
        db $0F,$60,$CF           /// punpcklbw mm1,mm7
        db $0F,$60,$DC           /// punpcklbw mm3,mm4
        db $0F,$68,$D7           /// punpckhbw mm2,mm7
        {mm1: g2,g1:b2,b1}
        {mm2: a2,a1:r2,r1}
        mov ebx,esi;
        and ebx,$3FFF;    {WeightX}
        mov ecx,WeightY;
        mov edx,c1;
        mov eax,ebx;
        imul eax,edx;
        db $0F,$6F,$E3           /// movq mm4,mm3
        shr eax,14;     {Weight2}
        sub edx,eax;    {Weight1}
        shl eax,16;
        or eax,edx;
        db $0F,$60,$DF           /// punpcklbw mm3,mm7
        db $0F,$6E,$E8           /// movd mm5,eax
        mov eax,ebx;
        imul eax,ecx;
        db $0F,$62,$ED           /// punpckldq mm5,mm5
        {mm5: W2,W1:W2,W1}
        shr eax,14;     {Weight4}
        sub ecx,eax;    {Weight3}
        shl eax,16;
        or eax,ecx;
        db $0F,$6E,$F0           /// movd mm6,eax
{}
        db $0F,$F5,$CD           /// pmaddwd mm1,mm5
        db $0F,$62,$F6           /// punpckldq mm6,mm6
        {mm6: W4,W3:W4,W3}

        db $0F,$F5,$DE           /// pmaddwd mm3,mm6
        db $0F,$68,$E7           /// punpckhbw mm4,mm7
        {mm3: g4,g3:b4,b3}
        {mm4: a4,a3:r4,r3}
        db $0F,$F5,$D5           /// pmaddwd mm2,mm5
        add esi,SrcXMDelta;
        db $0F,$F5,$E6           /// pmaddwd mm4,mm6

        db $0F,$FE,$CB           /// paddd mm1,mm3
        db $0F,$FE,$D4           /// paddd mm2,mm4

        db $0F,$72,$D1,$0E       /// psrld mm1,14
        db $0F,$72,$D2,$0E       /// psrld mm2,14
        {mm1: g:b}
        {mm3: a:r}
        db $0F,$67,$CA           /// packuswb mm1,mm2
        db $0F,$67,$C9           /// packuswb mm1,mm1
        db $0F,$7E,$0F           /// movd [edi],mm1
        add edi,4;
        dec xs0;
        jne @l;
        popad;
      end;
    end
    else
    begin
      asm
        pushad;
        mov eax,dword(SrcScanLine2);
        sub eax,dword(SrcScanLine1);
        mov dty,eax;
        xor esi,esi; {SrcXM}
        mov edi,DstPixel;
        mov eax,xs;
        mov xs0,eax;
      @l:
{}
        mov ebx,esi;
        and ebx,$3FFF;    {WeightX}
        mov ecx,WeightY;
        mov edx,c1;
        mov eax,ebx;
        imul eax,edx;
        shr eax,14;     {Weight2}
        sub edx,eax;    {Weight1}
        mov dword ptr wg[16],edx;
        mov dword ptr wg[20],eax;
        mov eax,ebx;
        imul eax,ecx;
        shr eax,14;     {Weight4}
        sub ecx,eax;    {Weight3}
        mov ebx,eax;
        mov dword ptr wg[24],ecx;
{}
        mov ecx,esi;
        mov edx,SrcXMStep;
        add edx,ecx;
        shr ecx,14;    {SrcX1}
        shr edx,14;    {SrcX2}
        cmp edx,xs1
        jbe @m;
        mov edx,xs1;
      @m:
        shl ecx,2;
        shl edx,2;
        mov eax,SrcScanLine1;
        add ecx,eax;
        add edx,eax;
        mov eax,[ecx];
        mov dword ptr wg[0],eax;
        mov eax,[edx];
        mov dword ptr wg[4],eax;
        add ecx,dty;
        add edx,dty;
        mov eax,[ecx];
        mov dword ptr wg[8],eax;
        mov eax,[edx];
        mov dword ptr wg[12],eax;
//pt1
        movzx eax,byte ptr wg[0]
        mov edx,dword ptr wg[16]
        imul eax,edx;
        mov edx,dword ptr wg[20]
        mov ecx,eax;
        movzx eax,byte ptr wg[4]
        imul eax,edx;
        mov edx,dword ptr wg[24]
        add ecx,eax;
        movzx eax,byte ptr wg[8]
        imul eax,edx;
        add ecx,eax;
        movzx eax,byte ptr wg[12]
        imul eax,ebx;
        mov edx,dword ptr wg[16]
        add eax,ecx;
        shr eax,14;
        mov [edi],al;
//pt2
        movzx eax,byte ptr wg[1]
        imul eax,edx;
        mov edx,dword ptr wg[20]
        mov ecx,eax;
        movzx eax,byte ptr wg[5]
        imul eax,edx;
        mov edx,dword ptr wg[24]
        add ecx,eax;
        movzx eax,byte ptr wg[9]
        imul eax,edx;
        add ecx,eax;
        movzx eax,byte ptr wg[13]
        imul eax,ebx;
        mov edx,dword ptr wg[16]
        add eax,ecx;
        shr eax,14;
        mov [edi+1],al;
//pt3
        movzx eax,byte ptr wg[2]
        imul eax,edx;
        mov edx,dword ptr wg[20]
        mov ecx,eax;
        movzx eax,byte ptr wg[6]
        imul eax,edx;
        mov edx,dword ptr wg[24]
        add ecx,eax;
        movzx eax,byte ptr wg[10]
        imul eax,edx;
        add ecx,eax;
        movzx eax,byte ptr wg[14]
        imul eax,ebx;
        mov edx,dword ptr wg[16]
        add eax,ecx;
        shr eax,14;
        mov [edi+2],al;
//pt4
        movzx eax,byte ptr wg[3]
        imul eax,edx;
        mov edx,dword ptr wg[20]
        mov ecx,eax;
        movzx eax,byte ptr wg[7]
        imul eax,edx;
        mov edx,dword ptr wg[24]
        add ecx,eax;
        movzx eax,byte ptr wg[11]
        imul eax,edx;
        add ecx,eax;
        movzx eax,byte ptr wg[15]
        imul eax,ebx;
        add esi,SrcXMDelta;
        add eax,ecx;
        shr eax,14;
        mov [edi+3],al;
        add edi,4;
        dec xs0;
        jne @l;
        popad;
      end;
    end;
  end;
  if UseMMX then
  begin
    asm
      db $0F,$77               /// emms
    end;
  end;
end;

function StretchBltProc(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  Mode: cardinal): longbool; stdcall;
var
  SrcBmp, DstBmp: TBitmap;
begin
  Result := False;
  if (W <= 0) or (H <= 0) or (SrcW <= 0) or (SrcH <= 0) then
    exit;
  if (W = SrcW) and (H = SrcH) then
  begin
    BitBlt(DestDC, X, Y, W, H, SrcDC, SrcX, SrcY, SRCCOPY);
    Result := True;
    exit;
  end;
  SrcBmp := TBitmap.Create;
  try
    SrcBmp.PixelFormat := pf32bit;
    SrcBmp.Width := SrcW;
    SrcBmp.Height := SrcH;
    BitBlt(SrcBmp.Canvas.Handle, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
    DstBmp := TBitmap.Create;
    try
      DstBmp.PixelFormat := pf32bit;
      DstBmp.Width := W;
      DstBmp.Height := H;
      StretchBitmap(SrcBmp, DstBmp);
      BitBlt(DestDC, X, Y, W, H, DstBmp.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      DstBmp.Free;
    end;
  finally
    SrcBmp.Free;
  end;
  Result := True;
end;

function TransparentBltProc(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  TransparentColor: cardinal): longbool; stdcall;
var
  MonoDC: HDC;
  MonoBmp: HBitmap;
  SavedDestDC, SavedSrcDC, SavedMonoDC: integer;
begin
  try
    MonoDC := CreateCompatibleDC(DestDC);
    SavedDestDC := SaveDC(DestDC);
    SavedSrcDC := SaveDC(SrcDC);
    SavedMonoDC := SaveDC(MonoDC);
    SetBkColor(DestDC, RGB(255, 255, 255));
    SetTextColor(DestDC, RGB(0, 0, 0));
    SetBkColor(SrcDC, TransparentColor);
    MonoBmp := CreateBitmap(SrcW, SrcH, 1, 1, nil);
    MonoBmp := SelectObject(MonoDC, MonoBmp);
    BitBlt(MonoDC, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCINVERT);
    BitBlt(DestDC, X, Y, SrcW, SrcH, MonoDC, 0, 0, SRCAND);
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCINVERT);
    MonoBmp := SelectObject(MonoDC, MonoBmp);
    RestoreDC(MonoDC, SavedMonoDC);
    DeleteDC(MonoDC);
    DeleteObject(MonoBmp);
    RestoreDC(SrcDC, SavedSrcDC);
    RestoreDC(DestDC, SavedDestDC);
    Result := True;
  except
    Result := False;
  end;
end;

function SupportsMMX: boolean;
asm
  pushf
  push    ebx
  mov     eax, 1
  db      $0F, $A2        // CPUID
  bt      edx, 23
  jae     @@NOMMX
  mov     @Result, True
  jmp     @@EXIT
@@NOMMX:
  mov     @Result, False
@@EXIT:
  pop     ebx
  popf
end;

var
  hThemesLib: THandle = 0;

procedure InitThemesGraphics;
begin
  AlphaBlend := nil;
  StretchBlt := nil;
  TransparentBlt := nil;
  if IsWin2000Up then
  begin
    StretchBlt := Windows.StretchBlt;
    hThemesLib := SafeLoadLibrary('msimg32.dll');
    if hThemesLib <> 0 then
    begin
      AlphaBlend := TAlphaBlendProc(GetProcAddress(hThemesLib, 'AlphaBlend'));
      TransparentBlt := TTransparentBltProc(GetProcAddress(hThemesLib, 'TransparentBlt'));
      if (@AlphaBlend=nil)and(@TransparentBlt=nil) then
      begin
        FreeLibrary(hThemesLib);
        hThemesLib := 0;
      end;
    end;
  end;
  if @AlphaBlend = nil then
    AlphaBlend := AlphaBlendProc;
  if @StretchBlt = nil then
    StretchBlt := StretchBltProc;
  if @TransparentBlt = nil then
    TransparentBlt := TransparentBltProc;
  UseMMX := SupportsMMX;
end;

procedure DrawRect(DestDC: HDC; X: integer; Y: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  TransparentColor: TColor = clNone);
begin
  if TransparentColor = clNone then
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY)
  else
    TransparentBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SrcW, SrcH, ColorToRGB(TransparentColor));
end;

procedure StretchIcon(Icon: HIcon; DC: HDC; X: integer; Y: integer; W: integer;
  H: integer);
var
  Info: TIconInfo;
  Bmp: Bitmap;
  SrcBmpDC, SrcMskDC: HDC;
  DstBmpDC, DstMskDC: HDC;
  SrcBmpH, SrcMskH: HBitmap;
  DstBmpH, DstMskH: HBitmap;
  OldMskH: HBitmap;
  BH, BW: integer;
begin
  if GetIconInfo(Icon, Info) then
    if GetObject(Info.hbmColor, SizeOf(Bmp), @Bmp) <> 0 then
    begin
      BH := Bmp.bmWidth;
      BW := Bmp.bmHeight;

      SrcBmpDC := CreateCompatibleDC(DC);
      SrcBmpH := SelectObject(SrcBmpDC, Info.hbmColor);
      SrcMskDC := CreateCompatibleDC(DC);
      SrcMskH := SelectObject(SrcMskDC, Info.hbmMask);

      DstBmpDC := CreateCompatibleDC(DC);
      DstBmpH := CreateCompatibleBitmap(DC, W, H);
      DstBmpH := SelectObject(DstBmpDC, DstBmpH);
      DstMskDC := CreateCompatibleDC(DC);
      DstMskH := CreateBitmap(W, H, 1, 1, nil);
      OldMskH := SelectObject(DstMskDC, DstMskH);

      StretchBlt(DstBmpDC, 0, 0, W, H, SrcBmpDC, 0, 0, BW, BH, SRCCOPY);
      StretchBlt(DstMskDC, 0, 0, W, H, SrcMskDC, 0, 0, BW, BH, SRCCOPY);
      MaskBlt(DC, X, Y, W, H, DstBmpDC, 0, 0, DstMskH, 0, 0, MakeROP4(SRCPAINT,
        SRCCOPY));

      DstMskH := SelectObject(DstMskDC, OldMskH);
      DeleteDC(DstMskDC);
      DeleteObject(DstMskH);
      DstBmpH := SelectObject(DstBmpDC, DstBmpH);
      DeleteDC(DstBmpDC);
      DeleteObject(DstBmpH);

      SelectObject(SrcMskDC, SrcMskH);
      DeleteDC(SrcMskDC);
      SelectObject(SrcBmpDC, SrcBmpH);
      DeleteDC(SrcBmpDC);
    end;
end;

procedure StretchRect(DestDC: HDC; X: integer; Y: integer; W: integer;
  H: integer; SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer;
  SrcH: integer; LM: integer; TM: integer; RM: integer; BM: integer;
  TransparentColor: TColor; BorderOnly: boolean);
var
  DC: HDC;
  Bmp: HBitmap;
begin
  DC := CreateCompatibleDC(DestDC);
  Bmp := CreateCompatibleBitmap(DestDC, Abs(W), Abs(H));
  Bmp := SelectObject(DC, Bmp);

  SetStretchBltMode(DC, COLORONCOLOR);

  if (LM = 0) and (TM = 0) and (RM = 0) and (BM = 0) then
    StretchBlt(DC, 0, 0, W, H, SrcDC, SrcX, SrcY, SrcW, SrcH, SRCCOPY)
  else
  begin
    // draw corners
    if (LM > 0) and (TM > 0) then
      BitBlt(DC, 0, 0, LM, TM, SrcDC, SrcX, SrcY, SRCCOPY);
    if (RM > 0) and (TM > 0) then
      BitBlt(DC, W - RM, 0, RM, TM, SrcDC, SrcX + SrcW - RM, SrcY, SRCCOPY);
    if (LM > 0) and (BM > 0) then
      BitBlt(DC, 0, H - BM, LM, BM, SrcDC, SrcX, SrcY + SrcH - BM, SRCCOPY);
    if (RM > 0) and (BM > 0) then
      BitBlt(DC, W - RM, H - BM, RM, BM, SrcDC, SrcX + SrcW - RM, SrcY + SrcH - BM, SRCCOPY);
    // draw sides
    if TM > 0 then
      StretchBlt(DC, LM, 0, W - RM - LM, TM, SrcDC, SrcX + LM, SrcY, SrcW - RM - LM, TM, SRCCOPY);
    if BM > 0 then
      StretchBlt(DC, LM, H - BM, W - RM - LM, BM, SrcDC, SrcX + LM, SrcY + SrcH - BM, SrcW - RM - LM, BM, SRCCOPY);
    if LM > 0 then
      StretchBlt(DC, 0, TM, LM, H - TM - BM, SrcDC, SrcX, SrcY + TM, LM, SrcH - TM - BM, SRCCOPY);
    if RM > 0 then
      StretchBlt(DC, W - RM, TM, RM, H - TM - BM, SrcDC, SrcX + SrcW - RM, SrcY + TM, RM, SrcH - TM - BM, SRCCOPY);
    // draw inner area if needed
    if not BorderOnly and (W - RM - LM > 0) and (H - BM - TM > 0) then
      StretchBlt(DC, LM, TM, W - RM - LM, H - BM - TM,
        SrcDC, SrcX + LM, SrcY + TM, SrcW - RM - LM, SrcH - BM - TM, SRCCOPY);
  end;

  if TransparentColor = clNone then
    BitBlt(DestDC, X, Y, W, H, DC, 0, 0, SRCCOPY)
  else
    TransparentBlt(DestDC, X, Y, W, H, DC, 0, 0, W, H, ColorToRGB(TransparentColor));
  Bmp := SelectObject(DC, Bmp);
  if Bmp <> 0 then
    DeleteObject(Bmp);
  DeleteDC(DC);
end;

procedure TileRect(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  LM: integer; TM: integer; RM: integer; BM: integer;
  TransparentColor: TColor = clNone; BorderOnly: boolean = False);
var
  DC: HDC;
  Bmp: HBitmap;
  L, T, CW, CH, SW, SH, TW, TH: integer;
  I, J: integer;
  Brush: HBrush;
begin
  DC := CreateCompatibleDC(DestDC);
  Bmp := CreateCompatibleBitmap(DestDC, Abs(W), Abs(H));
  Bmp := SelectObject(DC, Bmp);

  if (LM > 0) or (TM > 0) or (RM > 0) or (BM > 0) then
  begin
    // draw corners
    if (LM > 0) and (TM > 0) then
      BitBlt(DC, 0, 0, LM, TM, SrcDC, SrcX, SrcY, SRCCOPY);
    if (RM > 0) and (TM > 0) then
      BitBlt(DC, W - RM, 0, RM, TM, SrcDC, SrcX + SrcW - RM, SrcY, SRCCOPY);
    if (LM > 0) and (BM > 0) then
      BitBlt(DC, 0, H - BM, LM, BM, SrcDC, SrcX, SrcY + SrcH - BM, SRCCOPY);
    if (RM > 0) and (BM > 0) then
      BitBlt(DC, W - RM, H - BM, RM, BM, SrcDC, SrcX + SrcW - RM, SrcY + SrcH -
        BM, SRCCOPY);
    // draw sides
    if (TM > 0) or (BM > 0) then
    begin
      L := LM;
      SW := SrcW - LM - RM;
      TW := W - RM;
      CW := (TW - L) div SW;
      if (TW - L) mod SW > 0 then Inc(CW);
      for I := 0 to CW - 1 do
      begin
        if L + SW > TW then SW := TW - L;
        if TM > 0 then
          BitBlt(DC, L, 0, SW, TM, SrcDC, SrcX + LM, SrcY, SRCCOPY);
        if BM > 0 then
          BitBlt(DC, L, H - BM, SW, BM, SrcDC, SrcX + LM, SrcY + SrcH - BM, SRCCOPY);
        Inc(L, SW);
      end;
    end;
    if (LM > 0) or (RM > 0) then
    begin
      T := TM;
      SH := SrcH - TM - BM;
      TH := H - BM;
      CH := (TH - T) div SH;
      if (TH - T) mod SH > 0 then Inc(CH);
      for I := 0 to CH - 1 do
      begin
        if T + SH > TH then SH := TH - T;
        if LM > 0 then
          BitBlt(DC, 0, T, LM, SH, SrcDC, SrcX, SrcY + TM, SRCCOPY);
        if RM > 0 then
          BitBlt(DC, W - RM, T, RM, SH, SrcDC, SrcX + SrcW - RM, SrcY + TM, SRCCOPY);
        Inc(T, SH);
      end;
    end;
  end;
  // draw inner area if needed
  if (W - RM - LM > 0) and (H - TM - BM > 0) then
    if BorderOnly then
    begin
      if TransparentColor = clNone then
        BitBlt(DC, LM, TM, W - RM - LM, H - BM - TM, DestDC, X + LM, Y + TM, SRCCOPY)
      else
      begin
        Brush := CreateSolidBrush(ColorToRGB(TransparentColor));
        Brush := SelectObject(DC, Brush);
        FillRect(DC, Classes.Rect(LM, TM, W - RM, H - BM), 0);
        Brush := SelectObject(DC, Brush);
        if Brush <> 0 then
          DeleteObject(Brush);
      end;
    end
    else
    begin
      L := LM;
      SW := SrcW - LM - RM;
      TW := W - RM;
      CW := (TW - L) div SW;
      if (TW - L) mod SW > 0 then Inc(CW);
      T := TM;
      SH := SrcH - TM - BM;
      TH := H - BM;
      CH := (TH - T) div SH;
      if (TH - T) mod SH > 0 then Inc(CH);
      for I := 0 to CH - 1 do
      begin
        L := LM;
        if T + SH > TH then SH := TH - T;
        for J := 0 to CW - 1 do
        begin
          if L + SW > TW then SW := TW - L;
          BitBlt(DC, L, T, SW, SH, SrcDC, SrcX + LM, SrcY + TM, SRCCOPY);
          Inc(L, SW);
        end;
        SW := SrcW - LM - RM;
        Inc(T, SH);
      end;
    end;

  if TransparentColor = clNone then
    BitBlt(DestDC, X, Y, W, H, DC, 0, 0, SRCCOPY)
  else
    TransparentBlt(DestDC, X, Y, W, H, DC, 0, 0, W, H, ColorToRGB(TransparentColor));
  Bmp := SelectObject(DC, Bmp);
  if Bmp <> 0 then
    DeleteObject(Bmp);
  DeleteDC(DC);
end;

procedure AlphaDrawRect(DestDC: HDC; X: integer; Y: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer);
var
  Blend: BLENDFUNCTION;
begin
  Blend.BlendOp := AC_SRC_OVER;
  Blend.BlendFlags := 0;
  Blend.SourceConstantAlpha := 255;
  Blend.AlphaFormat := $01;
  AlphaBlend(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SrcW, SrcH, Blend);
end;

procedure AlphaStretchRect(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
  LM: integer; TM: integer; RM: integer; BM: integer; BorderOnly: boolean);
var
  TmpBitmap: TBitmap;
  Blend: BLENDFUNCTION;
begin
  TmpBitmap := TBitmap.Create;
  try
    TmpBitmap.PixelFormat := pf32Bit;
    TmpBitmap.Width := W;
    TmpBitmap.Height := H;
    if (W = SrcW) and (H = SrcH) then
      BitBlt(TmpBitmap.Canvas.Handle, 0, 0, W, H, SrcDC, SrcX, SrcY, SRCCOPY)
    else
      StretchRect(TmpBitmap.Canvas.Handle, 0, 0, W, H, SrcDC, SrcX, SrcY,
        SrcW, SrcH, LM, TM, RM, BM, clNone, BorderOnly);
    Blend.BlendOp := AC_SRC_OVER;
    Blend.BlendFlags := 0;
    Blend.SourceConstantAlpha := 255;
    Blend.AlphaFormat := $01;
    AlphaBlend(DestDC, X, Y, W, H, TmpBitmap.Canvas.Handle, 0, 0, W, H, Blend);
  finally
    TmpBitmap.Free;
  end;
end;

procedure FixAlphaImage(Image: TBitmap);
var
  I, J: integer;
  P: PColorRGB;
begin
  if not IsWin2000Up or IsAlphaEmpty(Image) then
    exit;
  for J := 0 to Image.Height - 1 do
  begin
    P := Image.ScanLine[J];
    for I := 0 to Image.Width - 1 do
    begin
      P.R := (P.R * P.A) div 255;
      P.G := (P.G * P.A) div 255;
      P.B := (P.B * P.A) div 255;
      Inc(P);
    end;
  end;
end;

initialization
  UseMMX := False;
  try
    InitThemesGraphics;
    if UseMMX then
    asm
      db    $0F,$EF,$C0     // pxor mm0,mm0
      db    $0F,$77         // emms
    end;
  except
    UseMMX:=false;
  end;

finalization
  if hThemesLib<>0 then
    FreeLibrary(hThemesLib);

{$ENDIF}

end.
