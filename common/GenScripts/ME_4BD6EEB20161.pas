unit DocumentWithFlashUserTypes_dwftSynchro_UserType;
 {* ����� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftSynchro_UserType.pas"
// ���������: "UserType"
// ������� ������: "dwftSynchro" MUID: (4BD6EEB20161)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentWithFlashUserTypes_dwftMain_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ dwftSynchroLocalConstants }
 str_dwftSynchroCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroCaption'; rValue : '����� (���������� ��������)');
  {* ��������� ����������������� ���� "����� (���������� ��������)" }
 str_dwftSynchroSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftSynchroSettingsCaption'; rValue : '���������� ��������: �����');
  {* ��������� ����������������� ���� "����� (���������� ��������)" ��� ��������� ������� ������������ }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dwftSynchro = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dwftSynchro }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dwftSynchro
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dwftSynchro.GetInteger: Integer;
begin
 Result := dwftSynchro;
end;//Tkw_FormUserType_dwftSynchro.GetInteger

class function Tkw_FormUserType_dwftSynchro.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dwftSynchro';
end;//Tkw_FormUserType_dwftSynchro.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dwftSynchroCaption.Init;
 {* ������������� str_dwftSynchroCaption }
 str_dwftSynchroSettingsCaption.Init;
 {* ������������� str_dwftSynchroSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftSynchro.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dwftSynchro }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
