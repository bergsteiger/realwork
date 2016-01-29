unit evConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evConst.pas"
// Начат: 11.12.96
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evConst
//
// Константы библиотеки Эверест.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Types,
  l3Units,
  l3Const
  ;

const
  { evL3CoreConsts }
 evEpsilon = l3Epsilon;
  { предел точности. }
 evFindCellDelta = l3AlingDelta;
  { Погрешность при поиске одинаковых ячеек. }
 evShapeNil = l3ShapeNil;
  { NULL для координат рисуемых объектов. }
 evUndefHeight = l3ShapeNil;
 evInchMul = l3Inch;
 evCmPerInch = 2.54;
  { сколько сантиметров в дюйме. }
 ev_MmInInch = l3mmInInch;
  { Число миллиметров в дюйме. }
  { evPointConst }
 evPoint0 : Tl3Point = (P: (X: 0; Y: 0));
 Point0 : Tl3SPoint = (P: (X: 0; Y: 0));
 evRect0 : Tl3Rect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 Rect0 : Tl3SRect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 evRect1 : Tl3Rect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
 Rect1 : Tl3SRect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
  { evFontConst }
 evFontIndexDelta = l3FontIndexDelta;
  { смещение строки при верхнем или нижнем индексе. }

{$If not defined(evRunTime)}  { evPageNames }
 evEverestPage = 'Everest Controls';
 evEverestComponentsPage = 'Everest Components';
 evReaders = 'Everest Readers';
 evWriters = 'Everest Writers';
{$IfEnd} //not evRunTime

implementation

end.