unit K224788868;

interface

uses
 l3IntfUses
 , SearchAndReplaceTest
;

type
 TK224788868 = class(TSearchAndReplaceTest)
  {* [RequestLink:224788868] }
  function StringForSearch: AnsiString;
   {* Строка для поиска }
  function StringForReplace: AnsiString;
   {* Строка для замены }
 end;//TK224788868
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
