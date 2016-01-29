unit kwSearchWinSaveDocumentList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwSearchWinSaveDocumentList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::SearchWin_SaveDocumentList
//
// ������:
// {code}
// aFileName SearchWin:SaveDocumentList
// {code}
// ��������� ������ ���������� � ���� aFileName. ��������� ������� "��������� ���..." � ����
// �������. ���� ������� ������ ���� �������.
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
 TkwSearchWinSaveDocumentList = {final scriptword} class(TtfwRegisterableWord)
  {* ������: 
[code]
aFileName SearchWin:SaveDocumentList
[code]
��������� ������ ���������� � ���� aFileName. ��������� ������� "��������� ���..." � ���� �������. ���� ������� ������ ���� �������. }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSearchWinSaveDocumentList
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwSearchWinSaveDocumentList

procedure TkwSearchWinSaveDocumentList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_537076040297_var*
var
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_537076040297_var*
begin
//#UC START# *4DAEEDE10285_537076040297_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ����������!', aCtx);
 l_FileName := aCtx.rEngine.PopDelphiString;
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 AcSaveDocAs(l_FileName);
//#UC END# *4DAEEDE10285_537076040297_impl*
end;//TkwSearchWinSaveDocumentList.DoDoIt

class function TkwSearchWinSaveDocumentList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SearchWin:SaveDocumentList';
end;//TkwSearchWinSaveDocumentList.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� SearchWin_SaveDocumentList
 TkwSearchWinSaveDocumentList.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.