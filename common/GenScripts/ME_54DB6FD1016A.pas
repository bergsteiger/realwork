unit StatusBarButtonWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarButtonWords.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscStatusBarButton
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

implementation

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopStatusBarButtonIsDown = {final} class(TtfwClassLike)
  {* Слово скрипта pop:StatusBarButton:IsDown
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aStatusBarButton pop:StatusBarButton:IsDown >>> l_Boolean
[code]  }
  private
   function IsDown(const aCtx: TtfwContext;
    aStatusBarButton: TnscStatusBarButton): Boolean;
    {* Реализация слова скрипта pop:StatusBarButton:IsDown }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusBarButtonIsDown

function TkwPopStatusBarButtonIsDown.IsDown(const aCtx: TtfwContext;
 aStatusBarButton: TnscStatusBarButton): Boolean;
 {* Реализация слова скрипта pop:StatusBarButton:IsDown }
//#UC START# *8D82AE1A2B57_33C559B72437_var*
//#UC END# *8D82AE1A2B57_33C559B72437_var*
begin
//#UC START# *8D82AE1A2B57_33C559B72437_impl*
 Result := aStatusBarButton.Down;
//#UC END# *8D82AE1A2B57_33C559B72437_impl*
end;//TkwPopStatusBarButtonIsDown.IsDown

procedure TkwPopStatusBarButtonIsDown.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_33C559B72437_var*
//#UC END# *4DAEEDE10285_33C559B72437_var*
begin
//#UC START# *4DAEEDE10285_33C559B72437_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_33C559B72437_impl*
end;//TkwPopStatusBarButtonIsDown.DoDoIt

class function TkwPopStatusBarButtonIsDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:StatusBarButton:IsDown';
end;//TkwPopStatusBarButtonIsDown.GetWordNameForRegister

function TkwPopStatusBarButtonIsDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopStatusBarButtonIsDown.GetResultTypeInfo

function TkwPopStatusBarButtonIsDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopStatusBarButtonIsDown.GetAllParamsCount

function TkwPopStatusBarButtonIsDown.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_33C559B72437_var*
//#UC END# *5617F4D00243_33C559B72437_var*
begin
//#UC START# *5617F4D00243_33C559B72437_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_33C559B72437_impl*
end;//TkwPopStatusBarButtonIsDown.ParamsTypes

initialization
 TkwPopStatusBarButtonIsDown.RegisterInEngine;
 {* Регистрация pop_StatusBarButton_IsDown }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBarButton));
 {* Регистрация типа TnscStatusBarButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

end.
