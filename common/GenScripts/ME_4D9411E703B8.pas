unit WrongSearchTest;

interface

uses
 l3IntfUses
 , SearchAndReplaceTest
 , nevTools
 , evTypes
 , PrimTextLoad_Form
;

type
 TWrongSearchTest = class(TSearchAndReplaceTest)
  {* Поиск строки не должен проходить. }
 end;//TWrongSearchTest
 
implementation

uses
 l3ImplUses
 , evExcept
 , TestFrameWork
;

end.
