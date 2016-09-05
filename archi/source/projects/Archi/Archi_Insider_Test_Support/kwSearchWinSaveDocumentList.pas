unit kwSearchWinSaveDocumentList;
 {* ������: 
[code]
aFileName SearchWin:SaveDocumentList
[code]
��������� ������ ���������� � ���� aFileName. ��������� ������� "��������� ���..." � ���� �������. ���� ������� ������ ���� �������. }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSearchWinSaveDocumentList.pas"
// ���������: "ScriptKeyword"
// ������� ������: "SearchWin_SaveDocumentList" MUID: (537076040297)
// ��� ����: "TkwSearchWinSaveDocumentList"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSearchWinSaveDocumentList = {final} class(TtfwRegisterableWord)
  {* ������: 
[code]
aFileName SearchWin:SaveDocumentList
[code]
��������� ������ ���������� � ���� aFileName. ��������� ������� "��������� ���..." � ���� �������. ���� ������� ������ ���� �������. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwSearchWinSaveDocumentList
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 //#UC START# *537076040297impl_uses*
 //#UC END# *537076040297impl_uses*
;

class function TkwSearchWinSaveDocumentList.GetWordNameForRegister: AnsiString;
begin
 Result := 'SearchWin:SaveDocumentList';
end;//TkwSearchWinSaveDocumentList.GetWordNameForRegister

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

initialization
 TkwSearchWinSaveDocumentList.RegisterInEngine;
 {* ����������� SearchWin_SaveDocumentList }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
