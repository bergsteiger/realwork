unit m3NewVersionStream;
 {* �����, ��������� ����� ������ ��������� }

// ������: "w:\common\components\rtl\Garant\m3\m3NewVersionStream.pas"
// ���������: "SimpleClass"
// ������� ������: "Tm3NewVersionStream" MUID: (49BFE43D019F)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3DBProxyWriteStream
;

type
 Tm3NewVersionStream = class(Tm3DBProxyWriteStream)
  {* �����, ��������� ����� ������ ��������� }
  protected
   function pm_GetIsNewVersion: Boolean; override;
 end;//Tm3NewVersionStream

implementation

uses
 l3ImplUses
;

function Tm3NewVersionStream.pm_GetIsNewVersion: Boolean;
//#UC START# *49BFE6600304_49BFE43D019Fget_var*
//#UC END# *49BFE6600304_49BFE43D019Fget_var*
begin
//#UC START# *49BFE6600304_49BFE43D019Fget_impl*
 Result := true;
//#UC END# *49BFE6600304_49BFE43D019Fget_impl*
end;//Tm3NewVersionStream.pm_GetIsNewVersion

end.
