unit PrimCreateFilter_cfCreate_UserType;
 {* ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas"
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
 {* ��������� ��� ���� ����� cfCreate }
 cfCreateName = 'cfCreate';
  {* ��������� ������������� ����������������� ���� "������� ������" }
 cfCreate = TvcmUserType(0);
  {* ������� ������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfCreate = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cfCreate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_cfCreate
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_cfCreate.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cfCreate';
end;//Tkw_FormUserType_cfCreate.GetWordNameForRegister

function Tkw_FormUserType_cfCreate.GetInteger: Integer;
begin
 Result := cfCreate;
end;//Tkw_FormUserType_cfCreate.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfCreate.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cfCreate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
