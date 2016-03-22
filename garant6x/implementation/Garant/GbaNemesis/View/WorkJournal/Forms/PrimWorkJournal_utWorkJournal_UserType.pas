unit PrimWorkJournal_utWorkJournal_UserType;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_utWorkJournal_UserType.pas"
// ���������: "UserType"
// ������� ������: "utWorkJournal" MUID: (4BD6D74C0111)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utWorkJournal }
 utWorkJournalName = 'utWorkJournal';
  {* ��������� ������������� ����������������� ���� "������ ������" }
 utWorkJournal = TvcmUserType(0);
  {* ������ ������ }
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
 Tkw_FormUserType_utWorkJournal = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utWorkJournal }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utWorkJournal
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utWorkJournal.GetInteger: Integer;
begin
 Result := utWorkJournal;
end;//Tkw_FormUserType_utWorkJournal.GetInteger

class function Tkw_FormUserType_utWorkJournal.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utWorkJournal';
end;//Tkw_FormUserType_utWorkJournal.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utWorkJournal.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utWorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
