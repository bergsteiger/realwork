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
   {* ������ ��� ������ }
  function StringForReplace: AnsiString;
   {* ������ ��� ������ }
 end;//TK259175668
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
