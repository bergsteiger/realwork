unit K209584437;

interface

uses
 l3IntfUses
 , SearchAndReplaceTest
;

type
 TK209584437 = class(TSearchAndReplaceTest)
  {* [RequestLink:209584437] }
  function StringForSearch: AnsiString;
   {* Строка для поиска }
  function StringForReplace: AnsiString;
   {* Строка для замены }
 end;//TK209584437
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
