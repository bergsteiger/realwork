unit ForbidAutoregistration_ut_ForbidAutoregistration_UserType;
 {* ��������� ��������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\ForbidAutoregistration_ut_ForbidAutoregistration_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_ForbidAutoregistration" MUID: (5E9859CE8259)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� ut_ForbidAutoregistration }
 ut_ForbidAutoregistrationName = 'ut_ForbidAutoregistration';
  {* ��������� ������������� ����������������� ���� "��������� ���������������" }
 ut_ForbidAutoregistration = TvcmUserType(0);
  {* ��������� ��������������� }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_ForbidAutoregistration = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_ForbidAutoregistration }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_ForbidAutoregistration
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_ForbidAutoregistration.GetInteger: Integer;
begin
 Result := ut_ForbidAutoregistration;
end;//Tkw_FormUserType_ut_ForbidAutoregistration.GetInteger

class function Tkw_FormUserType_ut_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_ForbidAutoregistration';
end;//Tkw_FormUserType_ut_ForbidAutoregistration.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_ForbidAutoregistration.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_ForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
