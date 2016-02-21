unit ListUserTypes_lftCorrespondentsSynchroForm_UserType;
 {* ���������� �������� (������ �� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCorrespondentsSynchroForm_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCorrespondentsSynchroForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftCorrespondentsSynchroForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftCorrespondentsSynchroForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftCorrespondentsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftCorrespondentsSynchroForm';
end;//Tkw_FormUserType_lftCorrespondentsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftCorrespondentsSynchroForm.GetInteger: Integer;
begin
 Result := lftCorrespondentsSynchroForm;
end;//Tkw_FormUserType_lftCorrespondentsSynchroForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCorrespondentsSynchroForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftCorrespondentsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
