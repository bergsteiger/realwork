unit ListUserTypes_lftCorrespondentsSynchroForm_UserType;
 {* ���������� �������� (������ �� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCorrespondentsSynchroForm_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftCorrespondentsSynchroForm" MUID: (4BD58A460089)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ lftCorrespondentsSynchroFormLocalConstants }
 str_lftCorrespondentsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormCaption'; rValue : '���������� �������� (������ �� ��������)');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ��������)" }
 str_lftCorrespondentsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCorrespondentsSynchroFormSettingsCaption'; rValue : '���������� ��������: ������ ������ �� ��������');
  {* ��������� ����������������� ���� "���������� �������� (������ �� ��������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftCorrespondentsSynchroForm }
 lftCorrespondentsSynchroFormName = 'lftCorrespondentsSynchroForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (������ �� ��������)" }
 lftCorrespondentsSynchroForm = TvcmUserType(lftSimilarDocumentsSynchroView + 1);
  {* ���������� �������� (������ �� ��������) }
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
 Tkw_FormUserType_lftCorrespondentsSynchroForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftCorrespondentsSynchroForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftCorrespondentsSynchroForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftCorrespondentsSynchroForm.GetInteger: Integer;
begin
 Result := lftCorrespondentsSynchroForm;
end;//Tkw_FormUserType_lftCorrespondentsSynchroForm.GetInteger

class function Tkw_FormUserType_lftCorrespondentsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftCorrespondentsSynchroForm';
end;//Tkw_FormUserType_lftCorrespondentsSynchroForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftCorrespondentsSynchroFormCaption.Init;
 {* ������������� str_lftCorrespondentsSynchroFormCaption }
 str_lftCorrespondentsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftCorrespondentsSynchroFormSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCorrespondentsSynchroForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftCorrespondentsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
