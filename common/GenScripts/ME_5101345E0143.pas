unit TaskPanelWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TaskPanelWords.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTaskPanelGetHideField = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TaskPanel:GetHideField
*Тип результата:* TnscTasksPanelHideField
*Пример:*
[code]
OBJECT VAR l_TnscTasksPanelHideField
 anIndex aTaskPanel pop:TaskPanel:GetHideField >>> l_TnscTasksPanelHideField
[code]  }
  private
   function GetHideField(const aCtx: TtfwContext;
    aTaskPanel: TnscTasksPanelView;
    anIndex: Integer): TnscTasksPanelHideField;
    {* Реализация слова скрипта pop:TaskPanel:GetHideField }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTaskPanelGetHideField

 TkwPopTaskPanelCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:TaskPanel:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTaskPanel pop:TaskPanel:Count >>> l_Integer
[code]  }
  private
   function Count(const aCtx: TtfwContext;
    aTaskPanel: TnscTasksPanelView): Integer;
    {* Реализация слова скрипта pop:TaskPanel:Count }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTaskPanelCount

function TkwPopTaskPanelGetHideField.GetHideField(const aCtx: TtfwContext;
 aTaskPanel: TnscTasksPanelView;
 anIndex: Integer): TnscTasksPanelHideField;
 {* Реализация слова скрипта pop:TaskPanel:GetHideField }
//#UC START# *E1A1A40AC939_C357835C3D1B_var*
//#UC END# *E1A1A40AC939_C357835C3D1B_var*
begin
//#UC START# *E1A1A40AC939_C357835C3D1B_impl*
 Result := aTaskPanel.HideField[anIndex];
//#UC END# *E1A1A40AC939_C357835C3D1B_impl*
end;//TkwPopTaskPanelGetHideField.GetHideField

procedure TkwPopTaskPanelGetHideField.DoDoIt(const aCtx: TtfwContext);
var l_aTaskPanel: TnscTasksPanelView;
var l_anIndex: Integer;
begin
 try
  l_aTaskPanel := TnscTasksPanelView(aCtx.rEngine.PopObjAs(TnscTasksPanelView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTaskPanel: TnscTasksPanelView : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj(GetHideField(aCtx, l_aTaskPanel, l_anIndex));
end;//TkwPopTaskPanelGetHideField.DoDoIt

class function TkwPopTaskPanelGetHideField.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TaskPanel:GetHideField';
end;//TkwPopTaskPanelGetHideField.GetWordNameForRegister

function TkwPopTaskPanelGetHideField.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTasksPanelHideField);
end;//TkwPopTaskPanelGetHideField.GetResultTypeInfo

function TkwPopTaskPanelGetHideField.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopTaskPanelGetHideField.GetAllParamsCount

function TkwPopTaskPanelGetHideField.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnscTasksPanelView), TypeInfo(Integer)]);
end;//TkwPopTaskPanelGetHideField.ParamsTypes

function TkwPopTaskPanelCount.Count(const aCtx: TtfwContext;
 aTaskPanel: TnscTasksPanelView): Integer;
 {* Реализация слова скрипта pop:TaskPanel:Count }
//#UC START# *6CDE88AB26F2_C2B2EE13F5CE_var*
//#UC END# *6CDE88AB26F2_C2B2EE13F5CE_var*
begin
//#UC START# *6CDE88AB26F2_C2B2EE13F5CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *6CDE88AB26F2_C2B2EE13F5CE_impl*
end;//TkwPopTaskPanelCount.Count

procedure TkwPopTaskPanelCount.DoDoIt(const aCtx: TtfwContext);
var l_aTaskPanel: TnscTasksPanelView;
begin
 try
  l_aTaskPanel := TnscTasksPanelView(aCtx.rEngine.PopObjAs(TnscTasksPanelView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTaskPanel: TnscTasksPanelView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Count(aCtx, l_aTaskPanel));
end;//TkwPopTaskPanelCount.DoDoIt

class function TkwPopTaskPanelCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TaskPanel:Count';
end;//TkwPopTaskPanelCount.GetWordNameForRegister

procedure TkwPopTaskPanelCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_TaskPanel: TnscTasksPanelView;
begin
 try
  l_TaskPanel := TnscTasksPanelView(aCtx.rEngine.PopObjAs(TnscTasksPanelView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра TaskPanel: TnscTasksPanelView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 TaskPanel. := aValue.AsInt;
end;//TkwPopTaskPanelCount.SetValuePrim

function TkwPopTaskPanelCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopTaskPanelCount.GetResultTypeInfo

function TkwPopTaskPanelCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTaskPanelCount.GetAllParamsCount

function TkwPopTaskPanelCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnscTasksPanelView)]);
end;//TkwPopTaskPanelCount.ParamsTypes

initialization
 TkwPopTaskPanelGetHideField.RegisterInEngine;
 {* Регистрация pop_TaskPanel_GetHideField }
 TkwPopTaskPanelCount.RegisterInEngine;
 {* Регистрация pop_TaskPanel_Count }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
 {* Регистрация типа TnscTasksPanelView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelHideField));
 {* Регистрация типа TnscTasksPanelHideField }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
