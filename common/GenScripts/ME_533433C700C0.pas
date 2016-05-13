unit kwClearFindDialog;
 {* ������� ������ ������ (������� ��� ������). }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearFindDialog.pas"
// ���������: "ScriptKeyword"
// ������� ������: "ClearFindDialog" MUID: (533433C700C0)
// ��� ����: "TkwClearFindDialog"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearFindDialog = {final} class(TtfwRegisterableWord)
  {* ������� ������ ������ (������� ��� ������). }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearFindDialog
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , D_TxSrch
;

class function TkwClearFindDialog.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearFindDialog';
end;//TkwClearFindDialog.GetWordNameForRegister

procedure TkwClearFindDialog.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_533433C700C0_var*
//#UC END# *4DAEEDE10285_533433C700C0_var*
begin
//#UC START# *4DAEEDE10285_533433C700C0_impl*
 TTextSearchDlg.ClearFindWindow
//#UC END# *4DAEEDE10285_533433C700C0_impl*
end;//TkwClearFindDialog.DoDoIt

initialization
 TkwClearFindDialog.RegisterInEngine;
 {* ����������� ClearFindDialog }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
