unit TwoEmptyParaForOneReplacerTest;

interface

uses
 l3IntfUses
 , SearchAndReplacePrimTest
 , nevTools
 , evTypes
;

type
 TTwoEmptyParaForOneReplacerTest = class(TSearchAndReplacePrimTest)
  {* ���� ������ ���� ������ ������� �� ���� }
  function Searcher: IevSearcher;
  function Replacer: IevReplacer;
  function Options: TevSearchOptionSet;
 end;//TTwoEmptyParaForOneReplacerTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evSearch
 , TestFrameWork
;

end.
