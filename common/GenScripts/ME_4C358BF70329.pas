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
   {* ������ ��� ������ }
  function StringForReplace: AnsiString;
   {* ������ ��� ������ }
 end;//TK224788868
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
