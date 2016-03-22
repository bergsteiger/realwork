unit l3CanvasUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3CanvasUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3Canvas::l3CanvasUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  Types,
  Graphics,
  Windows
  ;

type
 TRGB = packed record
   R : Byte;
   G : Byte;
   B : Byte;
 end;//TRGB

 THSV = packed record
   H : Integer;
   S : Integer;
   V : Integer;
 end;//THSV

 TYIQ = packed record
   Y : Integer;
   I : Integer;
   Q : Integer;
 end;//TYIQ

 {$Define UseHSV}
function ApplyLineSpacing(aValue: Integer;
  aLineSpacing: Integer): Integer;
procedure SystemTextExtent(aDC: hDC;
  const aStr: Tl3WString;
  var theExtent: TSize;
  aLineSpacing: Integer);
procedure CheckColors(var aFore: TColor;
  var aBack: TColor);
procedure CheckColorsHSV(var aFore: TColor;
  var aBack: TColor);
procedure CheckColorsYIQ(var aFC: TColor;
  var aBC: TColor;
  aDeltaY: Byte = 100);
procedure HSV2RGB(out px: TRGB;
  const HSV: THSV);
function L3CharsToInch(aCount: Integer;
  aFontSize: Integer): Integer;
procedure RGB2HSV(const RGB: TRGB;
  out HSV: THSV);
procedure RGB2YIQ(const RGB: TRGB;
  out YIQ: TYIQ);
procedure YIQ2RGB(out RGB: TRGB;
  const YIQ: TYIQ);
function InvertColor(aColor: TColor): TColor;

implementation

uses
  l3Math,
  l3MinMax,
  l3InternalInterfaces,
  l3ScreenIC,
  l3String
  ;

// unit methods

function ApplyLineSpacing(aValue: Integer;
  aLineSpacing: Integer): Integer;
//#UC START# *56AB78E40273_56AB78880104_var*
//#UC END# *56AB78E40273_56AB78880104_var*
begin
//#UC START# *56AB78E40273_56AB78880104_impl*
 if (aLineSpacing > 0) AND (aLineSpacing <> 100) then
  Result := l3MulDiv(aValue, aLineSpacing, 100)
 else
  Result := aValue;
//#UC END# *56AB78E40273_56AB78880104_impl*
end;//ApplyLineSpacing

procedure SystemTextExtent(aDC: hDC;
  const aStr: Tl3WString;
  var theExtent: TSize;
  aLineSpacing: Integer);
//#UC START# *56AB792702C4_56AB78880104_var*
//#UC END# *56AB792702C4_56AB78880104_var*
begin
//#UC START# *56AB792702C4_56AB78880104_impl*
 if (aStr.SCodePage = CP_Unicode) then
  Windows.GetTextExtentPoint32W(aDC, PWideChar(aStr.S), aStr.SLen, theExtent)
 else
  Windows.GetTextExtentPoint32A(aDC, aStr.S, aStr.SLen, theExtent);
 theExtent.cY := ApplyLineSpacing(theExtent.cY, aLineSpacing);
//#UC END# *56AB792702C4_56AB78880104_impl*
end;//SystemTextExtent

procedure CheckColors(var aFore: TColor;
  var aBack: TColor);
//#UC START# *56AB7A760174_56AB78880104_var*
const
 l_Add = 170;
 l_Gray = 384; // clGray;
var
 l_F1: TRGB absolute aFore;
 l_B1: TRGB absolute aBack;
 {$IfNDef UseHSV}
 l_F: Integer;
 l_B: Integer;
 {$EndIf UseHSV}
//#UC END# *56AB7A760174_56AB78880104_var*
begin
//#UC START# *56AB7A760174_56AB78880104_impl*
 {$IfDef UseHSV}
 CheckColorsHSV(aFore, aBack);
 {$Else  UseHSV}
 aBack := ColorToRGB(aBack);
 aFore := ColorToRGB(aFore);
 with l_B1 do
  l_B := b + g + r;
 with l_F1 do
  l_F := b + g + r;

 if (l_B <= l_Gray) and
    (l_B * 1.3 >= l_F) then
 begin //Светлим шрифт
  with l_F1 do
  begin
   b := Min(b + l_Add, 255);
   g := Min(g + l_Add, 255);
   r := Min(r + l_Add, 255);
  end;//with l_F1
 end//l_B <= l_Gray
 else
 if (l_B > l_Gray) and
    (l_F * 1.3 >= l_B) then
 begin  //темним шрифт
  with l_F1 do
  begin
   b := Max(b - l_Add, 0);
   g := Max(g - l_Add, 0);
   r := Max(r - l_Add, 0);
  end;//with l_F1
 end;//l_B > l_Gray..
 {$EndIf UseHSV}
//#UC END# *56AB7A760174_56AB78880104_impl*
end;//CheckColors

procedure CheckColorsHSV(var aFore: TColor;
  var aBack: TColor);
