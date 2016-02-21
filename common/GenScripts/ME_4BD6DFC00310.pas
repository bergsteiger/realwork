unit PrimStyleEditorExample_utStyleEditorExample_UserType;
 {* ��������� ���� ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorExample_utStyleEditorExample_UserType.pas"
// ���������: "UserType"

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
 {* ��������� ��� ���� ����� utStyleEditorExample }
 utStyleEditorExampleName = 'utStyleEditorExample';
  {* ��������� ������������� ����������������� ���� "��������� ���� ��������� ������" }
 utStyleEditorExample = TvcmUserType(0);
  {* ��������� ���� ��������� ������ }
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
 Tkw_FormUserType_utStyleEditorExample = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utStyleEditorExample }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utStyleEditorExample
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utStyleEditorExample.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utStyleEditorExample';
end;//Tkw_FormUserType_utStyleEditorExample.GetWordNameForRegister

function Tkw_FormUserType_utStyleEditorExample.GetInteger: Integer;
begin
 Result := utStyleEditorExample;
end;//Tkw_FormUserType_utStyleEditorExample.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorExample.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utStyleEditorExample }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
