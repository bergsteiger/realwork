unit SelfInfo_ut_SelfInfo_UserType;
 {* ��������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_ut_SelfInfo_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_SelfInfo" MUID: (2A1D3736B42C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ ut_SelfInfoLocalConstants }
 str_ut_SelfInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_SelfInfoCaption'; rValue : '��������������� ������');
  {* ��������� ����������������� ���� "��������������� ������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_SelfInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_SelfInfo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_SelfInfo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_SelfInfo.GetInteger: Integer;
begin
 Result := ut_SelfInfo;
end;//Tkw_FormUserType_ut_SelfInfo.GetInteger

class function Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_SelfInfo';
end;//Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_SelfInfoCaption.Init;
 {* ������������� str_ut_SelfInfoCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_SelfInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
