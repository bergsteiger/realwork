unit DocumentUserTypes_dftDocument_UserType;
 {* ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDocument_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftDocument" MUID: (4B040A5E0051)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftDocument }
 dftDocumentName = 'dftDocument';
  {* ��������� ������������� ����������������� ���� "�����" }
 dftDocument = TvcmUserType(dftNone + 1);
  {* ����� }
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
 Tkw_FormUserType_dftDocument = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftDocument }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDocument
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDocument.GetInteger: Integer;
begin
 Result := dftDocument;
end;//Tkw_FormUserType_dftDocument.GetInteger

class function Tkw_FormUserType_dftDocument.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftDocument';
end;//Tkw_FormUserType_dftDocument.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDocument.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftDocument }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
