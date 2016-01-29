unit evCustomTextFormatter;

interface

uses
 l3IntfUses
 , evCustomTextFormatterModelPart
;

type
 TevCustomTextFormatter = class(TevCustomTextFormatterModelPart)
  {* Фильтр для форматирования текста по строкам и пребразования таблиц в псевдографику. }
  function NeedAddSpaces: Boolean;
 end;//TevCustomTextFormatter
 
implementation

uses
 l3ImplUses
;

end.
