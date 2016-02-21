unit PrimNavigator_utNavigator_UserType;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigator_utNavigator_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utNavigator }
 utNavigatorName = 'utNavigator';
  {* ��������� ������������� ����������������� ���� "����" }
 utNavigator = TvcmUserType(0);
  {* ���� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utNavigator = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utNavigator
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utNavigator';
end;//Tkw_FormUserType_utNavigator.GetWordNameForRegister

function Tkw_FormUserType_utNavigator.GetInteger: Integer;
begin
 Result := utNavigator;
end;//Tkw_FormUserType_utNavigator.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utNavigator.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
