unit kwBeginWaitPrint;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwBeginWaitPrint.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "BeginWait_Print" MUID: (4F72B9B00169)
// Имя типа: "TkwBeginWaitPrint"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwBeginWaitPrint = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwBeginWaitPrint
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(InsiderTest)}
 , kwPrintDataSaver
 {$IfEnd} // Defined(InsiderTest)
 //#UC START# *4F72B9B00169impl_uses*
 //#UC END# *4F72B9B00169impl_uses*
;

class function TkwBeginWaitPrint.GetWordNameForRegister: AnsiString;
begin
 Result := 'BeginWait:Print';
end;//TkwBeginWaitPrint.GetWordNameForRegister

procedure TkwBeginWaitPrint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F72B9B00169_var*
//#UC END# *4DAEEDE10285_4F72B9B00169_var*
begin
//#UC START# *4DAEEDE10285_4F72B9B00169_impl*
 {$If defined(InsiderTest)}
 TkwPrintDataSaver.Instance.StartWaitingToPrint(aCtx);
 {$IfEnd}
//#UC END# *4DAEEDE10285_4F72B9B00169_impl*
end;//TkwBeginWaitPrint.DoDoIt

initialization
 TkwBeginWaitPrint.RegisterInEngine;
 {* Регистрация BeginWait_Print }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