//#UC START# *56AB7B600252_56AB78880104_var*
var
 l_F1: TRGB absolute aFore;
 l_B1: TRGB absolute aBack;
 l_F: THSV;
 l_B: THSV;
 l_Diff: Integer;
 l_Delta: Integer;
 l_Border: Integer;
//#UC END# *56AB7B600252_56AB78880104_var*
begin
//#UC START# *56AB7B600252_56AB78880104_impl*
 aBack := ColorToRGB(aBack);
 aFore := ColorToRGB(aFore);
 RGB2HSV(l_F1, l_F);
 RGB2HSV(l_B1, l_B);
 if (Abs(l_F.H - l_B.H) < 30) then
 begin
  l_Border := 50;
  l_Delta := 40;
 end
 else
 begin
  l_Border := 30;
  l_Delta := 30;
 end;//Abs(l_F.H - l_B.H) < 30
 l_Diff := l_F.V - l_B.V;
 if (Abs(l_Diff) < l_Border) then
 begin
  if (l_Diff < 0) then
  begin
   Dec(l_F.V, l_Delta);
   if (l_F.V < 0) then
    Inc(l_F.V, 99);
  end//l_Diff < 0
  else
  begin
   Inc(l_F.V, l_Delta);
   if (l_F.V > 99) then
    Dec(l_F.V, 99);
  end;//l_Diff < 0
  HSV2RGB(l_F1, l_F);
 end;//Abs(l_F.V - l_B.V) > l_Border
//#UC END# *56AB7B600252_56AB78880104_impl*
end;//CheckColorsHSV

procedure CheckColorsYIQ(var aFC: TColor;
  var aBC: TColor;
  aDeltaY: Byte = 100);
//#UC START# *56AB7B7C0391_56AB78880104_var*
var
 l_F1: TRGB absolute aFC;
 l_B1: TRGB absolute aBC;
 l_Fyiq: TYIQ;
 l_Byiq: TYIQ;
 l_Delta: Integer;
//#UC END# *56AB7B7C0391_56AB78880104_var*
begin
//#UC START# *56AB7B7C0391_56AB78880104_impl*
 aFC := ColorToRGB(aFC);
 aBC := ColorToRGB(aBC);

 RGB2YIQ(l_F1, l_Fyiq);
 RGB2YIQ(l_B1, l_Byiq);

 l_Delta := Abs(l_Fyiq.y - l_Byiq.y);
 // Расстояние меньше необходимого
 if (l_Delta < aDeltaY) then
 begin
  if l_Byiq.y - aDeltaY > 0 then
   l_Fyiq.y := l_Byiq.y - aDeltaY
  else
   l_Fyiq.y := l_Byiq.y + aDeltaY;
  YIQ2RGB(l_F1, l_Fyiq);
 end;//l_Delta < aDeltaY
//#UC END# *56AB7B7C0391_56AB78880104_impl*
end;//CheckColorsYIQ

procedure HSV2RGB(out px: TRGB;
  const HSV: THSV);
//#UC START# *56AB7BAE011A_56AB78880104_var*
const
 Divisor: Integer = 99*60;
var
 f     : Integer;
 hTemp : Integer;
 p,q,t : Integer;
 VS    : Integer;
 l_H   : Integer;
 l_S   : Integer;
 l_V   : Integer;
//#UC END# *56AB7BAE011A_56AB78880104_var*
begin
//#UC START# *56AB7BAE011A_56AB78880104_impl*
 // check limits (changed at 2.1.1)
 l_H := HSV.H;
 l_S := HSV.S;
 l_V := HSV.V;     
 if (l_H < 0) then
  l_H := 360 + l_H
 else
 if (l_H > 359) then
  l_H := l_H - 360;
 if (l_S < 0) then
  l_S:=0
 else
 if (l_S > 99) then
  l_S := 99;
 if (l_V < 0) then
  l_V := 0
 else
 if (l_V > 99) then
  l_V := 99;
 //
 if (l_S = 0) then
 begin
   px.r := l_v;
   px.g := l_v;
   px.b := l_v;
 end//l_S = 0
 else
 begin
   IF (l_H = 360) then
     hTemp := 0
   else
     hTemp := l_H;
   f := hTemp mod 60;
   hTemp := hTemp div 60;
   VS := l_V * l_S;
   p := l_V - VS div 99;
   q := l_V - (VS*f) div divisor;
   t := l_V - (VS*(60 - f)) div divisor;
   with px do
   begin
     case hTemp of
       0:  begin  R := l_V;  G := t;  B := p  end;
       1:  begin  R := q;  G := l_V;  B := p  end;
       2:  begin  R := p;  G := l_V;  B := t  end;
       3:  begin  R := p;  G := q;  B := l_V  end;
       4:  begin  R := t;  G := p;  B := l_V  end;
       5:  begin  R := l_V;  G := p;  B := q  end;
     end//case hTemp
   end;//with px
 end;//l_S = 0
 px.r:=round(px.r/99*255);
 px.g:=round(px.g/99*255);
 px.b:=round(px.b/99*255);
