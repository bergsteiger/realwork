unit ContainedActionsWordspack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ContainedActionsWordspack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , ActnList
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
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
//#UC START# *4DAEEDE10285_87D5D18D9F8E_var*
//#UC END# *4DAEEDE10285_87D5D18D9F8E_var*
begin
//#UC START# *4DAEEDE10285_87D5D18D9F8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_87D5D18D9F8E_impl*
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
//#UC START# *5617F4D00243_87D5D18D9F8E_var*
//#UC END# *5617F4D00243_87D5D18D9F8E_var*
begin
//#UC START# *5617F4D00243_87D5D18D9F8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_87D5D18D9F8E_impl*
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
