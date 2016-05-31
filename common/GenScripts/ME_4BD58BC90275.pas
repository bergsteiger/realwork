unit ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType;
 {* ���������� �������� (�������� �� �������������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftDrugInternationalNameSynonymsSynchroForm" MUID: (4BD58BC90275)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ lftDrugInternationalNameSynonymsSynchroFormLocalConstants }
 str_lftDrugInternationalNameSynonymsSynchroFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormCaption'; rValue : '���������� �������� (�������� �� �������������� ��������)');
  {* ��������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" }
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsSynchroFormSettingsCaption'; rValue : '���������� ��������: �������� �� �������������� ��������');
  {* ��������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftDrugInternationalNameSynonymsSynchroForm }
 lftDrugInternationalNameSynonymsSynchroFormName = 'lftDrugInternationalNameSynonymsSynchroForm';
  {* ��������� ������������� ����������������� ���� "���������� �������� (�������� �� �������������� ��������)" }
 lftDrugInternationalNameSynonymsSynchroForm = TvcmUserType(lftProducedDrugsSynchroForm + 1);
  {* ���������� �������� (�������� �� �������������� ��������) }
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
 Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftDrugInternationalNameSynonymsSynchroForm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger: Integer;
begin
 Result := lftDrugInternationalNameSynonymsSynchroForm;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger

class function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftDrugInternationalNameSynonymsSynchroForm';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftDrugInternationalNameSynonymsSynchroFormCaption.Init;
 {* ������������� str_lftDrugInternationalNameSynonymsSynchroFormCaption }
 str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption.Init;
 {* ������������� str_lftDrugInternationalNameSynonymsSynchroFormSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
