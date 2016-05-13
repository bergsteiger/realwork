unit kwClearFindDialog;
 {* Очищает диалог поиска (удаляет его объект). }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearFindDialog.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ClearFindDialog" MUID: (533433C700C0)
// Имя типа: "TkwClearFindDialog"

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
  {* Очищает диалог поиска (удаляет его объект). }
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
 {* Регистрация ClearFindDialog }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
