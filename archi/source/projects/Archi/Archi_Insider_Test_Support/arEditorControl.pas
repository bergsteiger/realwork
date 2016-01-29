unit arEditorControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/arEditorControl.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TarEditorControl
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
  evCustomEditorWindow,
  tfwScriptingInterfaces,
  tfwRegisterableWord
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TarEditorControl = {abstract} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected methods
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); virtual; abstract;
 end;//TarEditorControl
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TarEditorControl

procedure TarEditorControl.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE643F100CB_var*
//#UC END# *4DAEEDE10285_4DE643F100CB_var*
begin
//#UC START# *4DAEEDE10285_4DE643F100CB_impl*
 DoWithEditor(aCtx, arGetDocumentEditor);
//#UC END# *4DAEEDE10285_4DE643F100CB_impl*
end;//TarEditorControl.DoDoIt

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TarEditorControl
 TarEditorControl.RegisterClass;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.