unit kwEditorDblClickOnSub;
 {* ������� ������ �� ����. }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorDblClickOnSub.pas"
// ���������: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , arEditorControl
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwEditorDblClickOnSub = class(TarEditorControl)
  {* ������� ������ �� ����. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorDblClickOnSub
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

procedure TkwEditorDblClickOnSub.DoWithEditor(const aCtx: TtfwContext;
 const anEditor: TevCustomEditorWindow);
//#UC START# *4DE7421F03DF_4DFB3B88027A_var*
//#UC END# *4DE7421F03DF_4DFB3B88027A_var*
begin
//#UC START# *4DE7421F03DF_4DFB3B88027A_impl*
 if aCtx.rEngine.IsTopInt then
  arSubNameEdit(aCtx.rEngine.PopInt)
 else
  Assert(False, '��� ������ ���� � �����!');
//#UC END# *4DE7421F03DF_4DFB3B88027A_impl*
end;//TkwEditorDblClickOnSub.DoWithEditor

class function TkwEditorDblClickOnSub.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:��������_���';
end;//TkwEditorDblClickOnSub.GetWordNameForRegister

initialization
 TkwEditorDblClickOnSub.RegisterInEngine;
 {* ����������� TkwEditorDblClickOnSub }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
