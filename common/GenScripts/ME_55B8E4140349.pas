unit ContainedActionsWordspack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ContainedActionsWordspack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ActnList
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopContainedActionExecute = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ContainedAction:Execute
*Пример:*
[code]
 aContainedAction pop:ContainedAction:Execute
[code]  }
  private
   procedure Execute(const aCtx: TtfwContext;
    aContainedAction: TContainedAction);
    {* Реализация слова скрипта pop:ContainedAction:Execute }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopContainedActionExecute

procedure TkwPopContainedActionExecute.Execute(const aCtx: TtfwContext;
 aContainedAction: TContainedAction);
 {* Реализация слова скрипта pop:ContainedAction:Execute }
//#UC START# *AFC4E3ACD81B_87D5D18D9F8E_var*
//#UC END# *AFC4E3ACD81B_87D5D18D9F8E_var*
begin
//#UC START# *AFC4E3ACD81B_87D5D18D9F8E_impl*
 aContainedAction.Execute;
//#UC END# *AFC4E3ACD81B_87D5D18D9F8E_impl*
end;//TkwPopContainedActionExecute.Execute

procedure TkwPopContainedActionExecute.DoDoIt(const aCtx: TtfwContext);
var l_aContainedAction: TContainedAction;
begin
 try
  l_aContainedAction := TContainedAction(aCtx.rEngine.PopObjAs(TContainedAction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContainedAction: TContainedAction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Execute(aCtx, l_aContainedAction);
end;//TkwPopContainedActionExecute.DoDoIt

class function TkwPopContainedActionExecute.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ContainedAction:Execute';
end;//TkwPopContainedActionExecute.GetWordNameForRegister

function TkwPopContainedActionExecute.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopContainedActionExecute.GetResultTypeInfo

function TkwPopContainedActionExecute.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopContainedActionExecute.GetAllParamsCount

function TkwPopContainedActionExecute.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContainedAction)]);
end;//TkwPopContainedActionExecute.ParamsTypes

initialization
 TkwPopContainedActionExecute.RegisterInEngine;
 {* Регистрация pop_ContainedAction_Execute }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContainedAction));
 {* Регистрация типа TContainedAction }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
