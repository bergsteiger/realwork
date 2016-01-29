unit SearchAndReplaceTest;

interface

uses
 l3IntfUses
 , SearchAndReplacePrimTest
 , nevTools
 , evTypes
;

type
 TSearchAndReplaceTest = class(TSearchAndReplacePrimTest)
  {* ���� ������/������ }
  function StringForSearch: AnsiString;
   {* ������ ��� ������ }
  function StringForReplace: AnsiString;
   {* ������ ��� ������ }
  function Searcher: IevSearcher;
  function Replacer: IevReplacer;
  function Options: TevSearchOptionSet;
 end;//TSearchAndReplaceTest
 
implementation

uses
 l3ImplUses
 , evSearch
 , TestFrameWork
;

end.
