unit DocumentUserTypes_dftMedDictEntry_UserType;
 {* �������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedDictEntry_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftMedDictEntry" MUID: (4B04100D0197)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ dftMedDictEntryLocalConstants }
 str_dftMedDictEntryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntryCaption'; rValue : '�������� ������������ �������');
  {* ��������� ����������������� ���� "�������� ������������ �������" }
 str_dftMedDictEntrySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntrySettingsCaption'; rValue : '������� ����������� ��������: �������� ������������ �������');
  {* ��������� ����������������� ���� "�������� ������������ �������" ��� ��������� ������� ������������ }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftMedDictEntry = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftMedDictEntry }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftMedDictEntry
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftMedDictEntry.GetInteger: Integer;
begin
 Result := dftMedDictEntry;
end;//Tkw_FormUserType_dftMedDictEntry.GetInteger

class function Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftMedDictEntry';
end;//Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftMedDictEntryCaption.Init;
 {* ������������� str_dftMedDictEntryCaption }
 str_dftMedDictEntrySettingsCaption.Init;
 {* ������������� str_dftMedDictEntrySettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedDictEntry.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftMedDictEntry }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
