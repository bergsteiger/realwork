unit kwMainFormFindDocuments;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwMainFormFindDocuments.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::MainForm_FindDocuments
//
// �������� ����� ����������.
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
 TkwMainFormFindDocuments = {final scriptword} class(TtfwRegisterableWord)
  {* �������� ����� ����������. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMainFormFindDocuments
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Main
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwMainFormFindDocuments

procedure TkwMainFormFindDocuments.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F8D503400FD_var*
//#UC END# *4DAEEDE10285_4F8D503400FD_var*
begin
//#UC START# *4DAEEDE10285_4F8D503400FD_impl*
 Assert(MainForm <> nil);
 MainForm.acFindDoc.Execute;
//#UC END# *4DAEEDE10285_4F8D503400FD_impl*
end;//TkwMainFormFindDocuments.DoDoIt

class function TkwMainFormFindDocuments.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MainForm:FindDocuments';
end;//TkwMainFormFindDocuments.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� MainForm_FindDocuments
 TkwMainFormFindDocuments.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.