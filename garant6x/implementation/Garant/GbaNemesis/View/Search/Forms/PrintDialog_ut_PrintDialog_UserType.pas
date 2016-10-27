unit PrintDialog_ut_PrintDialog_UserType;
 {* PrintDialog }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrintDialog_ut_PrintDialog_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_PrintDialog" MUID: (5E53BABDF58D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_PrintDialogLocalConstants }
 str_ut_PrintDialogCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PrintDialogCaption'; rValue : 'PrintDialog');
  {* ��������� ����������������� ���� "PrintDialog" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_PrintDialog = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_PrintDialog }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_PrintDialog
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_PrintDialog.GetInteger: Integer;
begin
 Result := ut_PrintDialog;
end;//Tkw_FormUserType_ut_PrintDialog.GetInteger

class function Tkw_FormUserType_ut_PrintDialog.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_PrintDialog';
end;//Tkw_FormUserType_ut_PrintDialog.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_PrintDialogCaption.Init;
 {* ������������� str_ut_PrintDialogCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PrintDialog.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_PrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
