unit evInterface;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3Variant
 , nevBase
;

type
 TevInterface = class(Tl3CacheableBase)
  {* ������� ���� ��� ������������ ���������� � ������ }
  procedure Changing;
  procedure ChangedEx(aCancel: Boolean);
  function IsDefault: Boolean;
 end;//TevInterface
 
implementation

uses
 l3ImplUses
;

end.
