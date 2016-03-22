unit PrimAdmin_utAdmin_UserType;
 {* ����������������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimAdmin_utAdmin_UserType.pas"
// ���������: "UserType"
// ������� ������: "utAdmin" MUID: (4C88EBD5036F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utAdmin }
 utAdminName = 'utAdmin';
  {* ��������� ������������� ����������������� ���� "����������������� �������������" }
 utAdmin = TvcmUserType(0);
  {* ����������������� ������������� }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utAdmin = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utAdmin }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utAdmin
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utAdmin.GetInteger: Integer;
begin
 Result := utAdmin;
end;//Tkw_FormUserType_utAdmin.GetInteger

class function Tkw_FormUserType_utAdmin.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utAdmin';
end;//Tkw_FormUserType_utAdmin.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAdmin.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utAdmin }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
