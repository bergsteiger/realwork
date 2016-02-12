unit DocumentUserTypes_dftMedDictEntry_UserType;
 {* �������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedDictEntry_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� dftMedDictEntry }
 dftMedDictEntryName = 'dftMedDictEntry';
  {* ��������� ������������� ����������������� ���� "�������� ������������ �������" }
 dftMedDictEntry = TvcmUserType(dftTips + 1);
  {* �������� ������������ ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedDictEntry = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftMedDictEntry }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftMedDictEntry
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftMedDictEntry';
end;//Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister

function Tkw_FormUserType_dftMedDictEntry.GetInteger: Integer;
begin
 Result := dftMedDictEntry;
end;//Tkw_FormUserType_dftMedDictEntry.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedDictEntry.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftMedDictEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
