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
   {* ������ ��� ������ }
  function StringForReplace: AnsiString;
   {* ������ ��� ������ }
 end;//TK229213001
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
