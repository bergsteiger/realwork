unit ListUserTypes_lftRToPart_UserType;
 {* ������ �� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRToPart_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 , ListUserTypes_lftRespondent_UserType
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRToPart = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftRToPart }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftRToPart
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftRToPart.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftRToPart';
end;//Tkw_FormUserType_lftRToPart.GetWordNameForRegister

function Tkw_FormUserType_lftRToPart.GetInteger: Integer;
begin
 Result := lftRToPart;
end;//Tkw_FormUserType_lftRToPart.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRToPart.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftRToPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
