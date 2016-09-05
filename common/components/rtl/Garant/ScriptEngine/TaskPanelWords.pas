unit TaskPanelWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TaskPanelWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TaskPanelWords" MUID: (5101345E0143)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *5101345E0143impl_uses*
 //#UC END# *5101345E0143impl_uses*
;

type
 TkwPopTaskPanelGetHideField = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TaskPanel:GetHideField }
  private
   function GetHideField(const aCtx: TtfwContext;
    aTaskPanel: TnscTasksPanelView;
    anIndex: Integer): TnscTasksPanelHideField;
    {* Реализация слова скрипта pop:TaskPanel:GetHideField }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTaskPanelGetHideField

 TkwPopTaskPanelCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:TaskPanel:Count }
  private
   function Count(const aCtx: TtfwContext;
    aTaskPanel: TnscTasksPanelView): Integer;
    {* Реализация слова скрипта pop:TaskPanel:Count }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopTaskPanelCount

function TkwPopTaskPanelGetHideField.GetHideField(const aCtx: TtfwContext;
 aTaskPanel: TnscTasksPanelView;
 anIndex: Integer): TnscTasksPanelHideField;
 {* Реализация слова скрипта pop:TaskPanel:GetHideField }
//#UC START# *552FCA800230_552FCA800230_4D3424C203C2_Word_var*
//#UC END# *552FCA800230_552FCA800230_4D3424C203C2_Word_var*
begin
//#UC START# *552FCA800230_552FCA800230_4D3424C203C2_Word_impl*
 Result := aTaskPanel.HideField[anIndex];
//#UC END# *552FCA800230_552FCA800230_4D3424C203C2_Word_impl*
end;//TkwPopTaskPanelGetHideField.GetHideField

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

function TkwPopTaskPanelCount.Count(const aCtx: TtfwContext;
 aTaskPanel: TnscTasksPanelView): Integer;
 {* Реализация слова скрипта pop:TaskPanel:Count }
begin
 Result := aTaskPanel.Count;
end;//TkwPopTaskPanelCount.Count

class function TkwPopTaskPanelCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TaskPanel:Count';
end;//TkwPopTaskPanelCount.GetWordNameForRegister

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

procedure TkwPopTaskPanelCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwPopTaskPanelCount.SetValuePrim

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

initialization
 TkwPopTaskPanelGetHideField.RegisterInEngine;
 {* Регистрация pop_TaskPanel_GetHideField }
 TkwPopTaskPanelCount.RegisterInEngine;
 {* Регистрация pop_TaskPanel_Count }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
 {* Регистрация типа TnscTasksPanelView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelHideField));
 {* Регистрация типа TnscTasksPanelHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
