unit evSBSPar;

{ Библиотека ""         } 
{ Автор: Люлин А.В.     }
{ Модуль: evSBSPar - описание параграфа "Side By Side"}
{ Начат: 11.04.97 19:40 }
{ $Id: evSBSPar.pas,v 1.29 2014/04/04 17:53:34 lulin Exp $ }

// $Log: evSBSPar.pas,v $
// Revision 1.29  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.28  2013/12/19 09:20:23  dinishev
// {Requestlink:509112119}
//
// Revision 1.27  2010/04/12 15:36:59  lulin
// {RequestLink:203129570}.
// - вычистил ненужный метод интерфейса.
//
// Revision 1.26  2008/06/20 14:48:51  lulin
// - используем префиксы элементов.
//
// Revision 1.25  2008/02/12 12:52:59  lulin
// - избавляемся от излишнего метода на базовом классе.
//
// Revision 1.24  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.22.8.3  2007/11/29 11:38:35  dinishev
// Используем единую пачку операций при вставке таблицы
//
// Revision 1.22.8.2  2007/11/28 15:28:13  dinishev
// Используем инструменты для работы с таблицами
//
// Revision 1.22.8.1  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.22.72.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.22  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.21  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.20  2005/03/24 13:14:37  lulin
// - уделена ненужная функция преобразования Tk2AtomR к _Ik2Tag.
//
// Revision 1.19  2005/03/21 06:44:53  lulin
// - убраны ненужные методы.
//
// Revision 1.18  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.17  2002/11/04 08:40:38  law
// - change: новое значение по умолчанию свойства SBSCell.VerticalAligment -> ev_valBottom.
//
// Revision 1.16  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.15  2001/09/21 09:58:54  law
// - cleanup.
//
// Revision 1.14  2001/04/20 14:03:52  law
// - cleanup: def_cm* => def_inch*, evCm2Pixel -> evCm2Inch.
//
// Revision 1.13  2001/01/19 11:45:41  law
// - bug fix: что-то я ошибся при прикручивании VerticalAligment.
//
// Revision 1.12  2001/01/19 11:35:39  law
// - ячейкам параграфа Side By Side сделано выравнивание текста к низу.
//
// Revision 1.11  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  
  k2Interfaces,

  evDef
  ;

function  evSBS_LeftColumn(aSBS: Tl3Variant): Tl3Variant;
  {-}
function  evSBS_RightColumn(aSBS: Tl3Variant): Tl3Variant;
  {-}
function  evSBS_LeftPara(aSBS: Tl3Variant): Tl3Variant;
  {-}
function  evSBS_RightPara(aSBS: Tl3Variant): Tl3Variant;
  {-}
procedure evSBS_Init(aSBS : Tl3Variant;
                         aWidth     : Long = 0);
  {-}

implementation

uses
  l3Units,
  k2Tags,

  evTypes,
  evdStyles,

  nevTools
  ;

function evSBS_LeftPara(aSBS: Tl3Variant): Tl3Variant;
  {-}
begin
 Result := evSBS_LeftColumn(aSBS).Child[0];
end;

function  evSBS_RightPara(aSBS: Tl3Variant): Tl3Variant;
  {-}
begin
 Result := evSBS_RightColumn(aSBS).Child[0];
end;

function evSBS_LeftColumn(aSBS: Tl3Variant): Tl3Variant;
  {-}
begin
 Result := aSBS.Child[0].Child[0];
end;

function evSBS_RightColumn(aSBS: Tl3Variant): Tl3Variant;
  {-}
begin
 Result := aSBS.Child[0].Child[1];
end;

procedure evSBS_Init(aSBS : Tl3Variant;
                     aWidth     : Long = 0);
  {-}
var
 l_Width     : Long;
 l_HalfWidth : Long;
 l_TableTool : InevTable;
begin
 with aSBS do
 begin
  if (aWidth = 0) then 
   aWidth := def_inchSBSWidth;
  //ClearAtoms;
  IntA[k2_tiWidth] := aWidth;
  if aSBS.QT(InevTable, l_TableTool) then
   l_TableTool.AddRow(2, aWidth div 2, False)
  else
   Assert(False, 'Не поддерживается интерфейс InevTable!'); 
  with evSBS_LeftColumn(aSBS) do 
   IntA[k2_tiLeftIndent] := 0;
  with evSBS_RightColumn(aSBS) do 
   IntA[k2_tiLeftIndent] := def_inchSBSIndent;

  l_Width := aWidth - IntA[k2_tiLeftIndent];
  l_HalfWidth := l_Width div 2;
  Child[0].IntA[k2_tiWidth] := l_Width;

  evSBS_LeftColumn(aSBS).IntA[k2_tiWidth] := l_HalfWidth;
  evSBS_RightColumn(aSBS).IntA[k2_tiWidth] := l_HalfWidth;

  evSBS_LeftPara(aSBS).IntA[k2_tiStyle] := ev_saNormalSBSLeft;
  evSBS_RightPara(aSBS).IntA[k2_tiStyle] := ev_saNormalSBSRight;
 end;
end;

end.

