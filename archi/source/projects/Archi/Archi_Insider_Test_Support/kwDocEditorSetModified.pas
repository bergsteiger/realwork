unit kwDocEditorSetModified;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwDocEditorSetModified.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwDocEditorSetModified
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
 TkwDocEditorSetModified = {scriptword} class(TarEditorControl)
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocEditorSetModified
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwDocEditorSetModified

procedure TkwDocEditorSetModified.DoWithEditor(const aCtx: TtfwContext;
  const anEditor: TevCustomEditorWindow);
//#UC START# *4DE7421F03DF_4E01E88B029B_var*
//#UC END# *4DE7421F03DF_4E01E88B029B_var*
begin
//#UC START# *4DE7421F03DF_4E01E88B029B_impl*
 if aCtx.rEngine.IsTopBool then
  anEditor.Modified := aCtx.rEngine.PopBool
 else
  Assert(False, '�� ������ �������� �����.');
//#UC END# *4DE7421F03DF_4E01E88B029B_impl*
end;//TkwDocEditorSetModified.DoWithEditor

class function TkwDocEditorSetModified.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '����_���������:��������:SetModified';
end;//TkwDocEditorSetModified.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwDocEditorSetModified
 TkwDocEditorSetModified.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.