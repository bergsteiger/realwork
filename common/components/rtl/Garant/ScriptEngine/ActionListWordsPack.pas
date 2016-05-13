unit ActionListWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ActionListWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ActionListWordsPack" MUID: (55B8E44302B1)

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
 , ContainedActionsWordspack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopActionListFindAction = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ActionList:FindAction }
  private
   function FindAction(const aCtx: TtfwContext;
    aActionList: TActionList;
    const anActionName: AnsiString): TContainedAction;
    {* Реализация слова скрипта pop:ActionList:FindAction }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopActionListFindAction

function TkwPopActionListFindAction.FindAction(const aCtx: TtfwContext;
 aActionList: TActionList;
 const anActionName: AnsiString): TContainedAction;
 {* Реализация слова скрипта pop:ActionList:FindAction }
//#UC START# *55B8E46F00AF_E7F049DA4A74_var*
var
 l_Index : Integer;
//#UC END# *55B8E46F00AF_E7F049DA4A74_var*
begin
//#UC START# *55B8E46F00AF_E7F049DA4A74_impl*
 Result := nil;
 for l_Index := 0 to aActionList.ActionCount - 1 do
 begin
  Result := aActionList.Actions[l_Index];
  if (Result.Name = anActionName) then
   Break
  else
   Result := nil;
 end; // for i := 0 to l_ActList.ActionCount - 1 do
//#UC END# *55B8E46F00AF_E7F049DA4A74_impl*
end;//TkwPopActionListFindAction.FindAction

procedure TkwPopActionListFindAction.DoDoIt(const aCtx: TtfwContext);
var l_aActionList: TActionList;
var l_anActionName: AnsiString;
begin
 try
  l_aActionList := TActionList(aCtx.rEngine.PopObjAs(TActionList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aActionList: TActionList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anActionName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anActionName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindAction(aCtx, l_aActionList, l_anActionName));
end;//TkwPopActionListFindAction.DoDoIt

class function TkwPopActionListFindAction.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ActionList:FindAction';
end;//TkwPopActionListFindAction.GetWordNameForRegister

function TkwPopActionListFindAction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TContainedAction);
end;//TkwPopActionListFindAction.GetResultTypeInfo

function TkwPopActionListFindAction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopActionListFindAction.GetAllParamsCount

function TkwPopActionListFindAction.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TActionList), @tfw_tiString]);
end;//TkwPopActionListFindAction.ParamsTypes

initialization
 TkwPopActionListFindAction.RegisterInEngine;
 {* Регистрация pop_ActionList_FindAction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TActionList));
 {* Регистрация типа TActionList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContainedAction));
 {* Регистрация типа TContainedAction }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
