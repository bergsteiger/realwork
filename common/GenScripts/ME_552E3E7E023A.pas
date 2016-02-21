unit StatusBarWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtStatusBar
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopStatusBarGetPanel = {final} class(TtfwClassLike)
  {* Слово скрипта pop:vtStatusBar:GetPanel
[panel]*Описание:* Помещает в стек панель статусбара по номеру.
Формат:
[code]
anIndex aStatusControl pop:vtStatusBar:GetPanel
[code]
anIndex - номер панели.
aStatusControl - контрол статус-бар.
В стек помещается объект класса TvtStatusPanel[panel]
*Тип результата:* TvtStatusPanel
*Пример:*
[code]
OBJECT VAR l_TvtStatusPanel
 anIndex aStatusBar pop:vtStatusBar:GetPanel >>> l_TvtStatusPanel
[code]  }
  private
   function GetPanel(const aCtx: TtfwContext;
    aStatusBar: TvtStatusBar;
    anIndex: Integer): TvtStatusPanel;
    {* Реализация слова скрипта pop:vtStatusBar:GetPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusBarGetPanel

function TkwPopStatusBarGetPanel.GetPanel(const aCtx: TtfwContext;
 aStatusBar: TvtStatusBar;
 anIndex: Integer): TvtStatusPanel;
 {* Реализация слова скрипта pop:vtStatusBar:GetPanel }
//#UC START# *2B3EB01EE00A_0B36D9E86F88_var*
//#UC END# *2B3EB01EE00A_0B36D9E86F88_var*
begin
//#UC START# *2B3EB01EE00A_0B36D9E86F88_impl*
 Result := aStatusBar.Panels.Items[anIndex];
//#UC END# *2B3EB01EE00A_0B36D9E86F88_impl*
end;//TkwPopStatusBarGetPanel.GetPanel

procedure TkwPopStatusBarGetPanel.DoDoIt(const aCtx: TtfwContext);
var l_aStatusBar: TvtStatusBar;
var l_anIndex: Integer;
begin
 try
  l_aStatusBar := TvtStatusBar(aCtx.rEngine.PopObjAs(TvtStatusBar));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStatusBar: TvtStatusBar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPanel(aCtx, l_aStatusBar, l_anIndex));
end;//TkwPopStatusBarGetPanel.DoDoIt

class function TkwPopStatusBarGetPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:vtStatusBar:GetPanel';
end;//TkwPopStatusBarGetPanel.GetWordNameForRegister

function TkwPopStatusBarGetPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtStatusPanel);
end;//TkwPopStatusBarGetPanel.GetResultTypeInfo

function TkwPopStatusBarGetPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopStatusBarGetPanel.GetAllParamsCount

function TkwPopStatusBarGetPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtStatusBar), TypeInfo(Integer)]);
end;//TkwPopStatusBarGetPanel.ParamsTypes

initialization
 TkwPopStatusBarGetPanel.RegisterInEngine;
 {* Регистрация pop_StatusBar_GetPanel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusBar));
 {* Регистрация типа TvtStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
 {* Регистрация типа TvtStatusPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
