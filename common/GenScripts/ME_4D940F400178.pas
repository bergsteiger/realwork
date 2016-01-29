unit K259175668;

interface

uses
 l3IntfUses
 , WrongSearchTest
;

type
 TK259175668 = class(TWrongSearchTest)
  {* [$259175668] }
  function StringForSearch: AnsiString;
   {* Строка для поиска }
  function StringForReplace: AnsiString;
   {* Строка для замены }
 end;//TK259175668
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