//#UC END# *56AB7BAE011A_56AB78880104_impl*
end;//HSV2RGB

function L3CharsToInch(aCount: Integer;
  aFontSize: Integer): Integer;
//#UC START# *56AB7CBA02F1_56AB78880104_var*
const
 def_FontName = 'Arial CYR';  
var
 l_ICN: Il3InfoCanvas;
//#UC END# *56AB7CBA02F1_56AB78880104_var*
begin
//#UC START# *56AB7CBA02F1_56AB78880104_impl*
 l_ICN := l3CrtIC;
 l_ICN.Font.Name := def_FontName;
 l_ICN.Font.Size := aFontSize;
 l_ICN.Font.Style := [];
 l_ICN.Font.Index := l3_fiNone;
 l_ICN.Font.Pitch := fpDefault;
 Result := l_ICN.TextExtent(l3PCharLen('w')).X * aCount;
//#UC END# *56AB7CBA02F1_56AB78880104_impl*
end;//L3CharsToInch

procedure RGB2HSV(const RGB: TRGB;
  out HSV: THSV);
//#UC START# *56AB7CED004F_56AB78880104_var*
 procedure MinMax3(const i,j,k:integer; var min, max:integer);
 begin//MinMax3
   IF i > j then begin
     IF i > k then max := i else max := k;
     IF j < k then min := j else min := k
   end else begin
     IF j > k then max := j else max := k;
     IF i < k then min := i else min := k
   end
 end;//MinMax3

var
 Delta    : integer;
 MinValue : integer;
 r,g,b    : integer;
//#UC END# *56AB7CED004F_56AB78880104_var*
begin
//#UC START# *56AB7CED004F_56AB78880104_impl*
 r:=round( RGB.r/255*99 );
 g:=round( RGB.g/255*99 );
 b:=round( RGB.b/255*99 );
 with HSV do
 begin
  MinMax3(R, G, B, MinValue, V);
  Delta := V - MinValue;
  if V = 0 then
   S := 0
  else
   S := (99 * Delta) div V;
  if S = 0 then
   H := 0
  else
  begin
   if R = V then
    h := (60*(G-B)) div Delta
   else
   if G = V then
    h := 120 + (60*(B-R)) div Delta
   else
   if B = V then
    h := 240 + (60*(R-G)) div Delta;
   if H < 0 then H := H + 360;
  end;//S = 0
 end;//with HSV
//#UC END# *56AB7CED004F_56AB78880104_impl*
end;//RGB2HSV

procedure RGB2YIQ(const RGB: TRGB;
  out YIQ: TYIQ);
//#UC START# *56AB7D0F0094_56AB78880104_var*
//#UC END# *56AB7D0F0094_56AB78880104_var*
begin
//#UC START# *56AB7D0F0094_56AB78880104_impl*
 YIQ.Y := Trunc(0.299*RGB.R + 0.587*RGB.G + 0.114*RGB.B);
 YIQ.I := Trunc(0.596*RGB.R - 0.274*RGB.G - 0.332*RGB.B);
 YIQ.Q := Trunc(0.211*RGB.R - 0.522*RGB.G + 0.311*RGB.B);
//#UC END# *56AB7D0F0094_56AB78880104_impl*
end;//RGB2YIQ

procedure YIQ2RGB(out RGB: TRGB;
  const YIQ: TYIQ);
//#UC START# *56AB7D3500FB_56AB78880104_var*
 function lpByte(aValue : Integer) : Byte;
 begin
  if aValue < 0 then
   Result := 0
  else
   Result := Byte(aValue);
 end;
//#UC END# *56AB7D3500FB_56AB78880104_var*
begin
//#UC START# *56AB7D3500FB_56AB78880104_impl*
 RGB.R := lpByte(Trunc(YIQ.Y + 0.956*YIQ.I + 0.623*YIQ.Q));
 RGB.G := lpByte(Trunc(YIQ.Y - 0.272*YIQ.I - 0.648*YIQ.Q));
 RGB.B := lpByte(Trunc(YIQ.Y - 1.105*YIQ.I + 0.705*YIQ.Q));
//#UC END# *56AB7D3500FB_56AB78880104_impl*
end;//YIQ2RGB

function InvertColor(aColor: TColor): TColor;
//#UC START# *56AD0DB1015A_56AB78880104_var*
var
 r, g, b: integer;
//#UC END# *56AD0DB1015A_56AB78880104_var*
begin
//#UC START# *56AD0DB1015A_56AB78880104_impl*
 aColor := ColorToRgb(aColor);
 r := GetRValue(aColor);
 g := GetGValue(aColor);
 b := GetBValue(aColor);

 r := (not r) and $000000FF;
 g := ((not g) and $000000FF) shl 8;
 b := ((not b) and $000000FF) shl 16;

 Result := b or g or r;
//#UC END# *56AD0DB1015A_56AB78880104_impl*
end;//InvertColor

end.