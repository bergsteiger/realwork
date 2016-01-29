unit evSectionPara;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evSectionPara - }
{ Начат: 16.04.2001 15:24 }
{ $Id: evSectionPara.pas,v 1.2 2014/04/04 17:53:38 lulin Exp $ }

// $Log: evSectionPara.pas,v $
// Revision 1.2  2014/04/04 17:53:38  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.1  2009/09/14 11:28:04  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.13  2009/07/10 10:48:25  lulin
// - избавляемся от не очень оптимальных вызовов.
//
// Revision 1.12  2009/06/01 16:07:31  lulin
// [$148574348].
//
// Revision 1.11  2008/11/11 09:01:44  lulin
// - <K>: 114459503.
// - F1 не собиралась.
//
// Revision 1.10  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.7.8.2  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.7.8.1.34.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.7.8.1  2005/05/24 14:50:01  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.7  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.6  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.5  2004/03/26 16:22:27  law
// - new behavior: выливаем команду !DIVISION.
//
// Revision 1.4  2003/04/15 13:26:43  law
// - new unit: evUnits.
//
// Revision 1.3  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.2  2001/04/18 16:44:16  law
// - new behavior: начата работа с параметрами текущего раздела для обеспечения печати на нескольких страницах в ширину.
//
// Revision 1.1  2001/04/16 11:44:41  law
// - new props: к параметрам раздела добавлена высота и ширина бумаги (A0..A5).
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Units,

  k2Interfaces,
  k2Tags,

  evInternalInterfaces,
  evdDOM
  ;

function evGetPaperSize(aParas: Tl3Variant): TevdPaperSize;
  overload;
  {-}
function evGetPaperSize(const aSize: Tl3Point): TevdPaperSize;
  overload;
  {-}
function evGetPaperSizeName(aParas: Tl3Variant): String;
  overload;
  {-}
function evGetPaperSizeName(const aSize: Tl3Point): String;
  overload;
  {-}
function evSectionExtent(aPara: Tl3Variant): Tl3Point;
  { - размеры раздела }

const
  evPageSizes : array [evd_psA0 .. evd_psA5] of Tl3Point =
                (
                 (P: (X: 8400; Y: 11880)), // A0
                 (P: (X: 5940; Y: 8400)),  // A1
                 (P: (X: 4200; Y: 5940)),  // A2
                 (P: (X: 2970; Y: 4200)),  // A3
                 (P: (X: 2100; Y: 2970)),  // A4
                 (P: (X: 1480; Y: 2100))   // A5
                );

implementation

uses
  l3Defaults,
  l3UnitsTools,

  evdTypes,
  
  evDef
  ;

function evGetPaperSize(aParas: Tl3Variant): TevdPaperSize;
  {-}
var
 l_Size     : Tl3Point;
 l_PageSize : TevdPaperSize;
begin
 Result := evd_psCustom;
 l_Size.X := evPixel2Cm(aParas.rLong(k2_tiWidth, def_InchPaperWidth));
 l_Size.Y := evPixel2Cm(aParas.rLong(k2_tiHeight, def_InchPaperHeight));
 for l_PageSize := Low(evPageSizes) to High(evPageSizes) do begin
  with evPageSizes[l_PageSize] do begin
   if (Abs(l_Size.X - X) < 5) AND (Abs(l_Size.Y - Y) < 5) then begin
    Result := l_PageSize;
    break;
   end;//Abs(..
  end;//with evPageSizes[
 end;//for l_PageSize
end;

function evGetPaperSize(const aSize: Tl3Point): TevdPaperSize;
  //overload;
  {-}
var
 l_PageSize : TevdPaperSize;
 l_Size     : Tl3Point;
begin
 Result := evd_psCustom;
 l_Size.X := evPixel2Cm(aSize.X);
 l_Size.Y := evPixel2Cm(aSize.Y);
 for l_PageSize := Low(evPageSizes) to High(evPageSizes) do begin
  with evPageSizes[l_PageSize] do begin
   if (Abs(l_Size.X - X) < 5) AND (Abs(l_Size.Y - Y) < 5) then begin
    Result := l_PageSize;
    break;
   end;//Abs(..
  end;//with evPageSizes[
 end;//for l_PageSize
end;

const
  evPageSizeNames : array [evd_psA0 .. evd_psA5] of String =
                (
                 'A0', // A0
                 'A1', // A1
                 'A2', // A2
                 'A3', // A3
                 'A4', // A4
                 'A5'  // A5
                );

function evGetPaperSizeName(aParas: Tl3Variant): String;
  {-}
var
 l_PageSize : TevdPaperSize;
begin
 l_PageSize := evGetPaperSize(aParas);
 if l_PageSize in [Low(evPageSizeNames) .. High(evPageSizeNames)] then
  Result := evPageSizeNames[l_PageSize]
 else
  Result := 'Custom';
end;

function evGetPaperSizeName(const aSize: Tl3Point): String;
  //overload;
  {-}
var
 l_PageSize : TevdPaperSize;
begin
 l_PageSize := evGetPaperSize(aSize);
 if l_PageSize in [Low(evPageSizeNames) .. High(evPageSizeNames)] then
  Result := evPageSizeNames[l_PageSize]
 else
  Result := 'Custom';
end;

function evSectionExtent(aPara: Tl3Variant): Tl3Point;
  { - размеры раздела }
begin
 with aPara.Attr[k2_tiParas] do
 begin
  if IsValid then
  begin
   if (IntA[k2_tiOrientation] = Ord(ev_poLandscape))
      {AND (Canvas.PageOrientation = l3_poPortrait)} then
   begin
//    l_PageOrientation := l3_poLandscape;
    Result.X := IntA[k2_tiHeight];
    Result.Y := IntA[k2_tiWidth];
   end//IntA[k2_tiOrientation] = Ord(ev_poLandscape)..
   else
   begin
//    l_PageOrientation := l3_poPortrait;
    Result.X := IntA[k2_tiWidth];
    Result.Y := IntA[k2_tiHeight];
   end;//IntA[k2_tiOrientation] = Ord(ev_poLandscape)..
  end//IsValid
  else
  begin
//   l_PageOrientation := l3_poPortrait;
   Result.X := def_inchPaperWidth;
   Result.Y := def_inchPaperHeight;
  end;//IsValid
 end;//with Para.Attr[k2_tiParas]
end;

end.

