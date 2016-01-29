unit kwEditorSetTOC;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEditorSetTOC.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwEditorSetTOC
//
// ��������:����������_����������
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwEditorSetTOC = {scriptword} class(TtfwRegisterableWord)
  {* ��������:����������_���������� }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorSetTOC
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwEditorSetTOC

procedure TkwEditorSetTOC.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4ECB504D000B_var*
var
 l_BlockID: Integer;
//#UC END# *4DAEEDE10285_4ECB504D000B_var*
begin
//#UC START# *4DAEEDE10285_4ECB504D000B_impl*
 if aCtx.rEngine.IsTopInt then
  l_BlockID := aCtx.rEngine.PopInt
 else
  Assert(False, '�� ����� ����� �����!');
 ArSetContentsSub(l_BlockID);
//#UC END# *4DAEEDE10285_4ECB504D000B_impl*
end;//TkwEditorSetTOC.DoDoIt

class function TkwEditorSetTOC.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '��������:����������_����������';
end;//TkwEditorSetTOC.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwEditorSetTOC
 TkwEditorSetTOC.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.