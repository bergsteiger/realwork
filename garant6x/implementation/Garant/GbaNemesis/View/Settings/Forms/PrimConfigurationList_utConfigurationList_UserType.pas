unit PrimConfigurationList_utConfigurationList_UserType;
 {* ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimConfigurationList_utConfigurationList_UserType.pas"
// ���������: "UserType"
// ������� ������: "utConfigurationList" MUID: (4BD727D901FA)

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
 {* ������������ ������ utConfigurationListLocalConstants }
 str_utConfigurationListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListCaption'; rValue : '������������');
  {* ��������� ����������������� ���� "������������" }
 str_utConfigurationListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utConfigurationListSettingsCaption'; rValue : '������������ (�������)');
  {* ��������� ����������������� ���� "������������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utConfigurationList }
 utConfigurationListName = 'utConfigurationList';
  {* ��������� ������������� ����������������� ���� "������������" }
 utConfigurationList = TvcmUserType(0);
  {* ������������ }
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
 Tkw_FormUserType_utConfigurationList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utConfigurationList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utConfigurationList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utConfigurationList.GetInteger: Integer;
begin
 Result := utConfigurationList;
end;//Tkw_FormUserType_utConfigurationList.GetInteger

class function Tkw_FormUserType_utConfigurationList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utConfigurationList';
end;//Tkw_FormUserType_utConfigurationList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utConfigurationListCaption.Init;
 {* ������������� str_utConfigurationListCaption }
 str_utConfigurationListSettingsCaption.Init;
 {* ������������� str_utConfigurationListSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utConfigurationList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utConfigurationList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
