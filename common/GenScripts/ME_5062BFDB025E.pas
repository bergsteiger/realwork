unit AACSpaceDrawing.imp;

interface

uses
 l3IntfUses
 , l3Units
 , l3Types
 , nevBase
 , l3Variant
;

type
 _AACSpaceDrawing_ = class
  {* Для отрисовки хитрых отступов для AAK }
  function NeedCalcSpace: Boolean;
   {* Проверка для срабатывания примеси. }
  function SpecialFill(const aRect: Tl3Rect;
   aNeedCorrectRight: Boolean): Boolean;
   {* Специальная заливка для хитрых фонов }
  procedure StartDrawingInitFields;
   {* Функция инициализации полей при каждой отрисовке объекта. }
  procedure CorrectByTextHeight(aHeight: Integer);
   {* Корректирует отступ отрисованной высотой текста. }
  procedure CorrectByImageHeight(aHeight: Integer;
   aY: Integer);
   {* Корректирует высотой иконки (в пикселях). }
  procedure InternalDrawFrameText(const aText: Tl3PCharLen;
   aTop: Boolean;
   aSpace: Integer;
   aDecorType: TnevDecorType;
   aDecorObj: Tl3Variant;
   aFirstIndent: Integer);
  function HeaderOwnSpace: Boolean;
  function GetSpaceTop(anInc: Boolean): Integer;
  procedure DoFillEmptyRect(const aRect: Tl3Rect);
 end;//_AACSpaceDrawing_
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , l3String
 , l3Chars
 , l3Const
 , k2Tags
;

end.
