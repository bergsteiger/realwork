unit kwAutoCompleteClear;
 {* Очищает данные автозамены. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwAutoCompleteClear.pas"
// Стереотип: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwAutoCompleteClear = {final} class(TtfwRegisterableWord)
  {* Очищает данные автозамены. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwAutoCompleteClear
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evAutoComplete
 {$IfEnd} // Defined(k2ForEditor)
;

procedure TkwAutoCompleteClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53CD0A6A03DF_var*
//#UC END# *4DAEEDE10285_53CD0A6A03DF_var*
begin
//#UC START# *4DAEEDE10285_53CD0A6A03DF_impl*
 if AutoComplete <> nil then
  AutoComplete.ClearDataAndSave;
//#UC END# *4DAEEDE10285_53CD0A6A03DF_impl*
end;//TkwAutoCompleteClear.DoDoIt

class function TkwAutoCompleteClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'AutoComplete:Clear';
end;//TkwAutoCompleteClear.GetWordNameForRegister

initialization
 TkwAutoCompleteClear.RegisterInEngine;
 {* Регистрация AutoComplete_Clear }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
