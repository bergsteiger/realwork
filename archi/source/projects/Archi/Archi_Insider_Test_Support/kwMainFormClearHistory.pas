unit kwMainFormClearHistory;
 {* Очищает историю переходов по документам. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormClearHistory.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "MainForm_ClearHistory" MUID: (5370939A008D)
// Имя типа: "TkwMainFormClearHistory"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMainFormClearHistory = {final} class(TtfwRegisterableWord)
  {* Очищает историю переходов по документам. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwMainFormClearHistory
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Main
;

class function TkwMainFormClearHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainForm:ClearHistory';
end;//TkwMainFormClearHistory.GetWordNameForRegister

procedure TkwMainFormClearHistory.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5370939A008D_var*
//#UC END# *4DAEEDE10285_5370939A008D_var*
begin
//#UC START# *4DAEEDE10285_5370939A008D_impl*
 MainForm.ClearHistory;
//#UC END# *4DAEEDE10285_5370939A008D_impl*
end;//TkwMainFormClearHistory.DoDoIt

initialization
 TkwMainFormClearHistory.RegisterInEngine;
 {* Регистрация MainForm_ClearHistory }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
