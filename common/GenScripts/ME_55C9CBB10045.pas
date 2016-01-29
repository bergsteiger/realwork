unit TreeNodeWordsPack;

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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTreeNodeGetNext = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNext
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNext >>> l_TTreeNode
[code]  }
  function GetNext(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetNext }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetNext
 
 TkwPopTreeNodeHasChildren = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:HasChildren
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:HasChildren >>> l_Boolean
[code]  }
  function HasChildren(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): Boolean;
   {* Реализация слова скрипта pop:TreeNode:HasChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeHasChildren
 
 TkwPopTreeNodeGetPrev = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrev
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrev >>> l_TTreeNode
[code]  }
  function GetPrev(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetPrev }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetPrev
 
 TkwPopTreeNodeGetFirstChild = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetFirstChild
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetFirstChild >>> l_TTreeNode
[code]  }
  function GetFirstChild(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetFirstChild }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetFirstChild
 
 TkwPopTreeNodeGetLastChild = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetLastChild
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetLastChild >>> l_TTreeNode
[code]  }
  function GetLastChild(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetLastChild }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetLastChild
 
 TkwPopTreeNodeGetNextSibling = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNextSibling
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNextSibling >>> l_TTreeNode
[code]  }
  function GetNextSibling(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetNextSibling }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetNextSibling
 
 TkwPopTreeNodeGetPrevSibling = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrevSibling
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrevSibling >>> l_TTreeNode
[code]  }
  function GetPrevSibling(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetPrevSibling }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetPrevSibling
 
 TkwPopTreeNodeGetNextVisible = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetNextVisible
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNextVisible >>> l_TTreeNode
[code]  }
  function GetNextVisible(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetNextVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetNextVisible
 
 TkwPopTreeNodeGetPrevVisible = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:GetPrevVisible
*Тип результата:* TTreeNode
*Пример:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrevVisible >>> l_TTreeNode
[code]  }
  function GetPrevVisible(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* Реализация слова скрипта pop:TreeNode:GetPrevVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetPrevVisible
 
 TkwPopTreeNodeExpand = class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:Expand
*Пример:*
[code]
 aRecurse aTreeNode pop:TreeNode:Expand
[code]  }
  procedure Expand(const aCtx: TtfwContext;
   aTreeNode: TTreeNode;
   aRecurse: Boolean);
   {* Реализация слова скрипта pop:TreeNode:Expand }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeExpand
 
end.
