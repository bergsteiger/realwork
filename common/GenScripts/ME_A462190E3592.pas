unit CompInfo_ut_CompInfo_UserType;
 {* ���������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_ut_CompInfo_UserType.pas"
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
 {* ��������� ��� ���� ����� ut_CompInfo }
 ut_CompInfoName = 'ut_CompInfo';
  {* ��������� ������������� ����������������� ���� "���������� � ���������" }
 ut_CompInfo = TvcmUserType(0);
  {* ���������� � ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CompInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_CompInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_CompInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_CompInfo';
end;//Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CompInfo.GetInteger: Integer;
begin
 Result := ut_CompInfo;
end;//Tkw_FormUserType_ut_CompInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CompInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_CompInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
