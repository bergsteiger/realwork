unit DocumentWithFlashUserTypes_dwftSynchro_UserType;
 {* ����� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftSynchro_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentWithFlashUserTypes_dwftMain_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dwftSynchro }
 dwftSynchroName = 'dwftSynchro';
  {* ��������� ������������� ����������������� ���� "����� (���������� ��������)" }
 dwftSynchro = TvcmUserType(dwftMain + 1);
  {* ����� (���������� ��������) }
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
 Tkw_FormUserType_dwftSynchro = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dwftSynchro }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dwftSynchro
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dwftSynchro.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dwftSynchro';
end;//Tkw_FormUserType_dwftSynchro.GetWordNameForRegister

function Tkw_FormUserType_dwftSynchro.GetInteger: Integer;
begin
 Result := dwftSynchro;
end;//Tkw_FormUserType_dwftSynchro.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftSynchro.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dwftSynchro }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
