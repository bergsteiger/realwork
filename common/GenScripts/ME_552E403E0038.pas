unit StatusPanelWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\StatusPanelWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtStatusBar
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopStatusPanelGetText = {final} class(TtfwClassLike)
  {* Слово скрипта pop:vtStatusPanel:GetText
[panel]*Описание:* Возвращает текст панели
*Формат:* 
[code]
aPanel pop:vtStatusPanel:GetText
[code]
aPanel - объект класса TvtStatusPanel, который можно получить с помощью pop:vtStatusPanel:GetText[panel]
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aStatusPanel pop:vtStatusPanel:GetText >>> l_String
[code]  }
  private
   function GetText(const aCtx: TtfwContext;
    aStatusPanel: TvtStatusPanel): AnsiString;
    {* Реализация слова скрипта pop:vtStatusPanel:GetText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusPanelGetText

function TkwPopStatusPanelGetText.GetText(const aCtx: TtfwContext;
 aStatusPanel: TvtStatusPanel): AnsiString;
 {* Реализация слова скрипта pop:vtStatusPanel:GetText }
//#UC START# *D504B43B31FD_7D107A8BDD1A_var*
//#UC END# *D504B43B31FD_7D107A8BDD1A_var*
begin
//#UC START# *D504B43B31FD_7D107A8BDD1A_impl*
 Result := aStatusPanel.Text;
//#UC END# *D504B43B31FD_7D107A8BDD1A_impl*
end;//TkwPopStatusPanelGetText.GetText

procedure TkwPopStatusPanelGetText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7D107A8BDD1A_var*
//#UC END# *4DAEEDE10285_7D107A8BDD1A_var*
begin
//#UC START# *4DAEEDE10285_7D107A8BDD1A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7D107A8BDD1A_impl*
end;//TkwPopStatusPanelGetText.DoDoIt

class function TkwPopStatusPanelGetText.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:vtStatusPanel:GetText';
end;//TkwPopStatusPanelGetText.GetWordNameForRegister

function TkwPopStatusPanelGetText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7D107A8BDD1A_var*
//#UC END# *551544E2001A_7D107A8BDD1A_var*
begin
//#UC START# *551544E2001A_7D107A8BDD1A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7D107A8BDD1A_impl*
end;//TkwPopStatusPanelGetText.GetResultTypeInfo

function TkwPopStatusPanelGetText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopStatusPanelGetText.GetAllParamsCount

function TkwPopStatusPanelGetText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7D107A8BDD1A_var*
//#UC END# *5617F4D00243_7D107A8BDD1A_var*
begin
//#UC START# *5617F4D00243_7D107A8BDD1A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7D107A8BDD1A_impl*
end;//TkwPopStatusPanelGetText.ParamsTypes

initialization
 TkwPopStatusPanelGetText.RegisterInEngine;
 {* Регистрация pop_StatusPanel_GetText }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
 {* Регистрация типа TvtStatusPanel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts)

end.
