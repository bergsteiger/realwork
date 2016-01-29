unit K219120094;

interface

uses
 l3IntfUses
 , ComplexScrollByLines
 , nevTools
;

type
 TK219120094 = class(TComplexScrollByLines)
  {* [$219120094] }
  function GetScrollLineCount2Down: Integer;
   {* количество строк для прокрутки вниз }
  function GetScrollLineCount2Up: Integer;
   {* количество строк для прокрутки вверх }
 end;//TK219120094
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
