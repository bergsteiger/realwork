unit PrimRubricator_utRubricatorList_UserType;
 {* �������� ��������� (�������� �������������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\PrimRubricator_utRubricatorList_UserType.pas"
// ���������: "UserType"
// ������� ������: "utRubricatorList" MUID: (4BD728AC00C0)

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
 {* ������������ ������ utRubricatorListLocalConstants }
 str_utRubricatorListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRubricatorListCaption'; rValue : '�������� ��������� (�������� �������������)');
  {* ��������� ����������������� ���� "�������� ��������� (�������� �������������)" }
 str_utRubricatorListSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRubricatorListSettingsCaption'; rValue : '�������� ���������');
  {* ��������� ����������������� ���� "�������� ��������� (�������� �������������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utRubricatorList }
 utRubricatorListName = 'utRubricatorList';
  {* ��������� ������������� ����������������� ���� "�������� ��������� (�������� �������������)" }
 utRubricatorList = TvcmUserType(0);
  {* �������� ��������� (�������� �������������) }
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
 Tkw_FormUserType_utRubricatorList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utRubricatorList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utRubricatorList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utRubricatorList.GetInteger: Integer;
begin
 Result := utRubricatorList;
end;//Tkw_FormUserType_utRubricatorList.GetInteger

class function Tkw_FormUserType_utRubricatorList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utRubricatorList';
end;//Tkw_FormUserType_utRubricatorList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utRubricatorListCaption.Init;
 {* ������������� str_utRubricatorListCaption }
 str_utRubricatorListSettingsCaption.Init;
 {* ������������� str_utRubricatorListSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRubricatorList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utRubricatorList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
