unit PrintDialog_ut_PrintDialog_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrintDialog_ut_PrintDialog_UserType.pas"
// �����: 15.09.2009 16:55
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::PrintDialog::ut_PrintDialog
//
// PrintDialog
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { ��������� ��� ���� ����� ut_PrintDialog }
   ut_PrintDialogName = 'ut_PrintDialog';
    { ��������� ������������� ����������������� ���� "PrintDialog" }
   ut_PrintDialog = TvcmUserType(0);
    { PrintDialog }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_PrintDialog = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_PrintDialog }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_PrintDialog
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_PrintDialog

class function Tkw_FormUserType_ut_PrintDialog.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_PrintDialog';
end;//Tkw_FormUserType_ut_PrintDialog.GetWordNameForRegister

function Tkw_FormUserType_ut_PrintDialog.GetInteger: Integer;
 {-}
begin
 Result := ut_PrintDialog;
end;//Tkw_FormUserType_ut_PrintDialog.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_PrintDialog
 Tkw_FormUserType_ut_PrintDialog.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.