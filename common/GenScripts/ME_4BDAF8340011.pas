unit PrimMainMenuNew_utMainMenuNew_UserType;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuNew_utMainMenuNew_UserType.pas"
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
 {* ��������� ��� ���� ����� utMainMenuNew }
 utMainMenuNewName = 'utMainMenuNew';
  {* ��������� ������������� ����������������� ���� "�������� ����" }
 utMainMenuNew = TvcmUserType(0);
  {* �������� ���� }
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
 Tkw_FormUserType_utMainMenuNew = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utMainMenuNew }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utMainMenuNew
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utMainMenuNew';
end;//Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister

function Tkw_FormUserType_utMainMenuNew.GetInteger: Integer;
begin
 Result := utMainMenuNew;
end;//Tkw_FormUserType_utMainMenuNew.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainMenuNew.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utMainMenuNew }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
