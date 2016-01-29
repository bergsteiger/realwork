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
  {* Тест поиска/замены }
  function StringForSearch: AnsiString;
   {* Строка для поиска }
  function StringForReplace: AnsiString;
   {* Строка для замены }
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
