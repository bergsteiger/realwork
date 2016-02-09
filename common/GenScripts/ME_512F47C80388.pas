unit TreeViewWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TreeViewWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , ComCtrls
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , TreeNodeWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTreeViewGetItem = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeView:GetItem
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 anIndex aTreeView pop:TreeView:GetItem >>> l_TTreeNode
[code]  }
  private
   function GetItem(const aCtx: TtfwContext;
    aTreeView: TTreeView;
    anIndex: Integer): TTreeNode;
    {* Реализация слова скрипта pop:TreeView:GetItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeViewGetItem

function TkwPopTreeViewGetItem.GetItem(const aCtx: TtfwContext;
 aTreeView: TTreeView;
 anIndex: Integer): TTreeNode;
 {* Реализация слова скрипта pop:TreeView:GetItem }
//#UC START# *76ED4B50CB4A_F4C36DEF11AB_var*
//#UC END# *76ED4B50CB4A_F4C36DEF11AB_var*
begin
//#UC START# *76ED4B50CB4A_F4C36DEF11AB_impl*
 Result := aTreeView.Items[anIndex];
//#UC END# *76ED4B50CB4A_F4C36DEF11AB_impl*
end;//TkwPopTreeViewGetItem.GetItem

procedure TkwPopTreeViewGetItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4C36DEF11AB_var*
//#UC END# *4DAEEDE10285_F4C36DEF11AB_var*
begin
//#UC START# *4DAEEDE10285_F4C36DEF11AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4C36DEF11AB_impl*
end;//TkwPopTreeViewGetItem.DoDoIt

class function TkwPopTreeViewGetItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeView:GetItem';
end;//TkwPopTreeViewGetItem.GetWordNameForRegister

function TkwPopTreeViewGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F4C36DEF11AB_var*
//#UC END# *551544E2001A_F4C36DEF11AB_var*
begin
//#UC START# *551544E2001A_F4C36DEF11AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F4C36DEF11AB_impl*
end;//TkwPopTreeViewGetItem.GetResultTypeInfo

function TkwPopTreeViewGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopTreeViewGetItem.GetAllParamsCount

function TkwPopTreeViewGetItem.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F4C36DEF11AB_var*
//#UC END# *5617F4D00243_F4C36DEF11AB_var*
begin
//#UC START# *5617F4D00243_F4C36DEF11AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F4C36DEF11AB_impl*
end;//TkwPopTreeViewGetItem.ParamsTypes

initialization
 TkwPopTreeViewGetItem.RegisterInEngine;
 {* Регистрация pop_TreeView_GetItem }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeView));
 {* Регистрация типа TTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
