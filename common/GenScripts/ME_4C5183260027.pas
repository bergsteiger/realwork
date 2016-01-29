unit K229213001;

interface

uses
 l3IntfUses
 , SearchAndReplaceTest
;

type
 TK229213001 = class(TSearchAndReplaceTest)
  {* [RequestLink:229213001] }
  function StringForSearch: AnsiString;
   {* Строка для поиска }
  function StringForReplace: AnsiString;
   {* Строка для замены }
 end;//TK229213001
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
