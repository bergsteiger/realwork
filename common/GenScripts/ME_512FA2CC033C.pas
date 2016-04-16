unit kwPopTreeViewExportSelectionWithFormat;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwPopTreeViewExportSelectionWithFormat.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_TreeView_ExportSelectionWithFormat" MUID: (512FA2CC033C)
// Имя типа: "TkwPopTreeViewExportSelectionWithFormat"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwNscTreeViewWord
 {$If Defined(Nemesis)}
 , nscTreeView
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
;

type
 TkwPopTreeViewExportSelectionWithFormat = {final} class(TkwNscTreeViewWord)
  protected
   procedure DoWithNscTreeView(aTreeView: TnscTreeView;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopTreeViewExportSelectionWithFormat
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , PrimListOptions_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , nsTypes
 , bsTypes
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TPrimListOptionsFormHack = class({$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 TPrimListOptionsForm
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 )
 end;//TPrimListOptionsFormHack

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
 RunnerAssert(Assigned(l_Form) and (l_Form is TPrimListOptionsForm), 'Что-то не то со списком. Родительская форма не определена или не того класса.', aCtx);
 l_FF := TnsFileFormat(aCtx.rEngine.PopInt);
 with TPrimListOptionsFormHack(l_Form) do
  aCtx.rEngine.PushString(dsList.ListAsString(CalcSaveListKind, True, l_FF));
//#UC END# *512FA22703B6_512FA2CC033C_impl*
end;//TkwPopTreeViewExportSelectionWithFormat.DoWithNscTreeView

class function TkwPopTreeViewExportSelectionWithFormat.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeView:ExportSelectionWithFormat';
end;//TkwPopTreeViewExportSelectionWithFormat.GetWordNameForRegister

initialization
 TkwPopTreeViewExportSelectionWithFormat.RegisterInEngine;
 {* Регистрация pop_TreeView_ExportSelectionWithFormat }
{$IfEnd} // NOT Defined(NoScripts)

end.
