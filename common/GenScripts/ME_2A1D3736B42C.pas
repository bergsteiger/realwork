unit SelfInfo_ut_SelfInfo_UserType;
 {* ��������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_ut_SelfInfo_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� ut_SelfInfo }
 ut_SelfInfoName = 'ut_SelfInfo';
  {* ��������� ������������� ����������������� ���� "��������������� ������" }
 ut_SelfInfo = TvcmUserType(0);
  {* ��������������� ������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_SelfInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_SelfInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_SelfInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_SelfInfo';
end;//Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_SelfInfo.GetInteger: Integer;
begin
 Result := ut_SelfInfo;
end;//Tkw_FormUserType_ut_SelfInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_SelfInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
