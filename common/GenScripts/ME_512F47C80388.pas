unit TreeViewWordsPack;

interface

uses
 l3IntfUses
 , ComCtrls
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , TreeNodeWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTreeViewGetItem = class(TtfwClassLike)
  {* Слово скрипта pop:TreeView:GetItem
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 anIndex aTreeView pop:TreeView:GetItem >>> l_TTreeNode
[code]  }
  function GetItem(const aCtx: TtfwContext;
   aTreeView: TTreeView;
   anIndex: Integer): TTreeNode;
   {* Реализация слова скрипта pop:TreeView:GetItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeViewGetItem
 
end.
