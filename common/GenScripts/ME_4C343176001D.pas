unit K224134476;

interface

uses
 l3IntfUses
 , ComplexScrollByLines
 , nevTools
;

type
 TK224134476 = class(TComplexScrollByLines)
  {* [$224134476] }
  function GetScrollLineCount2Down: Integer;
   {* количество строк для прокрутки вниз }
  function GetScrollLineCount2Up: Integer;
   {* количество строк для прокрутки вверх }
 end;//TK224134476
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
