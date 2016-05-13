unit TreeViewWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TreeViewWordsPack" MUID: (512F47C80388)

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
 , ComCtrls
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , TreeNodeWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopTreeViewGetItem = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeView:GetItem }
  private
   function GetItem(const aCtx: TtfwContext;
    aTreeView: TTreeView;
    anIndex: Integer): TTreeNode;
    {* Реализация слова скрипта pop:TreeView:GetItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeViewGetItem

function TkwPopTreeViewGetItem.GetItem(const aCtx: TtfwContext;
 aTreeView: TTreeView;
 anIndex: Integer): TTreeNode;
 {* Реализация слова скрипта pop:TreeView:GetItem }
//#UC START# *55C9CBCD0127_55C9CBCD0127_512F402F01BA_Word_var*
//#UC END# *55C9CBCD0127_55C9CBCD0127_512F402F01BA_Word_var*
begin
//#UC START# *55C9CBCD0127_55C9CBCD0127_512F402F01BA_Word_impl*
 Result := aTreeView.Items[anIndex];
//#UC END# *55C9CBCD0127_55C9CBCD0127_512F402F01BA_Word_impl*
end;//TkwPopTreeViewGetItem.GetItem

class function TkwPopTreeViewGetItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeView:GetItem';
end;//TkwPopTreeViewGetItem.GetWordNameForRegister

function TkwPopTreeViewGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTreeNode);
end;//TkwPopTreeViewGetItem.GetResultTypeInfo

function TkwPopTreeViewGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopTreeViewGetItem.GetAllParamsCount

function TkwPopTreeViewGetItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeView), TypeInfo(Integer)]);
end;//TkwPopTreeViewGetItem.ParamsTypes

procedure TkwPopTreeViewGetItem.DoDoIt(const aCtx: TtfwContext);
var l_aTreeView: TTreeView;
var l_anIndex: Integer;
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
 aCtx.rEngine.PushObj(GetItem(aCtx, l_aTreeView, l_anIndex));
end;//TkwPopTreeViewGetItem.DoDoIt

initialization
 TkwPopTreeViewGetItem.RegisterInEngine;
 {* Регистрация pop_TreeView_GetItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeView));
 {* Регистрация типа TTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
