unit ExcludedTests;

interface

uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTests = class(Tl3StringList)
  {* Тесты, которые не надо запускать - [$227477825]. }
  function Exists: Boolean;
   {* Определяет создан ли экземпляр синглетона }
 end;//TExcludedTests
 
implementation

uses
 l3ImplUses
;

end.
