unit evConst;
 {* Константы библиотеки Эверест. }

// Модуль: "w:\common\components\gui\Garant\Everest\evConst.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Units
;

const
 evEpsilon = l3Epsilon;
  {* предел точности. }
 evFindCellDelta = l3AlingDelta;
  {* Погрешность при поиске одинаковых ячеек. }
 evShapeNil = l3ShapeNil;
  {* NULL для координат рисуемых объектов. }
 evUndefHeight = l3ShapeNil;
 evInchMul = l3Inch;
 evCmPerInch = 2.54;
  {* сколько сантиметров в дюйме. }
 ev_MmInInch = l3mmInInch;
  {* Число миллиметров в дюйме. }
 evPoint0: Tl3Point = (P: (X: 0; Y: 0));
 Point0: Tl3SPoint = (P: (X: 0; Y: 0));
 evRect0: Tl3Rect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 Rect0: Tl3SRect = (R: (Left: 0; Top: 0; Right: 0; Bottom: 0));
 evRect1: Tl3Rect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
 Rect1: Tl3SRect = (R: (Left: 0; Top: 0; Right: 1; Bottom: 1));
 evFontIndexDelta = l3FontIndexDelta;
  {* смещение строки при верхнем или нижнем индексе. }
{$If NOT Defined(evRunTime)}
 evEverestPage = 'Everest Controls';
 evEverestComponentsPage = 'Everest Components';
 evReaders = 'Everest Readers';
 evWriters = 'Everest Writers';
{$IfEnd} // NOT Defined(evRunTime)

implementation

uses
 l3ImplUses
;

end.
