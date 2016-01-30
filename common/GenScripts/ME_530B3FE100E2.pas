unit k2MemoryStream;

// ������: "w:\common\components\rtl\Garant\K2\k2MemoryStream.pas"
// ���������: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3Memory
 , k2Interfaces
;

type
 Tk2MemoryStream = class(Tl3MemoryStream, Ik2RawData)
  protected
   function pm_GetIsModified: Boolean;
 end;//Tk2MemoryStream

implementation

uses
 l3ImplUses
;

function Tk2MemoryStream.pm_GetIsModified: Boolean;
//#UC START# *49A67D980375_530B3FE100E2get_var*
//#UC END# *49A67D980375_530B3FE100E2get_var*
begin
//#UC START# *49A67D980375_530B3FE100E2get_impl*
// Result := false;
 Result := true;
 // - ����� �� ������� Archi �������, ��� �������� ���, ��� ��� �� ����������
//#UC END# *49A67D980375_530B3FE100E2get_impl*
end;//Tk2MemoryStream.pm_GetIsModified

end.
