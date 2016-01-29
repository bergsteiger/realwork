unit ActionListWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$RTLandVCL"
// ������: "ActionListWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::FormsProcessing::ActionListWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  ActnList,
  tfwScriptingInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  ContainedActionsWordspack,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopActionListFindAction = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:ActionList:FindAction
*��� ����������:* TContainedAction
*������:*
[code]
OBJECT VAR l_TContainedAction
 anActionName aActionList pop:ActionList:FindAction >>> l_TContainedAction
[code]  }
 private
 // private methods
   function FindAction(const aCtx: TtfwContext;
    aActionList: TActionList;
    const anActionName: AnsiString): TContainedAction;
     {* ���������� ����� ������� pop:ActionList:FindAction }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopActionListFindAction

// start class TkwPopActionListFindAction

function TkwPopActionListFindAction.FindAction(const aCtx: TtfwContext;
  aActionList: TActionList;
  const anActionName: AnsiString): TContainedAction;
//#UC START# *1F5508BF0CF4_E7F049DA4A74_var*
var
 l_Index : Integer;
//#UC END# *1F5508BF0CF4_E7F049DA4A74_var*
begin
//#UC START# *1F5508BF0CF4_E7F049DA4A74_impl*
 Result := nil;
 for l_Index := 0 to aActionList.ActionCount - 1 do
 begin
  Result := aActionList.Actions[l_Index];
  if (Result.Name = anActionName) then
   Break
  else
   Result := nil;
 end; // for i := 0 to l_ActList.ActionCount - 1 do
//#UC END# *1F5508BF0CF4_E7F049DA4A74_impl*
end;//TkwPopActionListFindAction.FindAction

procedure TkwPopActionListFindAction.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aActionList : TActionList;
 l_anActionName : AnsiString;
begin
 try
  l_aActionList := TActionList(aCtx.rEngine.PopObjAs(TActionList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aActionList: TActionList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anActionName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anActionName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FindAction(aCtx, l_aActionList, l_anActionName)));
end;//TkwPopActionListFindAction.DoDoIt

class function TkwPopActionListFindAction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ActionList:FindAction';
end;//TkwPopActionListFindAction.GetWordNameForRegister

function TkwPopActionListFindAction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TContainedAction);
end;//TkwPopActionListFindAction.GetResultTypeInfo

function TkwPopActionListFindAction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopActionListFindAction.GetAllParamsCount

function TkwPopActionListFindAction.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TActionList), TypeInfo(AnsiString)]);
end;//TkwPopActionListFindAction.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� pop_ActionList_FindAction
 TkwPopActionListFindAction.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� TActionList
 TtfwTypeRegistrator.RegisterType(TypeInfo(TActionList));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� TContainedAction
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContainedAction));
{$IfEnd} //not NoScripts AND not NoVCL

end.