unit l3MemorySizeUtilsPrim;

interface

uses
 l3IntfUses
;

type
 Tl3MemorySizeFunc = function(aPtr: Pointer): Integer;
  {* �������� ������� ��� ��������� ������� ����� ������ }
 
implementation

uses
 l3ImplUses
 , l3MemorySizeUtils
;

end.
