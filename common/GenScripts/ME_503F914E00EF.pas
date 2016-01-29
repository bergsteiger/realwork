unit vtOutlinerWordsPack;

interface

uses
 l3IntfUses
 , vtOutliner
 , l3TreeInterfaces
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3Nodes
 , l3String
 , l3Interfaces
 , l3Chars
 , l3Types
 , l3Base
 , l3Filer
 , SysUtils
 , l3Tree_TLB
 , l3Bits
 , ImgList
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TvtOutlinerWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TvtOutlinerWordsPackResNameGetter
 
 TvtCustomOutlinerFriend = class(TvtCustomOutliner)
  {* ���� ��� TvtCustomOutliner }
 end;//TvtCustomOutlinerFriend
 
 TkwTreeCheckFlag = class(TtfwClassLike)
  {* ����� ������� tree:CheckFlag
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aNodeID aFlag aTree tree:CheckFlag >>> l_Boolean
[code]  }
  function tree_CheckFlag(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   aFlag: Integer;
   aNodeID: Integer): Boolean;
   {* ���������� ����� ������� tree:CheckFlag }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCheckFlag
 
 TkwTreeCollapseAll = class(TtfwClassLike)
  {* ����� ������� tree:CollapseAll
*������:*
[code]
 aTree tree:CollapseAll
[code]  }
  procedure tree_CollapseAll(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner);
   {* ���������� ����� ������� tree:CollapseAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCollapseAll
 
 TkwTreeCurrentNodeIsExpanded = class(TtfwClassLike)
  {* ����� ������� tree:CurrentNode:IsExpanded
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTree tree:CurrentNode:IsExpanded >>> l_Boolean
[code]  }
  function tree_CurrentNode_IsExpanded(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner): Boolean;
   {* ���������� ����� ������� tree:CurrentNode:IsExpanded }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCurrentNodeIsExpanded
 
 TkwTreeDeleteAllChildren = class(TtfwClassLike)
  {* ����� ������� tree:DeleteAllChildren
*������:*
[code]
 aTree tree:DeleteAllChildren
[code]  }
  procedure tree_DeleteAllChildren(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner);
   {* ���������� ����� ������� tree:DeleteAllChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeDeleteAllChildren
 
 TkwTreeExpandAll = class(TtfwClassLike)
  {* ����� ������� tree:ExpandAll
*������:*
[code]
 aTree tree:ExpandAll
[code]  }
  procedure tree_ExpandAll(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner);
   {* ���������� ����� ������� tree:ExpandAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeExpandAll
 
 TkwTreeCurrentNode = class(TtfwClassLike)
  {* ����� ������� tree:CurrentNode
*��� ����������:* Il3SimpleNode
*������:*
[code]
INTERFACE VAR l_Il3SimpleNode
 aTree tree:CurrentNode >>> l_Il3SimpleNode
[code]  }
  function tree_CurrentNode(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner): Il3SimpleNode;
   {* ���������� ����� ������� tree:CurrentNode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCurrentNode
 
 TkwTreeGetItem = class(TtfwClassLike)
  {* ����� ������� tree:GetItem
*��� ����������:* Il3SimpleNode
*������:*
[code]
INTERFACE VAR l_Il3SimpleNode
 anIndex aTree tree:GetItem >>> l_Il3SimpleNode
[code]  }
  function tree_GetItem(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Il3SimpleNode;
   {* ���������� ����� ������� tree:GetItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItem
 
 TkwTreeGetItemsCount = class(TtfwClassLike)
  {* ����� ������� tree:GetItemsCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aTree tree:GetItemsCount >>> l_Integer
[code]  }
  function tree_GetItemsCount(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner): Integer;
   {* ���������� ����� ������� tree:GetItemsCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemsCount
 
 TkwTreeIterateNodes = class(TtfwClassLike)
  {* ����� ������� tree:IterateNodes
*������:*
[code]
 aLambda aTree tree:IterateNodes
[code]  }
  procedure tree_IterateNodes(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   aLambda: TtfwWord);
   {* ���������� ����� ������� tree:IterateNodes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeIterateNodes
 
 TkwTreeSaveState2File = class(TtfwClassLike)
  {* ����� ������� tree:SaveState2File
*������:*
[code]
 aFileName aTree tree:SaveState2File
[code]  }
  procedure tree_SaveState2File(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   const aFileName: AnsiString);
   {* ���������� ����� ������� tree:SaveState2File }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeSaveState2File
 
 TkwTreeChildrenCount = class(TtfwClassLike)
  {* ����� ������� tree:ChildrenCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:ChildrenCount >>> l_Integer
[code]  }
  function tree_ChildrenCount(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� tree:ChildrenCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeChildrenCount
 
 TkwTreeExpand = class(TtfwClassLike)
  {* ����� ������� tree:����������
*������:*
[code]
 anIndex aTree tree:����������
[code]  }
  procedure tree_expand(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer);
   {* ���������� ����� ������� tree:���������� }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeExpand
 
 TkwTreeGetItemHeight = class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Height >>> l_Integer
[code]  }
  function tree_GetItem_Height(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� tree:GetItem:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemHeight
 
 TkwTreeGetItemImageIndex = class(TtfwClassLike)
  {* ����� ������� tree:GetItemImageIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItemImageIndex >>> l_Integer
[code]  }
  function tree_GetItemImageIndex(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� tree:GetItemImageIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemImageIndex
 
 TkwTreeGetItemLeft = class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Left
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Left >>> l_Integer
[code]  }
  function tree_GetItem_Left(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� tree:GetItem:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemLeft
 
 TkwTreeGetItemTop = class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Top
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Top >>> l_Integer
[code]  }
  function tree_GetItem_Top(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� tree:GetItem:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemTop
 
 TkwTreeGetItemWidth = class(TtfwClassLike)
  {* ����� ������� tree:GetItem:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Width >>> l_Integer
[code]  }
  function tree_GetItem_Width(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� tree:GetItem:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemWidth
 
 TkwTreeGetSelected = class(TtfwClassLike)
  {* ����� ������� tree:GetSelected
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aTree tree:GetSelected >>> l_Boolean
[code]  }
  function tree_GetSelected(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Boolean;
   {* ���������� ����� ������� tree:GetSelected }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetSelected
 
 TkwTreeSetSelected = class(TtfwClassLike)
  {* ����� ������� tree:SetSelected
*������:*
[code]
 aValue anIndex aTree tree:SetSelected
[code]  }
  procedure tree_SetSelected(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer;
   aValue: Boolean);
   {* ���������� ����� ������� tree:SetSelected }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeSetSelected
 
 TkwTreeCollapse = class(TtfwClassLike)
  {* ����� ������� tree:��������
*������:*
[code]
 anIndex aTree tree:��������
[code]  }
  procedure tree_collapse(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer);
   {* ���������� ����� ������� tree:�������� }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCollapse
 
end.
