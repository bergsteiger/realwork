unit ExcludedTestsFolders;

interface

uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTestsFolders = class(Tl3StringList)
  {* ����� ������ ����������� �� ������� }
  function Exists: Boolean;
 end;//TExcludedTestsFolders
 
implementation

uses
 l3ImplUses
;

end.
