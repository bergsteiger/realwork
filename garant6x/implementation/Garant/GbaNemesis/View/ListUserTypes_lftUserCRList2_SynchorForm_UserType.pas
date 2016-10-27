unit ListUserTypes_lftUserCRList2_SynchorForm_UserType;
 {* ���������� �������� (������������� ������� ��������� ���������� 2) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList2_SynchorForm_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftUserCRList2_SynchorForm" MUID: (4BD58B080255)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCRList1_SynchorForm_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ lftUserCRList2_SynchorFormLocalConstants }
 str_lftUserCRList2_SynchorFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormCaption'; rValue : '���������� �������� (������������� ������� ��������� ���������� 2)');
  {* ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" }
 str_lftUserCRList2_SynchorFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCRList2_SynchorFormSettingsCaption'; rValue : '���������� ��������: ������ ���������������� ������� ������ ������� �� ��������\�� ���������');
  {* ��������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftUserCRList2_SynchorForm }
 lftUserCRList2_SynchorFormName = 'lftUserCRList2_SynchorForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������������� ������� ��������� ���������� 2)" }
 lftUserCRList2_SynchorForm = TvcmUserType(lftUserCRList1_SynchorForm + 1);
  {* ���������� �������� (������������� ������� ��������� ���������� 2) }
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
 Tkw_FormUserType_lftUserCRList2_SynchorForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftUserCRList2_SynchorForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftUserCRList2_SynchorForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftUserCRList2_SynchorForm.GetInteger: Integer;
begin
 Result := lftUserCRList2_SynchorForm;
end;//Tkw_FormUserType_lftUserCRList2_SynchorForm.GetInteger

class function Tkw_FormUserType_lftUserCRList2_SynchorForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftUserCRList2_SynchorForm';
end;//Tkw_FormUserType_lftUserCRList2_SynchorForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftUserCRList2_SynchorFormCaption.Init;
 {* ������������� str_lftUserCRList2_SynchorFormCaption }
 str_lftUserCRList2_SynchorFormSettingsCaption.Init;
 {* ������������� str_lftUserCRList2_SynchorFormSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList2_SynchorForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftUserCRList2_SynchorForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
