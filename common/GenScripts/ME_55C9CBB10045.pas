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
  {* ����� ������� pop:TreeNode:GetNext
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNext >>> l_TTreeNode
[code]  }
  function GetNext(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetNext }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetNext
 
 TkwPopTreeNodeHasChildren = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:HasChildren
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:HasChildren >>> l_Boolean
[code]  }
  function HasChildren(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): Boolean;
   {* ���������� ����� ������� pop:TreeNode:HasChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeHasChildren
 
 TkwPopTreeNodeGetPrev = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetPrev
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrev >>> l_TTreeNode
[code]  }
  function GetPrev(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetPrev }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetPrev
 
 TkwPopTreeNodeGetFirstChild = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetFirstChild
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetFirstChild >>> l_TTreeNode
[code]  }
  function GetFirstChild(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetFirstChild }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetFirstChild
 
 TkwPopTreeNodeGetLastChild = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetLastChild
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetLastChild >>> l_TTreeNode
[code]  }
  function GetLastChild(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetLastChild }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetLastChild
 
 TkwPopTreeNodeGetNextSibling = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetNextSibling
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNextSibling >>> l_TTreeNode
[code]  }
  function GetNextSibling(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetNextSibling }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetNextSibling
 
 TkwPopTreeNodeGetPrevSibling = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetPrevSibling
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrevSibling >>> l_TTreeNode
[code]  }
  function GetPrevSibling(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetPrevSibling }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetPrevSibling
 
 TkwPopTreeNodeGetNextVisible = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetNextVisible
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetNextVisible >>> l_TTreeNode
[code]  }
  function GetNextVisible(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetNextVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetNextVisible
 
 TkwPopTreeNodeGetPrevVisible = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:GetPrevVisible
*��� ����������:* TTreeNode
*������:*
[code]
OBJECT VAR l_TTreeNode
 aTreeNode pop:TreeNode:GetPrevVisible >>> l_TTreeNode
[code]  }
  function GetPrevVisible(const aCtx: TtfwContext;
   aTreeNode: TTreeNode): TTreeNode;
   {* ���������� ����� ������� pop:TreeNode:GetPrevVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeGetPrevVisible
 
 TkwPopTreeNodeExpand = class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:Expand
*������:*
[code]
 aRecurse aTreeNode pop:TreeNode:Expand
[code]  }
  procedure Expand(const aCtx: TtfwContext;
   aTreeNode: TTreeNode;
   aRecurse: Boolean);
   {* ���������� ����� ������� pop:TreeNode:Expand }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTreeNodeExpand
 
end.
