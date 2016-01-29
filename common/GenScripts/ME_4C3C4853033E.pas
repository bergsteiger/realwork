unit TwoSpaceForOneReplacerTest;

interface

uses
 l3IntfUses
 , SearchAndReplacePrimTest
 , nevTools
 , evTypes
;

type
 TTwoSpaceForOneReplacerTest = class(TSearchAndReplacePrimTest)
  {* Тест замены одного пробела на один }
  function Searcher: IevSearcher;
  function Replacer: IevReplacer;
  function Options: TevSearchOptionSet;
 end;//TTwoSpaceForOneReplacerTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evSearch
 , TestFrameWork
;

end.
