unit K208701762;

interface

uses
 l3IntfUses
 , SearchAndReplaceTest
;

type
 TK208701762 = class(TSearchAndReplaceTest)
  {* [RequestLink:208701762] }
  function StringForSearch: AnsiString;
   {* ������ ��� ������ }
  function StringForReplace: AnsiString;
   {* ������ ��� ������ }
 end;//TK208701762
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
