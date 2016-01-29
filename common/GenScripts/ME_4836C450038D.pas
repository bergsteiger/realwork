unit evSimpleTextPainter;

interface

uses
 l3IntfUses
 , evCustomTextFormatter
 , k2Base
 , k2DocumentGenerator
 , l3Variant
;

type
 TevSimpleTextPainter = class(TevCustomTextFormatter)
  {* Класс для раскраски строк текста. Без нарезки на строки. И без форматирования таблиц в псевдографику. Для решения задачи [$91848978]. }
  function OpenTableIfNeeded: Boolean;
  function NeedTranslateToNext(const anAtom: Tk2StackAtom): Boolean;
 end;//TevSimpleTextPainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , TextPara_Const
 , Document_Const
 , ObjectSegment_Const
 , TableCell_Const
 , Table_Const
 , evParaTools
 , k2Facade
 , l3CustomString
 , evNSRCConst
 , l3String
 , l3Chars
 , SBS_Const
 , k2Interfaces
;

end.
