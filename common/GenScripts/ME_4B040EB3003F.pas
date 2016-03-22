unit DocumentUserTypes_dftDictEntry_UserType;
 {* ����� ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDictEntry_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftDictEntry" MUID: (4B040EB3003F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftRelatedSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftDictEntry }
 dftDictEntryName = 'dftDictEntry';
  {* ��������� ������������� ����������������� ���� "����� ��������� ������" }
 dftDictEntry = TvcmUserType(dftRelatedSynchroView + 1);
  {* ����� ��������� ������ }
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
 Tkw_FormUserType_dftDictEntry = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftDictEntry }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDictEntry
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDictEntry.GetInteger: Integer;
begin
 Result := dftDictEntry;
end;//Tkw_FormUserType_dftDictEntry.GetInteger

class function Tkw_FormUserType_dftDictEntry.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftDictEntry';
end;//Tkw_FormUserType_dftDictEntry.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDictEntry.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftDictEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
