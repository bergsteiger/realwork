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
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TvtOutlinerWordsPackResNameGetter
 
 TvtCustomOutlinerFriend = class(TvtCustomOutliner)
  {* Друг для TvtCustomOutliner }
 end;//TvtCustomOutlinerFriend
 
 TkwTreeCheckFlag = class(TtfwClassLike)
  {* Слово скрипта tree:CheckFlag
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aNodeID aFlag aTree tree:CheckFlag >>> l_Boolean
[code]  }
  function tree_CheckFlag(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   aFlag: Integer;
   aNodeID: Integer): Boolean;
   {* Реализация слова скрипта tree:CheckFlag }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCheckFlag
 
 TkwTreeCollapseAll = class(TtfwClassLike)
  {* Слово скрипта tree:CollapseAll
*Пример:*
[code]
 aTree tree:CollapseAll
[code]  }
  procedure tree_CollapseAll(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner);
   {* Реализация слова скрипта tree:CollapseAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCollapseAll
 
 TkwTreeCurrentNodeIsExpanded = class(TtfwClassLike)
  {* Слово скрипта tree:CurrentNode:IsExpanded
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTree tree:CurrentNode:IsExpanded >>> l_Boolean
[code]  }
  function tree_CurrentNode_IsExpanded(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner): Boolean;
   {* Реализация слова скрипта tree:CurrentNode:IsExpanded }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCurrentNodeIsExpanded
 
 TkwTreeDeleteAllChildren = class(TtfwClassLike)
  {* Слово скрипта tree:DeleteAllChildren
*Пример:*
[code]
 aTree tree:DeleteAllChildren
[code]  }
  procedure tree_DeleteAllChildren(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner);
   {* Реализация слова скрипта tree:DeleteAllChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeDeleteAllChildren
 
 TkwTreeExpandAll = class(TtfwClassLike)
  {* Слово скрипта tree:ExpandAll
*Пример:*
[code]
 aTree tree:ExpandAll
[code]  }
  procedure tree_ExpandAll(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner);
   {* Реализация слова скрипта tree:ExpandAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeExpandAll
 
 TkwTreeCurrentNode = class(TtfwClassLike)
  {* Слово скрипта tree:CurrentNode
*Тип результата:* Il3SimpleNode
*Пример:*
[code]
INTERFACE VAR l_Il3SimpleNode
 aTree tree:CurrentNode >>> l_Il3SimpleNode
[code]  }
  function tree_CurrentNode(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner): Il3SimpleNode;
   {* Реализация слова скрипта tree:CurrentNode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCurrentNode
 
 TkwTreeGetItem = class(TtfwClassLike)
  {* Слово скрипта tree:GetItem
*Тип результата:* Il3SimpleNode
*Пример:*
[code]
INTERFACE VAR l_Il3SimpleNode
 anIndex aTree tree:GetItem >>> l_Il3SimpleNode
[code]  }
  function tree_GetItem(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Il3SimpleNode;
   {* Реализация слова скрипта tree:GetItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItem
 
 TkwTreeGetItemsCount = class(TtfwClassLike)
  {* Слово скрипта tree:GetItemsCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTree tree:GetItemsCount >>> l_Integer
[code]  }
  function tree_GetItemsCount(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner): Integer;
   {* Реализация слова скрипта tree:GetItemsCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemsCount
 
 TkwTreeIterateNodes = class(TtfwClassLike)
  {* Слово скрипта tree:IterateNodes
*Пример:*
[code]
 aLambda aTree tree:IterateNodes
[code]  }
  procedure tree_IterateNodes(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   aLambda: TtfwWord);
   {* Реализация слова скрипта tree:IterateNodes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeIterateNodes
 
 TkwTreeSaveState2File = class(TtfwClassLike)
  {* Слово скрипта tree:SaveState2File
*Пример:*
[code]
 aFileName aTree tree:SaveState2File
[code]  }
  procedure tree_SaveState2File(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   const aFileName: AnsiString);
   {* Реализация слова скрипта tree:SaveState2File }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeSaveState2File
 
 TkwTreeChildrenCount = class(TtfwClassLike)
  {* Слово скрипта tree:ChildrenCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:ChildrenCount >>> l_Integer
[code]  }
  function tree_ChildrenCount(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта tree:ChildrenCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeChildrenCount
 
 TkwTreeExpand = class(TtfwClassLike)
  {* Слово скрипта tree:развернуть
*Пример:*
[code]
 anIndex aTree tree:развернуть
[code]  }
  procedure tree_expand(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer);
   {* Реализация слова скрипта tree:развернуть }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeExpand
 
 TkwTreeGetItemHeight = class(TtfwClassLike)
  {* Слово скрипта tree:GetItem:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Height >>> l_Integer
[code]  }
  function tree_GetItem_Height(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта tree:GetItem:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemHeight
 
 TkwTreeGetItemImageIndex = class(TtfwClassLike)
  {* Слово скрипта tree:GetItemImageIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItemImageIndex >>> l_Integer
[code]  }
  function tree_GetItemImageIndex(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта tree:GetItemImageIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemImageIndex
 
 TkwTreeGetItemLeft = class(TtfwClassLike)
  {* Слово скрипта tree:GetItem:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Left >>> l_Integer
[code]  }
  function tree_GetItem_Left(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта tree:GetItem:Left }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemLeft
 
 TkwTreeGetItemTop = class(TtfwClassLike)
  {* Слово скрипта tree:GetItem:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Top >>> l_Integer
[code]  }
  function tree_GetItem_Top(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта tree:GetItem:Top }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemTop
 
 TkwTreeGetItemWidth = class(TtfwClassLike)
  {* Слово скрипта tree:GetItem:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex aTree tree:GetItem:Width >>> l_Integer
[code]  }
  function tree_GetItem_Width(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта tree:GetItem:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetItemWidth
 
 TkwTreeGetSelected = class(TtfwClassLike)
  {* Слово скрипта tree:GetSelected
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aTree tree:GetSelected >>> l_Boolean
[code]  }
  function tree_GetSelected(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer): Boolean;
   {* Реализация слова скрипта tree:GetSelected }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeGetSelected
 
 TkwTreeSetSelected = class(TtfwClassLike)
  {* Слово скрипта tree:SetSelected
*Пример:*
[code]
 aValue anIndex aTree tree:SetSelected
[code]  }
  procedure tree_SetSelected(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer;
   aValue: Boolean);
   {* Реализация слова скрипта tree:SetSelected }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeSetSelected
 
 TkwTreeCollapse = class(TtfwClassLike)
  {* Слово скрипта tree:свернуть
*Пример:*
[code]
 anIndex aTree tree:свернуть
[code]  }
  procedure tree_collapse(const aCtx: TtfwContext;
   aTree: TvtCustomOutliner;
   anIndex: Integer);
   {* Реализация слова скрипта tree:свернуть }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTreeCollapse
 
end.
