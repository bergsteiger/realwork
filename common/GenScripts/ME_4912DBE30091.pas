unit nsTreeUtils;
 {* общие функции для работы с деревом }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsTreeUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , eeInterfaces
 , l3Tree_TLB
 , l3TreeInterfaces
 , BaseTreeSupportUnit
 , UnderControlUnit
 , FiltersUnit
;

function GetTwinNode(const aTree: Il3SimpleTree;
 const aNode: INodeBase): INodeBase;
 {* поиск в переданном дереве ноды, эквивалентной "чужой" ноде, пришедшей из
     query, например. Вероятно надобность отпадёт после починки нового дерева - нет ничего более посстоянного, чем временное }
function NodeInvertExpandedCollapsed(const eeTreeView: IeeTreeView): Boolean;
function FindOnAdapterNode(const aTree: IeeTree;
 const aAdapterNode: INode): IeeNode; overload;
function FindOnAdapterNode(const aRoot: IeeNode;
 const aAdapterNode: INode): IeeNode; overload;
function FindOnAdapterNode(const aRoot: Il3Node;
 const aAdapterNode: INode): Il3Node; overload;
function FindOnControllable(const aRoot: Il3Node;
 const aControllable: IControllable): Il3Node;
procedure DeselectAllNodesInTree(const aTree: IeeTree);
function FindOnFilter(const aRoot: IeeNode;
 const aFilter: IFilterFromQuery): IeeNode; overload;
function FindOnFilter(const aRoot: Il3Node;
 const aFilter: IFilterFromQuery): Il3Node; overload;

implementation

uses
 l3ImplUses
 , SysUtils
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , l3Nodes
;

function GetTwinNode(const aTree: Il3SimpleTree;
 const aNode: INodeBase): INodeBase;
 {* поиск в переданном дереве ноды, эквивалентной "чужой" ноде, пришедшей из
     query, например. Вероятно надобность отпадёт после починки нового дерева - нет ничего более посстоянного, чем временное }
//#UC START# *4912DC1303B0_4912DBE30091_var*
var
 l_Root      : INodeBase;
 l_NodeIndex : Integer;
//#UC END# *4912DC1303B0_4912DBE30091_var*
begin
//#UC START# *4912DC1303B0_4912DBE30091_impl*
 Result := nil;
 if Supports(aTree.RootNode, INodeBase, l_Root) then
 try
  try
   l_NodeIndex := l_Root.GetVisibleDelta(aNode);
   if not aTree.ShowRoot then
    dec(l_NodeIndex);
  except
   on ENotFound do
    l_NodeIndex := -1; // Ничего не нашли, вернем -1
  end;{try..except}
  if l_NodeIndex >= 0 then
   Result := aTree.Nodes[l_NodeIndex] as INodeBase;
 finally
  l_Root := nil;
 end;{try..finally}
//#UC END# *4912DC1303B0_4912DBE30091_impl*
end;//GetTwinNode

function NodeInvertExpandedCollapsed(const eeTreeView: IeeTreeView): Boolean;
//#UC START# *4912DC4002C5_4912DBE30091_var*
var
 l_eeNode : IeeNode;
 l_Flags : Integer;
//#UC END# *4912DC4002C5_4912DBE30091_var*
begin
//#UC START# *4912DC4002C5_4912DBE30091_impl*
 Result := False;
//
 l_eeNode := eeTreeView.CurrentNode;
 if (l_eeNode = nil) then
  Exit;
 if (not l_eeNode.HasChild) then
  Exit;
//
 l_Flags := eeTreeView.NodeFlags[l_eeNode];
 if ((l_Flags and nfExpanded) = 0) then
  l_Flags := (l_Flags or nfExpanded)
 else
  l_Flags := (l_Flags and not(nfExpanded));
 eeTreeView.NodeFlags[l_eeNode] := l_Flags;
//
 Result := True;
//#UC END# *4912DC4002C5_4912DBE30091_impl*
end;//NodeInvertExpandedCollapsed

function FindOnAdapterNode(const aTree: IeeTree;
 const aAdapterNode: INode): IeeNode;
//#UC START# *4912DC5203B4_4912DBE30091_var*

 function FindNode(const anIntf: IeeNode) : Boolean;
 var
  l_IterNode : INode;
 begin
  Result := Supports(anIntf, INode, l_IterNode) and
            aAdapterNode.IsSameNode(l_IterNode);
  l_IterNode := nil;
 end;

//#UC END# *4912DC5203B4_4912DBE30091_var*
begin
//#UC START# *4912DC5203B4_4912DBE30091_impl*
 Result := aTree.IterateF(eeL2NA(@FindNode), imCheckResult);
//#UC END# *4912DC5203B4_4912DBE30091_impl*
end;//FindOnAdapterNode

