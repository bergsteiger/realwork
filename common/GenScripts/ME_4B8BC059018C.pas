unit l3StringMap;

interface

uses
 l3IntfUses
 , l3StringMapPrim
 , l3KeyWrd
;

 {$Define l3Items_NeedsBeforeFreeItem}
 
 {$Undef l3Items_NoSort}
 
type
 Tl3StringMap = class(Tl3StringMapPrim)
  function ResolveString(const aString: AnsiString): Integer;
   {* ���������� ������������� ������ }
 end;//Tl3StringMap
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
;

end.
