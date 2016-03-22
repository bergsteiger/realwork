unit ListUserTypes_lftRToPart_UserType;
 {* ������ �� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRToPart_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftRToPart" MUID: (5236CE6D00AC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftRToPart }
 lftRToPartName = 'lftRToPart';
  {* ��������� ������������� ����������������� ���� "������ �� ���������" }
 lftRToPart = TvcmUserType(lftDrugInternationalNameSynonymsSynchroForm + 1);
  {* ������ �� ��������� }
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
 Tkw_FormUserType_lftRToPart = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftRToPart }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftRToPart
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftRToPart.GetInteger: Integer;
begin
 Result := lftRToPart;
end;//Tkw_FormUserType_lftRToPart.GetInteger

class function Tkw_FormUserType_lftRToPart.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftRToPart';
end;//Tkw_FormUserType_lftRToPart.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRToPart.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftRToPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
