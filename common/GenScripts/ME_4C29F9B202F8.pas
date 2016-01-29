unit K165512428;

interface

uses
 l3IntfUses
 , SearchAndReplacePrimTest
 , nevTools
 , evTypes
;

type
 TK165512428 = class(TSearchAndReplacePrimTest)
  {* [RequestLink:165512428] }
  function Searcher: IevSearcher;
  function Replacer: IevReplacer;
  function Options: TevSearchOptionSet;
 end;//TK165512428
 
implementation

uses
 l3ImplUses
 , evSearch
 , TestFrameWork
;

end.
