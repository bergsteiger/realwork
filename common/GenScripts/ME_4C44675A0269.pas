unit ExcludedTests;

interface

uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTests = class(Tl3StringList)
  {* �����, ������� �� ���� ��������� - [$227477825]. }
  function Exists: Boolean;
   {* ���������� ������ �� ��������� ���������� }
 end;//TExcludedTests
 
implementation

uses
 l3ImplUses
;

end.
