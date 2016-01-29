unit K218824755;

interface

uses
 l3IntfUses
 , ComplexScrollByLines
 , nevTools
;

type
 TK218824755 = class(TComplexScrollByLines)
  {* [RequestLink:218824755] }
  function GetScrollLineCount2Down: Integer;
   {* количество строк для прокрутки вниз }
  function GetScrollLineCount2Up: Integer;
   {* количество строк для прокрутки вверх }
 end;//TK218824755
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
