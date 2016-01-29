unit TreeViewWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "TreeViewWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::TreeViewWords::TreeViewWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  ComCtrls,
  tfwScriptingInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  TreeNodeWordsPack,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopTreeViewGetItem = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:TreeView:GetItem
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 anIndex aTreeView pop:TreeView:GetItem >>> l_TTreeNode
[code]  }
 private
 // private methods
   function GetItem(const aCtx: TtfwContext;
    aTreeView: TTreeView;
    anIndex: Integer): TTreeNode;
     {* Реализация слова скрипта pop:TreeView:GetItem }
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
 end;//TkwPopTreeViewGetItem

// start class TkwPopTreeViewGetItem

function TkwPopTreeViewGetItem.GetItem(const aCtx: TtfwContext;
  aTreeView: TTreeView;
  anIndex: Integer): TTreeNode;
//#UC START# *76ED4B50CB4A_F4C36DEF11AB_var*
//#UC END# *76ED4B50CB4A_F4C36DEF11AB_var*
begin
//#UC START# *76ED4B50CB4A_F4C36DEF11AB_impl*
 Result := aTreeView.Items[anIndex];
//#UC END# *76ED4B50CB4A_F4C36DEF11AB_impl*
end;//TkwPopTreeViewGetItem.GetItem

procedure TkwPopTreeViewGetItem.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeView : TTreeView;
 l_anIndex : Integer;
begin
 try
  l_aTreeView := TTreeView(aCtx.rEngine.PopObjAs(TTreeView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTreeView: TTreeView : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj((GetItem(aCtx, l_aTreeView, l_anIndex)));
end;//TkwPopTreeViewGetItem.DoDoIt

class function TkwPopTreeViewGetItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeView:GetItem';
end;//TkwPopTreeViewGetItem.GetWordNameForRegister

function TkwPopTreeViewGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeViewGetItem.GetResultTypeInfo

function TkwPopTreeViewGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopTreeViewGetItem.GetAllParamsCount

function TkwPopTreeViewGetItem.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeView), TypeInfo(Integer)]);
end;//TkwPopTreeViewGetItem.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_TreeView_GetItem
 TkwPopTreeViewGetItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeView));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TTreeNode
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
{$IfEnd} //not NoScripts AND not NoVCL

end.