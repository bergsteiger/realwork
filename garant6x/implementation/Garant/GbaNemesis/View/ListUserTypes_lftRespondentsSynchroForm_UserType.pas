unit ListUserTypes_lftRespondentsSynchroForm_UserType;
 {* ���������� �������� (������ �� ���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondentsSynchroForm_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftRespondentsSynchroForm" MUID: (4BD58A780204)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ lftRespondentsSynchroFormLocalConstants }
 str_lftRespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormCaption'; rValue : '���������� �������� (������ �� ���������)');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������)" }
 str_lftRespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftRespondentsSynchroFormSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ���������');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ���������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftRespondentsSynchroForm }
 lftRespondentsSynchroFormName = 'lftRespondentsSynchroForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������ �� ���������)" }
 lftRespondentsSynchroForm = TvcmUserType(lftCorrespondentsSynchroForm + 1);
  {* ���������� �������� (������ �� ���������) }
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
 Tkw_FormUserType_lftRespondentsSynchroForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftRespondentsSynchroForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftRespondentsSynchroForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger: Integer;
begin
 Result := lftRespondentsSynchroForm;
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger

class function Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftRespondentsSynchroForm';
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftRespondentsSynchroFormCaption.Init;
 {* ������������� str_lftRespondentsSynchroFormCaption }
 str_lftRespondentsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftRespondentsSynchroFormSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondentsSynchroForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftRespondentsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
