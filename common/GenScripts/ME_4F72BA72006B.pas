unit kwEndWaitPrint;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEndWaitPrint = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEndWaitPrint
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(InsiderTest)}
 , kwPrintDataSaver
 {$IfEnd} // Defined(InsiderTest)
;

procedure TkwEndWaitPrint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F72BA72006B_var*
//#UC END# *4DAEEDE10285_4F72BA72006B_var*
begin
//#UC START# *4DAEEDE10285_4F72BA72006B_impl*
 {$If defined(InsiderTest)}
 TkwPrintDataSaver.Instance.EndWatingToPrint;
 {$IfEnd}
//#UC END# *4DAEEDE10285_4F72BA72006B_impl*
end;//TkwEndWaitPrint.DoDoIt

class function TkwEndWaitPrint.GetWordNameForRegister: AnsiString;
begin
 Result := 'EndWait:Print';
end;//TkwEndWaitPrint.GetWordNameForRegister

initialization
 TkwEndWaitPrint.RegisterInEngine;
 {* Регистрация EndWait_Print }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
