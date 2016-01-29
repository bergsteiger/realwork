unit kwPopTreeViewExportSelectionWithFormat;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwPopTreeViewExportSelectionWithFormat.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Shell Words::TreeViewWords::pop_TreeView_ExportSelectionWithFormat
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  PrimListOptions_Form
  {$IfEnd} //not Admin AND not Monitorings
  ,
  kwNscTreeViewWord
  {$If defined(Nemesis)}
  ,
  nscTreeView
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwPopTreeViewExportSelectionWithFormat = {final scriptword} class(TkwNscTreeViewWord)
 protected
 // realized methods
   procedure DoWithNscTreeView(aTreeView: TnscTreeView;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopTreeViewExportSelectionWithFormat
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  nsTypes,
  bsTypes,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

type
  TPrimListOptionsFormHack = class(TPrimListOptionsForm)
  end;//TPrimListOptionsFormHack

// start class TkwPopTreeViewExportSelectionWithFormat

procedure TkwPopTreeViewExportSelectionWithFormat.DoWithNscTreeView(aTreeView: TnscTreeView;
  const aCtx: TtfwContext);
//#UC START# *512FA22703B6_512FA2CC033C_var*
var
 l_Form: TCustomForm;
 l_FF: TnsFileFormat;
//#UC END# *512FA22703B6_512FA2CC033C_var*
begin
//#UC START# *512FA22703B6_512FA2CC033C_impl*
 l_Form := afw.GetParentForm(aTreeView);
 RunnerAssert(Assigned(l_Form) and (l_Form is TPrimListOptionsForm), '���-�� �� �� �� �������. ������������ ����� �� ���������� ��� �� ���� ������.', aCtx);
 l_FF := TnsFileFormat(aCtx.rEngine.PopInt);
 aCtx.rEngine.PushString(TPrimListOptionsFormHack(l_Form).dsList.ListAsString(bs_slkTitlesFullTree, True, l_FF));
//#UC END# *512FA22703B6_512FA2CC033C_impl*
end;//TkwPopTreeViewExportSelectionWithFormat.DoWithNscTreeView

class function TkwPopTreeViewExportSelectionWithFormat.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeView:ExportSelectionWithFormat';
end;//TkwPopTreeViewExportSelectionWithFormat.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_TreeView_ExportSelectionWithFormat
 TkwPopTreeViewExportSelectionWithFormat.RegisterInEngine;
{$IfEnd} //not NoScripts

end.