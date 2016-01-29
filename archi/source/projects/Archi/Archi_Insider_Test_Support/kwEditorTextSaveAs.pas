unit kwEditorTextSaveAs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwEditorTextSaveAs.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::Editor_Text_SaveAs
//
// ��������: ��������� ���� �� ��������� (��� ������������� �������) � ������ ������� � �������� �
// ��������� �����������.
// ������:
// {code}
// anExt Editor:Text:SaveAs
// {code}
// ��� anExt - ���������� �� ������ ��������������: '.evd', .txt', .rtf', .doc'
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwEditorTextSaveAs = {final scriptword} class(TtfwRegisterableWord)
  {* ��������: ��������� ���� �� ��������� (��� ������������� �������) � ������ ������� � �������� � ��������� �����������.
������:
[code]
anExt Editor:Text:SaveAs
[code]
��� anExt - ���������� �� ������ ��������������: '.evd', .txt', .rtf', .doc' }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorTextSaveAs
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2,
  SysUtils
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwEditorTextSaveAs

procedure TkwEditorTextSaveAs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_537D968501B2_var*
var
 l_FileExt: AnsiString;
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_537D968501B2_var*
begin
//#UC START# *4DAEEDE10285_537D968501B2_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ����������!', aCtx);
 l_FileExt := aCtx.rEngine.PopDelphiString;
 l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, l_FileExt);
 l_FileName := ExtractFileName(l_FileName);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 AcSaveTextAs(l_FileName);
//#UC END# *4DAEEDE10285_537D968501B2_impl*
end;//TkwEditorTextSaveAs.DoDoIt

class function TkwEditorTextSaveAs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Editor:Text:SaveAs';
end;//TkwEditorTextSaveAs.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� Editor_Text_SaveAs
 TkwEditorTextSaveAs.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.