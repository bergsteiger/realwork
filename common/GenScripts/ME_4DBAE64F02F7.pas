unit kwRAISE;
 {* Зарезервированное слово RAISE. Аналогично raise из Delphi. Если не было исключения, то генерируется EtfwScriptException.
Пример:
[code]
TRY
 'Тестовое исключение' RAISE
EXCEPT
 true >>> WasException
END
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwRAISE.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwRAISE = class(TtfwRegisterableWord)
  {* Зарезервированное слово RAISE. Аналогично raise из Delphi. Если не было исключения, то генерируется EtfwScriptException.
Пример:
[code]
TRY
 'Тестовое исключение' RAISE
EXCEPT
 true >>> WasException
END
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwRAISE
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

procedure TkwRAISE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAE64F02F7_var*
type
 RException = class of Exception;
//#UC END# *4DAEEDE10285_4DBAE64F02F7_var*
begin
//#UC START# *4DAEEDE10285_4DBAE64F02F7_impl*
 if (aCtx.rException <> nil) then
  raise RException(aCtx.rException.ClassType).Create(aCtx.rException.Message)
 else
  raise EtfwScriptException.Create(aCtx.rEngine.PopDelphiString);
//#UC END# *4DAEEDE10285_4DBAE64F02F7_impl*
end;//TkwRAISE.DoDoIt

class function TkwRAISE.GetWordNameForRegister: AnsiString;
begin
 Result := 'RAISE';
end;//TkwRAISE.GetWordNameForRegister

initialization
 TkwRAISE.RegisterInEngine;
 {* Регистрация RAISE }
{$IfEnd} // NOT Defined(NoScripts)

end.
