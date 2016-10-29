unit ListInfoUserTypes_liListInfo_UserType;
 {* ������� � ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes_liListInfo_UserType.pas"
// ���������: "UserType"
// ������� ������: "liListInfo" MUID: (4BD6B6890245)

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
 {* ������������ ������ liListInfoLocalConstants }
 str_liListInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoCaption'; rValue : '������� � ������');
  {* ��������� ����������������� ���� "������� � ������" }
 str_liListInfoSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'liListInfoSettingsCaption'; rValue : '������: ������� � ������');
  {* ��������� ����������������� ���� "������� � ������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� liListInfo }
 liListInfoName = 'liListInfo';
  {* ��������� ������������� ����������������� ���� "������� � ������" }
 liListInfo = TvcmUserType(0);
  {* ������� � ������ }
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
 Tkw_FormUserType_liListInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� liListInfo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_liListInfo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_liListInfo.GetInteger: Integer;
begin
 Result := liListInfo;
end;//Tkw_FormUserType_liListInfo.GetInteger

class function Tkw_FormUserType_liListInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::liListInfo';
end;//Tkw_FormUserType_liListInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_liListInfoCaption.Init;
 {* ������������� str_liListInfoCaption }
 str_liListInfoSettingsCaption.Init;
 {* ������������� str_liListInfoSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_liListInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_liListInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
