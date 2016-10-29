unit PrimGroupList_admGroupList_UserType;
 {* ������ ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupList_admGroupList_UserType.pas"
// ���������: "UserType"
// ������� ������: "admGroupList" MUID: (4BD71DC30222)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ admGroupListLocalConstants }
 str_admGroupListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListCaption'; rValue : '������ �������������');
  {* ��������� ����������������� ���� "������ �������������" }
 str_admGroupListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListSettingsCaption'; rValue : '������ ������������� (�������)');
  {* ��������� ����������������� ���� "������ �������������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� admGroupList }
 admGroupListName = 'admGroupList';
  {* ��������� ������������� ����������������� ���� "������ �������������" }
 admGroupList = TvcmUserType(0);
  {* ������ ������������� }
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
 Tkw_FormUserType_admGroupList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admGroupList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_admGroupList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_admGroupList.GetInteger: Integer;
begin
 Result := admGroupList;
end;//Tkw_FormUserType_admGroupList.GetInteger

class function Tkw_FormUserType_admGroupList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admGroupList';
end;//Tkw_FormUserType_admGroupList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_admGroupListCaption.Init;
 {* ������������� str_admGroupListCaption }
 str_admGroupListSettingsCaption.Init;
 {* ������������� str_admGroupListSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admGroupList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_admGroupList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
