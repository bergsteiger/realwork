unit PrintDialog_ut_PrintDialog_UserType;
 {* PrintDialog }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrintDialog_ut_PrintDialog_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 {* ��������� ��� ���� ����� ut_PrintDialog }
 ut_PrintDialogName = 'ut_PrintDialog';
  {* ��������� ������������� ����������������� ���� "PrintDialog" }
 ut_PrintDialog = TvcmUserType(0);
  {* PrintDialog }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PrintDialog = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_PrintDialog }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_PrintDialog
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_PrintDialog.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_PrintDialog';
end;//Tkw_FormUserType_ut_PrintDialog.GetWordNameForRegister

function Tkw_FormUserType_ut_PrintDialog.GetInteger: Integer;
begin
 Result := ut_PrintDialog;
end;//Tkw_FormUserType_ut_PrintDialog.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PrintDialog.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_PrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
