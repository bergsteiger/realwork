unit kwGetFontSize;
 {* Возвращает установленный размер шрифта для стиля "Нормальный". }

// Модуль: "w:\common\components\rtl\Garant\Keywords4Daily\kwGetFontSize.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "GetFontSize" MUID: (509B9A8A0270)
// Имя типа: "TkwGetFontSize"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwGetFontSize = {final} class(TtfwRegisterableWord)
  {* Возвращает установленный размер шрифта для стиля "Нормальный". }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGetFontSize
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evStyleInterface
 , SysUtils
;

procedure TkwGetFontSize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_509B9A8A0270_var*
var
 l_SI : TevStyleInterface;
//#UC END# *4DAEEDE10285_509B9A8A0270_var*
begin
//#UC START# *4DAEEDE10285_509B9A8A0270_impl*
 l_SI := TevStyleInterface.Make;
 try
  aCtx.rEngine.PushInt(l_SI.Font.Size);
 finally
  FreeAndNil(l_SI);
 end;
//#UC END# *4DAEEDE10285_509B9A8A0270_impl*
end;//TkwGetFontSize.DoDoIt

class function TkwGetFontSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetFontSize';
end;//TkwGetFontSize.GetWordNameForRegister

initialization
 TkwGetFontSize.RegisterInEngine;
 {* Регистрация GetFontSize }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
