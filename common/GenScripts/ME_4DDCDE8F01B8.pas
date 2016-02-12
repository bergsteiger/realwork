unit PrimChangesBetweenEditons_DocumentChanges_UserType;
 {* ��������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_DocumentChanges_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� DocumentChanges }
 DocumentChangesName = 'DocumentChanges';
  {* ��������� ������������� ����������������� ���� "��������� � ���������" }
 DocumentChanges = TvcmUserType(0);
  {* ��������� � ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_DocumentChanges = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� DocumentChanges }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_DocumentChanges
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_DocumentChanges.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::DocumentChanges';
end;//Tkw_FormUserType_DocumentChanges.GetWordNameForRegister

function Tkw_FormUserType_DocumentChanges.GetInteger: Integer;
begin
 Result := DocumentChanges;
end;//Tkw_FormUserType_DocumentChanges.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_DocumentChanges.RegisterInEngine;
 {* ����������� Tkw_FormUserType_DocumentChanges }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
