unit kwQueryCardFromStackWord;
 {* ����� ���������� � ������� ���������� ��� � ��������� ������� }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwQueryCardFromStackWord.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evCustomEditorWindow
;

type
 TkwQueryCardFromStackWord = {abstract} class(TkwEditorFromStackWord)
  {* ����� ���������� � ������� ���������� ��� � ��������� ������� }
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); virtual; abstract;
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
 end;//TkwQueryCardFromStackWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwQueryCardFromStackWord.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4E808D48037D_var*
//#UC END# *4F4CB81200CA_4E808D48037D_var*
begin
//#UC START# *4F4CB81200CA_4E808D48037D_impl*
 RunnerAssert(anEditor is TevQueryCardEditor, '��� �� ��', aCtx);
 DoCard(aCtx, anEditor as TevQueryCardEditor);
//#UC END# *4F4CB81200CA_4E808D48037D_impl*
end;//TkwQueryCardFromStackWord.DoWithEditor

initialization
 TkwQueryCardFromStackWord.RegisterClass;
 {* ����������� TkwQueryCardFromStackWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