function FindOnAdapterNode(const aRoot: IeeNode;
 const aAdapterNode: INode): IeeNode;
//#UC START# *4912DC6803CB_4912DBE30091_var*

 function FindNode(const anIntf: IeeNode) : Boolean;
 var
  l_IterNode : INode;
 begin
  Result := Supports(anIntf, INode, l_IterNode) and
            aAdapterNode.IsSameNode(l_IterNode);
  l_IterNode := nil;
 end;

//#UC END# *4912DC6803CB_4912DBE30091_var*
begin
//#UC START# *4912DC6803CB_4912DBE30091_impl*
  Result := aRoot.IterateF(eeL2NA(@FindNode), imCheckResult or imParentNeed);
//#UC END# *4912DC6803CB_4912DBE30091_impl*
end;//FindOnAdapterNode

function FindOnAdapterNode(const aRoot: Il3Node;
 const aAdapterNode: INode): Il3Node;
//#UC START# *4912DC8500F0_4912DBE30091_var*

 function FindNode(const anIntf: Il3Node) : Boolean;
 var
  l_IterNode : INode;
 begin
  Result := Supports(anIntf, INode, l_IterNode) and
            aAdapterNode.IsSameNode(l_IterNode);
  l_IterNode := nil;
 end;

//#UC END# *4912DC8500F0_4912DBE30091_var*
begin
//#UC START# *4912DC8500F0_4912DBE30091_impl*
 Result := aRoot.IterateF(l3L2NA(@FindNode), imCheckResult or imParentNeed);
//#UC END# *4912DC8500F0_4912DBE30091_impl*
end;//FindOnAdapterNode

function FindOnControllable(const aRoot: Il3Node;
 const aControllable: IControllable): Il3Node;
//#UC START# *4912DC9B037B_4912DBE30091_var*

 function FindNode(const anIntf: Il3Node) : Boolean;
 var
  l_Controllable : IControllable;
 begin
  if Supports(anIntf, IControllable, l_Controllable) then
   try
    Result := aControllable.IsSameControllable(l_Controllable);
   finally
    l_Controllable := nil;
   end//try..finally
  else
   Result := false;
 end;

//#UC END# *4912DC9B037B_4912DBE30091_var*
begin
//#UC START# *4912DC9B037B_4912DBE30091_impl*
 Result := aRoot.IterateF(l3L2NA(@FindNode), imCheckResult);
//#UC END# *4912DC9B037B_4912DBE30091_impl*
end;//FindOnControllable

procedure DeselectAllNodesInTree(const aTree: IeeTree);
//#UC START# *4912DCC60049_4912DBE30091_var*
//#UC END# *4912DCC60049_4912DBE30091_var*
begin
//#UC START# *4912DCC60049_4912DBE30091_impl*
 aTree.ClearSelected;
//#UC END# *4912DCC60049_4912DBE30091_impl*
end;//DeselectAllNodesInTree

function FindOnFilter(const aRoot: IeeNode;
 const aFilter: IFilterFromQuery): IeeNode;
//#UC START# *4CB2FE6701DB_4912DBE30091_var*
 function FindNode(const anIntf: IeeNode) : Boolean;
 var
  l_Filter : IFilterFromQuery;
 begin
  if Supports(anIntf, IFilterFromQuery, l_Filter) then
   try
    Result := aFilter.IsSame(l_Filter);
   finally
    l_Filter := nil;
   end//try..finally
  else
   Result := false;
 end;
//#UC END# *4CB2FE6701DB_4912DBE30091_var*
begin
//#UC START# *4CB2FE6701DB_4912DBE30091_impl*
 Result := aRoot.IterateF(eeL2NA(@FindNode), imCheckResult or imParentNeed);
//#UC END# *4CB2FE6701DB_4912DBE30091_impl*
end;//FindOnFilter

function FindOnFilter(const aRoot: Il3Node;
 const aFilter: IFilterFromQuery): Il3Node;
//#UC START# *4F991AC20207_4912DBE30091_var*
 function FindNode(const anIntf: Il3Node) : Boolean;
 var
  l_Filter : IFilterFromQuery;
 begin
  if Supports(anIntf, IFilterFromQuery, l_Filter) then
   try
    Result := aFilter.IsSame(l_Filter);
   finally
    l_Filter := nil;
   end//try..finally
  else
   Result := false;
 end;
//#UC END# *4F991AC20207_4912DBE30091_var*
begin
//#UC START# *4F991AC20207_4912DBE30091_impl*
 Result := aRoot.IterateF(l3L2NA(@FindNode), imCheckResult or imParentNeed);
//#UC END# *4F991AC20207_4912DBE30091_impl*
end;//FindOnFilter

end.
