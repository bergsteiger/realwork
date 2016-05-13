unit StatusPanelWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\StatusPanelWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "StatusPanelWordsPack" MUID: (552E403E0038)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vtStatusBar
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopStatusPanelGetText = {final} class(TtfwClassLike)
  {* Слово скрипта pop:vtStatusPanel:GetText }
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
//#UC START# *552E40740003_7D107A8BDD1A_var*
//#UC END# *552E40740003_7D107A8BDD1A_var*
begin
//#UC START# *552E40740003_7D107A8BDD1A_impl*
 Result := aStatusPanel.Text;
//#UC END# *552E40740003_7D107A8BDD1A_impl*
end;//TkwPopStatusPanelGetText.GetText

procedure TkwPopStatusPanelGetText.DoDoIt(const aCtx: TtfwContext);
var l_aStatusPanel: TvtStatusPanel;
begin
 try
  l_aStatusPanel := TvtStatusPanel(aCtx.rEngine.PopObjAs(TvtStatusPanel));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStatusPanel: TvtStatusPanel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(GetText(aCtx, l_aStatusPanel));
end;//TkwPopStatusPanelGetText.DoDoIt

class function TkwPopStatusPanelGetText.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:vtStatusPanel:GetText';
end;//TkwPopStatusPanelGetText.GetWordNameForRegister

function TkwPopStatusPanelGetText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopStatusPanelGetText.GetResultTypeInfo

function TkwPopStatusPanelGetText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopStatusPanelGetText.GetAllParamsCount

function TkwPopStatusPanelGetText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtStatusPanel)]);
end;//TkwPopStatusPanelGetText.ParamsTypes

initialization
 TkwPopStatusPanelGetText.RegisterInEngine;
 {* Регистрация pop_StatusPanel_GetText }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
 {* Регистрация типа TvtStatusPanel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
