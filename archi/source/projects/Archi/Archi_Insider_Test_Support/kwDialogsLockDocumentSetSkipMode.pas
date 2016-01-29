unit kwDialogsLockDocumentSetSkipMode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwDialogsLockDocumentSetSkipMode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::dialogs_LockDocument_SetSkipMode
//
// ������������� ����� ������ � �������� � ������� ���������:
// {code}
// ar_AsUsual // ���������� ������ � ��������� ��� ���������.
// ar_OpenDocument // ���� ���� ���������� - ��� ����� ���������.
// ar_NotOpen // ���� ���� ���������� - �� ���������.
// {code}
// ������:
// {code}
// aMode dialogs:LockDocument:SetSkipMode
// {code}
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
 TkwDialogsLockDocumentSetSkipMode = {final scriptword} class(TtfwRegisterableWord)
  {* ������������� ����� ������ � �������� � ������� ���������:
[code]
  ar_AsUsual // ���������� ������ � ��������� ��� ���������.
  ar_OpenDocument // ���� ���� ���������� - ��� ����� ���������.
  ar_NotOpen // ���� ���� ���������� - �� ���������.
[code]
������:
[code]
aMode dialogs:LockDocument:SetSkipMode
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDialogsLockDocumentSetSkipMode
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwDialogsLockDocumentSetSkipMode

procedure TkwDialogsLockDocumentSetSkipMode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_54255FED0328_var*
//#UC END# *4DAEEDE10285_54255FED0328_var*
begin
//#UC START# *4DAEEDE10285_54255FED0328_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, '�� ����� ����� ������ �������!', aCtx);
 TarTestConfig.Instance.SkipLockDialog := TarSkipDialog(aCtx.rEngine.PopInt);
//#UC END# *4DAEEDE10285_54255FED0328_impl*
end;//TkwDialogsLockDocumentSetSkipMode.DoDoIt

class function TkwDialogsLockDocumentSetSkipMode.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'dialogs:LockDocument:SetSkipMode';
end;//TkwDialogsLockDocumentSetSkipMode.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� dialogs_LockDocument_SetSkipMode
 TkwDialogsLockDocumentSetSkipMode.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.