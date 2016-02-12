unit DocumentUserTypes_dftRelatedDoc_UserType;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedDoc_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDocument_UserType
 , DocumentUserTypes_dftAnnotation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� dftRelatedDoc }
 dftRelatedDocName = 'dftRelatedDoc';
  {* ��������� ������������� ����������������� ���� "�������" }
 dftRelatedDoc = TvcmUserType(dftDocument + 1);
  {* ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedDoc = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftRelatedDoc }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftRelatedDoc
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftRelatedDoc.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftRelatedDoc';
end;//Tkw_FormUserType_dftRelatedDoc.GetWordNameForRegister

function Tkw_FormUserType_dftRelatedDoc.GetInteger: Integer;
begin
 Result := dftRelatedDoc;
end;//Tkw_FormUserType_dftRelatedDoc.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedDoc.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftRelatedDoc }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
