unit kwEditorDblClickOnSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEditorDblClickOnSub.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwEditorDblClickOnSub
//
// ������� ������ �� ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arEditorControl,
  evCustomEditorWindow,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwEditorDblClickOnSub = {scriptword} class(TarEditorControl)
  {* ������� ������ �� ����. }
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorDblClickOnSub
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwEditorDblClickOnSub

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
 {-}
begin
 Result := '����_���������:��������_���';
end;//TkwEditorDblClickOnSub.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwEditorDblClickOnSub
 TkwEditorDblClickOnSub.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.