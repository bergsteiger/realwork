unit nscTreeViewForDocumentListWordsPack;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\nscTreeViewForDocumentListWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "nscTreeViewForDocumentListWordsPack" MUID: (5130D80002C1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *5130D80002C1intf_uses*
 //#UC END# *5130D80002C1intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(Nemesis)}
 , nscTreeView
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , kwComponentFromStackWord
 , Classes
 , PrimListOptions_Form
 , nsTypes
 , bsTypes
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *5130D80002C1impl_uses*
 //#UC END# *5130D80002C1impl_uses*
;

type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}
 TkwNscTreeViewWord = {abstract} class(_kwControlFromStackWord_)
  protected
   procedure DoWithNscTreeView(aTreeView: TnscTreeView;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwNscTreeViewWord

 TPrimListOptionsFormHack = class(TPrimListOptionsForm)
 end;//TPrimListOptionsFormHack

 TkwPopTreeViewExportSelectionWithFormat = {final} class(TkwNscTreeViewWord)
  protected
   procedure DoWithNscTreeView(aTreeView: TnscTreeView;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopTreeViewExportSelectionWithFormat

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwControlFromStackWord.imp.pas}

{$If NOT Defined(NoVCL)}
procedure TkwNscTreeViewWord.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4F212C3A015A_512FA1800269_var*
//#UC END# *4F212C3A015A_512FA1800269_var*
begin
//#UC START# *4F212C3A015A_512FA1800269_impl*
 RunnerAssert(aControl is TnscTreeView, '��� �� TnscTreeView.', aCtx);
 DoWithNscTreeView(aControl as TnscTreeView, aCtx);
//#UC END# *4F212C3A015A_512FA1800269_impl*
end;//TkwNscTreeViewWord.DoControl
{$IfEnd} // NOT Defined(NoVCL)

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
 with TPrimListOptionsFormHack(l_Form) do
  aCtx.rEngine.PushString(dsList.ListAsString(CalcSaveListKind, True, l_FF));
//#UC END# *512FA22703B6_512FA2CC033C_impl*
end;//TkwPopTreeViewExportSelectionWithFormat.DoWithNscTreeView

class function TkwPopTreeViewExportSelectionWithFormat.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeView:ExportSelectionWithFormat';
end;//TkwPopTreeViewExportSelectionWithFormat.GetWordNameForRegister

initialization
 TkwNscTreeViewWord.RegisterClass;
 {* ����������� TkwNscTreeViewWord }
 TkwPopTreeViewExportSelectionWithFormat.RegisterInEngine;
 {* ����������� pop_TreeView_ExportSelectionWithFormat }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
