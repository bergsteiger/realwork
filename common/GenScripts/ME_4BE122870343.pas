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
   {* ������ ��� ������ }
  function StringForReplace: AnsiString;
   {* ������ ��� ������ }
 end;//TK209584437
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
