unit l3SimpleTree;
 {* "Простое" дерево. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3SimpleTree.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _l3NotifierBase_Parent_ = Tl3CacheableBase;
 {$Include w:\common\components\rtl\Garant\L3\l3NotifierBase.imp.pas}
 Tl3SimpleTree = class(_l3NotifierBase_, Il3SimpleTree)
  {* "Простое" дерево. }
  private
   f_ShowRoot: Boolean;
   f_Root: Il3SimpleRootNode;
    {* Корень дерева }
  protected
   procedure RootChanged(const aOld: Il3SimpleRootNode;
    const aNew: Il3SimpleRootNode);
   function Get_RootNode: Il3SimpleRootNode;
   procedure Set_RootNode(const aValue: Il3SimpleRootNode);
   procedure CursorTop;
    {* переставить курсор на первый видимый элемент. }
   function GetIndex(const aNode: Il3SimpleNode;
    const aSubRootNode: Il3SimpleNode = nil): Integer;
    {* возвращает видимый индекс aNode относительно aSubRootNode или корня. }
   function GetLevel(const aNode: Il3SimpleNode): Integer;
    {* возвращает уровень узла относительно корня. }
   procedure SelectAllNodes(aMode: Tl3SetBitType);
    {* выделяет/развыделяет все узлы. }
   procedure SelectInterval(aFirstIndex: Integer;
    aLastIndex: Integer;
    aMode: Tl3SetBitType;
    aCleanOther: Boolean);
    {* выделяет/развыделяет узлы на указанном интервале. }
   function ChangeExpand(const aNode: Il3SimpleNode;
    aMode: Tl3SetBitType;
    aForceMode: Boolean = False): Boolean;
    {* меняет развернутость узла. }
   procedure ExpandSubDir(const aNode: Il3SimpleNode = nil;
    anExpand: Boolean = True;
    aDeepLevel: Byte = 0);
    {* развернуть/свернуть узлы. }
   procedure SetBranchFlag(const aParentNode: Il3SimpleNode;
    aMode: Tl3SetBitType;
    aFlagsMask: Integer;
    anIterMode: Integer);
    {* зачем-то используется визуалкой в ExpandNode. }
   function CountViewItemsInSubDir(const aNode: Il3SimpleNode): Integer;
    {* зачем-то используется визуалкой в ShowMoreChildrenOnScreen. }
   function IsRoot(const aNode: Il3SimpleNode): Boolean;
    {* является ли узел корневым для дерева. }
   function IsExpanded(const aNode: Il3SimpleNode): Boolean;
    {* раскрыт ли узел. }
   function IsFirstVis(const aNode: Il3SimpleNode): Boolean;
    {* является ли узел первым видимым в ветке. }
   function IsLastVis(const aNode: Il3SimpleNode): Boolean;
    {* является ли узел последним видимым в ветке. }
   function HasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
    {* есть ли видимые дети у aNode. }
   function GetLines(const aNode: Il3SimpleNode): Integer;
    {* маска для рисования линий (надо смотреть реализацию). }
   function Wake: Boolean;
    {* проснись!!! Типа начали рисовать. }
   function MoveNode(const aNode: Il3SimpleNode;
    aDirection: Tl3Direction): Boolean;
    {* переместить узел. }
   function SearchNameBegin(const aFirstNode: Il3SimpleNode;
    aSrchStr: PAnsiChar;
    aIterMode: Integer): Il3SimpleNode;
    {* зачем-то используется визуалкой в CharToItem. }
   function SearchNameOccur(const aFirstNode: Il3SimpleNode;
    aSrchStr: PAnsiChar;
    aIterMode: Integer): Il3SimpleNode;
    {* зачем-то используется визуалкой в SearchOccurStr,  который сейчас никем не используется. }
   function MakeNodeVisible(const aNode: Il3SimpleNode): Integer;
    {* зачем-то используется визуалкой в CharToItem, видимо для перемещения курсора на узел. }
   function GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode;
    {* предыдущий узел. Зачем-то используется в CharToItem. }
   function SimpleIterateF(Action: Tl3SimpleNodeAction;
    IterMode: Integer = 0;
    const aSubRootNode: Il3SimpleNode = nil): Il3SimpleNode;
    {* перебрать все узлы и освободить заглушку для Action. IterMode: imCheckResult, imParentNeed }
   function IsChanging: Boolean;
    {* дерево находится в фазе обновления. }
   procedure Changing;
   procedure Changed;
   function Get_ShowRoot: Boolean;
   procedure Set_ShowRoot(aValue: Boolean);
   function Get_CountView: Integer;
   function Get_SelectCount: Integer;
   function Get_Flags(anIndex: Integer): Integer;
   function Get_Select(anIndex: Integer): Boolean;
   procedure Set_Select(anIndex: Integer;
    aValue: Boolean);
   function Get_Nodes(anIndex: Integer): Il3SimpleNode;
   function MakeDataObject(const aNode: Il3SimpleNode;
    const aBitmap: IUnknown): IDataObject;
    {* сделать объект данных дерева, используется при перемещении элементов дерева в другие компоненты }
   function CanAcceptData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData): Boolean;
   function DropData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aRoot: Il3SimpleRootNode); reintroduce;
   class function Make(const aRoot: Il3SimpleRootNode): Il3SimpleTree; reintroduce;
 end;//Tl3SimpleTree

implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Bits
 , l3Types
 , l3Base
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3NotifierBase.imp.pas}

constructor Tl3SimpleTree.Create(const aRoot: Il3SimpleRootNode);
//#UC START# *48724FD5009D_48724DAD02E0_var*
//#UC END# *48724FD5009D_48724DAD02E0_var*
begin
//#UC START# *48724FD5009D_48724DAD02E0_impl*
 inherited Create;
 f_Root := aRoot;
//#UC END# *48724FD5009D_48724DAD02E0_impl*
end;//Tl3SimpleTree.Create

class function Tl3SimpleTree.Make(const aRoot: Il3SimpleRootNode): Il3SimpleTree;
var
 l_Inst : Tl3SimpleTree;
begin
 l_Inst := Create(aRoot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3SimpleTree.Make

procedure Tl3SimpleTree.RootChanged(const aOld: Il3SimpleRootNode;
 const aNew: Il3SimpleRootNode);
//#UC START# *487252020055_48724DAD02E0_var*
var
 l_Index : Integer;
 l_Spy   : Il3RootSpy;
 l_Item  : IUnknown;
//#UC END# *487252020055_48724DAD02E0_var*
begin
//#UC START# *487252020055_48724DAD02E0_impl*
 if HasNotified then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := IUnknown(NotifiedObjList.Items[l_Index]);
   if Supports(l_Item, Il3RootSpy, l_Spy) and (l_Item = l_Spy) then
    l_Spy.RootChanged(aOld, aNew);
  end;//if (NotifiedObjList <> nil)
//#UC END# *487252020055_48724DAD02E0_impl*
end;//Tl3SimpleTree.RootChanged

function Tl3SimpleTree.Get_RootNode: Il3SimpleRootNode;
//#UC START# *46825CAA0125_48724DAD02E0get_var*
//#UC END# *46825CAA0125_48724DAD02E0get_var*
begin
//#UC START# *46825CAA0125_48724DAD02E0get_impl*
 Result := f_Root;
//#UC END# *46825CAA0125_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_RootNode

procedure Tl3SimpleTree.Set_RootNode(const aValue: Il3SimpleRootNode);
//#UC START# *46825CAA0125_48724DAD02E0set_var*
var
 l_OldRoot : Il3SimpleRootNode;
//#UC END# *46825CAA0125_48724DAD02E0set_var*
begin
//#UC START# *46825CAA0125_48724DAD02E0set_impl*
 if not l3IEQ(f_Root, aValue) then
 begin
  l_OldRoot := f_Root;
  try
   //DropCountView;
   f_Root := aValue;
   CursorTop;
   RootChanged(l_OldRoot, aValue);
  finally
   l_OldRoot := nil;
  end;//try..finally
 end;//not l3IEQ(f_Root, aValue)
//#UC END# *46825CAA0125_48724DAD02E0set_impl*
end;//Tl3SimpleTree.Set_RootNode

procedure Tl3SimpleTree.CursorTop;
 {* переставить курсор на первый видимый элемент. }
//#UC START# *4772448C01D2_48724DAD02E0_var*
//#UC END# *4772448C01D2_48724DAD02E0_var*
begin
//#UC START# *4772448C01D2_48724DAD02E0_impl*
 // - пока ничего не делаем
//#UC END# *4772448C01D2_48724DAD02E0_impl*
end;//Tl3SimpleTree.CursorTop

function Tl3SimpleTree.GetIndex(const aNode: Il3SimpleNode;
 const aSubRootNode: Il3SimpleNode = nil): Integer;
 {* возвращает видимый индекс aNode относительно aSubRootNode или корня. }
//#UC START# *4772449B00A1_48724DAD02E0_var*
var
 l_Root : Il3SimpleNode;
//#UC END# *4772449B00A1_48724DAD02E0_var*
begin
//#UC START# *4772449B00A1_48724DAD02E0_impl*
 if (aNode = nil) then
  Result := -1
 else
 begin
  if (aSubRootNode = nil) then
   l_Root := f_Root
  else
   l_Root := aSubRootNode;
  if aNode.IsSame(l_Root) then
   Result := 0
  else
   Result := aNode.IndexInParent + 1;
  if not f_ShowRoot then
   Dec(Result);
 end;//aNode = nil
//#UC END# *4772449B00A1_48724DAD02E0_impl*
end;//Tl3SimpleTree.GetIndex

function Tl3SimpleTree.GetLevel(const aNode: Il3SimpleNode): Integer;
 {* возвращает уровень узла относительно корня. }
//#UC START# *477244BA0074_48724DAD02E0_var*
//#UC END# *477244BA0074_48724DAD02E0_var*
begin
//#UC START# *477244BA0074_48724DAD02E0_impl*
 if (aNode = nil) then
  Result := 0
 else
 begin
  Result := aNode.GetLevelFor(f_Root);
// Сейчас не нужно, т.к. в дереве корректируется  
//  if not ShowRoot then
//   Dec(Result);
 end;
//#UC END# *477244BA0074_48724DAD02E0_impl*
end;//Tl3SimpleTree.GetLevel

procedure Tl3SimpleTree.SelectAllNodes(aMode: Tl3SetBitType);
 {* выделяет/развыделяет все узлы. }
//#UC START# *477244CE02AE_48724DAD02E0_var*
//#UC END# *477244CE02AE_48724DAD02E0_var*
begin
//#UC START# *477244CE02AE_48724DAD02E0_impl*
 Assert(false);
//#UC END# *477244CE02AE_48724DAD02E0_impl*
end;//Tl3SimpleTree.SelectAllNodes

procedure Tl3SimpleTree.SelectInterval(aFirstIndex: Integer;
 aLastIndex: Integer;
 aMode: Tl3SetBitType;
 aCleanOther: Boolean);
 {* выделяет/развыделяет узлы на указанном интервале. }
//#UC START# *477244DD0292_48724DAD02E0_var*
//#UC END# *477244DD0292_48724DAD02E0_var*
begin
//#UC START# *477244DD0292_48724DAD02E0_impl*
 Assert(false);
//#UC END# *477244DD0292_48724DAD02E0_impl*
end;//Tl3SimpleTree.SelectInterval

function Tl3SimpleTree.ChangeExpand(const aNode: Il3SimpleNode;
 aMode: Tl3SetBitType;
 aForceMode: Boolean = False): Boolean;
 {* меняет развернутость узла. }
//#UC START# *47724512002D_48724DAD02E0_var*
//#UC END# *47724512002D_48724DAD02E0_var*
begin
//#UC START# *47724512002D_48724DAD02E0_impl*
 Assert(false);
 Result := false;
//#UC END# *47724512002D_48724DAD02E0_impl*
end;//Tl3SimpleTree.ChangeExpand

procedure Tl3SimpleTree.ExpandSubDir(const aNode: Il3SimpleNode = nil;
 anExpand: Boolean = True;
 aDeepLevel: Byte = 0);
 {* развернуть/свернуть узлы. }
//#UC START# *4772452E002D_48724DAD02E0_var*
//#UC END# *4772452E002D_48724DAD02E0_var*
begin
//#UC START# *4772452E002D_48724DAD02E0_impl*
 Assert(false);
//#UC END# *4772452E002D_48724DAD02E0_impl*
end;//Tl3SimpleTree.ExpandSubDir

procedure Tl3SimpleTree.SetBranchFlag(const aParentNode: Il3SimpleNode;
 aMode: Tl3SetBitType;
 aFlagsMask: Integer;
 anIterMode: Integer);
 {* зачем-то используется визуалкой в ExpandNode. }
//#UC START# *477245520298_48724DAD02E0_var*
//#UC END# *477245520298_48724DAD02E0_var*
begin
//#UC START# *477245520298_48724DAD02E0_impl*
 Assert(false);
//#UC END# *477245520298_48724DAD02E0_impl*
end;//Tl3SimpleTree.SetBranchFlag

function Tl3SimpleTree.CountViewItemsInSubDir(const aNode: Il3SimpleNode): Integer;
 {* зачем-то используется визуалкой в ShowMoreChildrenOnScreen. }
//#UC START# *4772457D032A_48724DAD02E0_var*
//#UC END# *4772457D032A_48724DAD02E0_var*
begin
//#UC START# *4772457D032A_48724DAD02E0_impl*
 Assert(false);
 Result := 0;
//#UC END# *4772457D032A_48724DAD02E0_impl*
end;//Tl3SimpleTree.CountViewItemsInSubDir

function Tl3SimpleTree.IsRoot(const aNode: Il3SimpleNode): Boolean;
 {* является ли узел корневым для дерева. }
//#UC START# *477245A20228_48724DAD02E0_var*
//#UC END# *477245A20228_48724DAD02E0_var*
begin
//#UC START# *477245A20228_48724DAD02E0_impl*
 Result := (f_Root <> nil) AND (aNode <> nil) AND f_Root.IsSame(aNode);
//#UC END# *477245A20228_48724DAD02E0_impl*
end;//Tl3SimpleTree.IsRoot

function Tl3SimpleTree.IsExpanded(const aNode: Il3SimpleNode): Boolean;
 {* раскрыт ли узел. }
//#UC START# *477245B301DE_48724DAD02E0_var*
//#UC END# *477245B301DE_48724DAD02E0_var*
begin
//#UC START# *477245B301DE_48724DAD02E0_impl*
 Result := true;
//#UC END# *477245B301DE_48724DAD02E0_impl*
end;//Tl3SimpleTree.IsExpanded

function Tl3SimpleTree.IsFirstVis(const aNode: Il3SimpleNode): Boolean;
 {* является ли узел первым видимым в ветке. }
//#UC START# *477245C40171_48724DAD02E0_var*
//#UC END# *477245C40171_48724DAD02E0_var*
begin
//#UC START# *477245C40171_48724DAD02E0_impl*
 if (aNode = nil) then
  Result := true
 else
  Result := aNode.IsFirst; 
//#UC END# *477245C40171_48724DAD02E0_impl*
end;//Tl3SimpleTree.IsFirstVis

function Tl3SimpleTree.IsLastVis(const aNode: Il3SimpleNode): Boolean;
 {* является ли узел последним видимым в ветке. }
//#UC START# *477245D9031B_48724DAD02E0_var*
//#UC END# *477245D9031B_48724DAD02E0_var*
begin
//#UC START# *477245D9031B_48724DAD02E0_impl*
 if (aNode = nil) then
  Result := true
 else
  Result := aNode.IsLast;
//#UC END# *477245D9031B_48724DAD02E0_impl*
end;//Tl3SimpleTree.IsLastVis

function Tl3SimpleTree.HasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
 {* есть ли видимые дети у aNode. }
//#UC START# *477245F301AE_48724DAD02E0_var*
//#UC END# *477245F301AE_48724DAD02E0_var*
begin
//#UC START# *477245F301AE_48724DAD02E0_impl*
 if (aNode = nil) then
  Result := false
 else
  Result := aNode.HasChild; 
//#UC END# *477245F301AE_48724DAD02E0_impl*
end;//Tl3SimpleTree.HasVisibleChildren

function Tl3SimpleTree.GetLines(const aNode: Il3SimpleNode): Integer;
 {* маска для рисования линий (надо смотреть реализацию). }
//#UC START# *477246040221_48724DAD02E0_var*
var
 lCNode  : Il3SimpleNode;
//#UC END# *477246040221_48724DAD02E0_var*
begin
//#UC START# *477246040221_48724DAD02E0_impl*
 with f_Root do
  if IsSame(aNode) then
   Result := 0
  else
  begin
   Result := 1;
   lCNode := aNode.Parent;
   if (lCNode = nil) then
    Result := 0
   else
   begin
    while not IsSame(lCNode) do
    begin
     Result := Result shl 1;
     If not IsLastVis(lCNode) then l3SetBit(Result, 0);

     lCNode := lCNode.Parent;
     If lCNode = nil then Exit;
    end;
   end;//lCNode = nil
  end;//IsSame(aNode)
//#UC END# *477246040221_48724DAD02E0_impl*
end;//Tl3SimpleTree.GetLines

function Tl3SimpleTree.Wake: Boolean;
 {* проснись!!! Типа начали рисовать. }
//#UC START# *4772461601C6_48724DAD02E0_var*
//#UC END# *4772461601C6_48724DAD02E0_var*
begin
//#UC START# *4772461601C6_48724DAD02E0_impl*
 Result := false; // - мы типа и не спали
//#UC END# *4772461601C6_48724DAD02E0_impl*
end;//Tl3SimpleTree.Wake

function Tl3SimpleTree.MoveNode(const aNode: Il3SimpleNode;
 aDirection: Tl3Direction): Boolean;
 {* переместить узел. }
//#UC START# *477246270133_48724DAD02E0_var*
//#UC END# *477246270133_48724DAD02E0_var*
begin
//#UC START# *477246270133_48724DAD02E0_impl*
 Result := false; // !STUB!
//#UC END# *477246270133_48724DAD02E0_impl*
end;//Tl3SimpleTree.MoveNode

function Tl3SimpleTree.SearchNameBegin(const aFirstNode: Il3SimpleNode;
 aSrchStr: PAnsiChar;
 aIterMode: Integer): Il3SimpleNode;
 {* зачем-то используется визуалкой в CharToItem. }
//#UC START# *477246440037_48724DAD02E0_var*
//#UC END# *477246440037_48724DAD02E0_var*
begin
//#UC START# *477246440037_48724DAD02E0_impl*
 Result := nil; // !STUB!
//#UC END# *477246440037_48724DAD02E0_impl*
end;//Tl3SimpleTree.SearchNameBegin

function Tl3SimpleTree.SearchNameOccur(const aFirstNode: Il3SimpleNode;
 aSrchStr: PAnsiChar;
 aIterMode: Integer): Il3SimpleNode;
 {* зачем-то используется визуалкой в SearchOccurStr,  который сейчас никем не используется. }
//#UC START# *4772465F0276_48724DAD02E0_var*
//#UC END# *4772465F0276_48724DAD02E0_var*
begin
//#UC START# *4772465F0276_48724DAD02E0_impl*
 Result := nil; // !STUB!
//#UC END# *4772465F0276_48724DAD02E0_impl*
end;//Tl3SimpleTree.SearchNameOccur

function Tl3SimpleTree.MakeNodeVisible(const aNode: Il3SimpleNode): Integer;
 {* зачем-то используется визуалкой в CharToItem, видимо для перемещения курсора на узел. }
//#UC START# *477246860169_48724DAD02E0_var*
//#UC END# *477246860169_48724DAD02E0_var*
begin
//#UC START# *477246860169_48724DAD02E0_impl*
 Result := GetIndex(aNode);
//#UC END# *477246860169_48724DAD02E0_impl*
end;//Tl3SimpleTree.MakeNodeVisible

function Tl3SimpleTree.GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode;
 {* предыдущий узел. Зачем-то используется в CharToItem. }
//#UC START# *477246A40174_48724DAD02E0_var*
//#UC END# *477246A40174_48724DAD02E0_var*
begin
//#UC START# *477246A40174_48724DAD02E0_impl*
 Result := nil; // !STUB!
//#UC END# *477246A40174_48724DAD02E0_impl*
end;//Tl3SimpleTree.GetPrev

function Tl3SimpleTree.SimpleIterateF(Action: Tl3SimpleNodeAction;
 IterMode: Integer = 0;
 const aSubRootNode: Il3SimpleNode = nil): Il3SimpleNode;
 {* перебрать все узлы и освободить заглушку для Action. IterMode: imCheckResult, imParentNeed }
//#UC START# *477246C70141_48724DAD02E0_var*
var
 l_RootNode : Il3SimpleNode;
 l_Stop     : Boolean;
//#UC END# *477246C70141_48724DAD02E0_var*
begin
//#UC START# *477246C70141_48724DAD02E0_impl*
 try
  if aSubRootNode = nil then
   l_RootNode := f_Root
  else
   l_RootNode := l_RootNode;
  Result := l_RootNode.Child;
  while (Result <> nil) do
  begin
   l_Stop := Action(Result);
   if l_Stop AND l3TestMask(IterMode, imCheckResult) then
    break;
   Result := Result.Next;  
  end;//while (Result <> nil)
 finally
  l3FreeFA(Tl3FreeAction(Action));
 end;//try..finally
//#UC END# *477246C70141_48724DAD02E0_impl*
end;//Tl3SimpleTree.SimpleIterateF

function Tl3SimpleTree.IsChanging: Boolean;
 {* дерево находится в фазе обновления. }
//#UC START# *477246E802B1_48724DAD02E0_var*
//#UC END# *477246E802B1_48724DAD02E0_var*
begin
//#UC START# *477246E802B1_48724DAD02E0_impl*
 Result := false;
//#UC END# *477246E802B1_48724DAD02E0_impl*
end;//Tl3SimpleTree.IsChanging

procedure Tl3SimpleTree.Changing;
//#UC START# *477246F7039B_48724DAD02E0_var*
var
 l_Index : Integer;
 l_Intf  : Il3ChangeRecipient;
 l_Item  : IUnknown;
//#UC END# *477246F7039B_48724DAD02E0_var*
begin
//#UC START# *477246F7039B_48724DAD02E0_impl*
 if (NotifiedObjList <> nil) then
  for l_Index := NotifiedObjList.Hi downto 0 do
   try
    l_Item := IUnknown(f_NotifiedObjList[l_Index]);
    if Supports(l_Item, Il3ChangeRecipient, l_Intf) AND
       (l_Item = l_Intf) then
     try
      l_Intf.Changing;
     finally
      l_Intf := nil;
     end;//try..finaly
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end;
//#UC END# *477246F7039B_48724DAD02E0_impl*
end;//Tl3SimpleTree.Changing

procedure Tl3SimpleTree.Changed;
//#UC START# *4772470100BC_48724DAD02E0_var*
var
 l_Index : Integer;
 l_Intf  : Il3ChangeRecipient;
 l_Item  : IUnknown;
 l_Expt  : Boolean;
//#UC END# *4772470100BC_48724DAD02E0_var*
begin
//#UC START# *4772470100BC_48724DAD02E0_impl*
 l_Expt := false;
 try
  if (NotifiedObjList <> nil) then
   for l_Index := NotifiedObjList.Hi downto 0 do
    try
     l_Item := IUnknown(f_NotifiedObjList[l_Index]);
     if Supports(l_Item, Il3ChangeRecipient, l_Intf) AND
        (l_Item = l_Intf) then
      try
       l_Intf.Changed;
      finally
       l_Intf := nil;
      end;//try..finaly
    except
     on EDoChangedAlreadyDone do
      l_Expt := True;
     on E: Exception do
      l3System.Exception2Log(E);
       // Гасим все прочие исключения.
    end;
 finally
  if l_Expt then
   raise EDoChangedAlreadyDone.Create('');
 end;
//#UC END# *4772470100BC_48724DAD02E0_impl*
end;//Tl3SimpleTree.Changed

function Tl3SimpleTree.Get_ShowRoot: Boolean;
//#UC START# *477248FE005A_48724DAD02E0get_var*
//#UC END# *477248FE005A_48724DAD02E0get_var*
begin
//#UC START# *477248FE005A_48724DAD02E0get_impl*
 Result := f_ShowRoot; 
//#UC END# *477248FE005A_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_ShowRoot

procedure Tl3SimpleTree.Set_ShowRoot(aValue: Boolean);
//#UC START# *477248FE005A_48724DAD02E0set_var*
//#UC END# *477248FE005A_48724DAD02E0set_var*
begin
//#UC START# *477248FE005A_48724DAD02E0set_impl*
 f_ShowRoot := aValue;
 CursorTop;
//#UC END# *477248FE005A_48724DAD02E0set_impl*
end;//Tl3SimpleTree.Set_ShowRoot

function Tl3SimpleTree.Get_CountView: Integer;
//#UC START# *4772490E02F7_48724DAD02E0get_var*
//#UC END# *4772490E02F7_48724DAD02E0get_var*
begin
//#UC START# *4772490E02F7_48724DAD02E0get_impl*
 if (f_Root = nil) then
  Result := 0
 else
 begin
  Result := f_Root.ThisChildrenCount;
  if f_ShowRoot then
   Inc(Result);
 end;//f_Root = nil
//#UC END# *4772490E02F7_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_CountView

function Tl3SimpleTree.Get_SelectCount: Integer;
//#UC START# *4772491C01C5_48724DAD02E0get_var*
//#UC END# *4772491C01C5_48724DAD02E0get_var*
begin
//#UC START# *4772491C01C5_48724DAD02E0get_impl*
 Result := 0;
//#UC END# *4772491C01C5_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_SelectCount

function Tl3SimpleTree.Get_Flags(anIndex: Integer): Integer;
//#UC START# *4772495902EE_48724DAD02E0get_var*
//#UC END# *4772495902EE_48724DAD02E0get_var*
begin
//#UC START# *4772495902EE_48724DAD02E0get_impl*
 Result := 0;
 Assert(false);
//#UC END# *4772495902EE_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_Flags

function Tl3SimpleTree.Get_Select(anIndex: Integer): Boolean;
//#UC START# *477249AB0057_48724DAD02E0get_var*
//#UC END# *477249AB0057_48724DAD02E0get_var*
begin
//#UC START# *477249AB0057_48724DAD02E0get_impl*
 Result := false;
 Assert(false);
//#UC END# *477249AB0057_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_Select

procedure Tl3SimpleTree.Set_Select(anIndex: Integer;
 aValue: Boolean);
//#UC START# *477249AB0057_48724DAD02E0set_var*
//#UC END# *477249AB0057_48724DAD02E0set_var*
begin
//#UC START# *477249AB0057_48724DAD02E0set_impl*
 Assert(false);
//#UC END# *477249AB0057_48724DAD02E0set_impl*
end;//Tl3SimpleTree.Set_Select

function Tl3SimpleTree.Get_Nodes(anIndex: Integer): Il3SimpleNode;
//#UC START# *477249EB02D9_48724DAD02E0get_var*
//#UC END# *477249EB02D9_48724DAD02E0get_var*
begin
//#UC START# *477249EB02D9_48724DAD02E0get_impl*
 if f_ShowRoot then
 begin
  if (anIndex = 0) then
  begin
   Result := f_Root;
   Exit
  end//anIndex = 0
  else
   Dec(anIndex);
 end;//f_ShowRoot
 Result := f_Root.Child;
 while (anIndex > 0) AND (Result <> nil) do
 begin
  Result := Result.Next;
  Dec(anIndex);
 end;//while (anIndex > 0)
//#UC END# *477249EB02D9_48724DAD02E0get_impl*
end;//Tl3SimpleTree.Get_Nodes

function Tl3SimpleTree.MakeDataObject(const aNode: Il3SimpleNode;
 const aBitmap: IUnknown): IDataObject;
 {* сделать объект данных дерева, используется при перемещении элементов дерева в другие компоненты }
//#UC START# *47A86EA80292_48724DAD02E0_var*
//#UC END# *47A86EA80292_48724DAD02E0_var*
begin
//#UC START# *47A86EA80292_48724DAD02E0_impl*
 Result := nil;
//#UC END# *47A86EA80292_48724DAD02E0_impl*
end;//Tl3SimpleTree.MakeDataObject

function Tl3SimpleTree.CanAcceptData(const aTargetNode: Il3SimpleNode;
 const aData: Tl3TreeData): Boolean;
//#UC START# *47BAD3080349_48724DAD02E0_var*
//#UC END# *47BAD3080349_48724DAD02E0_var*
begin
//#UC START# *47BAD3080349_48724DAD02E0_impl*
 Result := false;
//#UC END# *47BAD3080349_48724DAD02E0_impl*
end;//Tl3SimpleTree.CanAcceptData

function Tl3SimpleTree.DropData(const aTargetNode: Il3SimpleNode;
 const aData: Tl3TreeData): Boolean;
//#UC START# *47BAD32501E2_48724DAD02E0_var*
//#UC END# *47BAD32501E2_48724DAD02E0_var*
begin
//#UC START# *47BAD32501E2_48724DAD02E0_impl*
 Result := false;
//#UC END# *47BAD32501E2_48724DAD02E0_impl*
end;//Tl3SimpleTree.DropData

procedure Tl3SimpleTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48724DAD02E0_var*
//#UC END# *479731C50290_48724DAD02E0_var*
begin
//#UC START# *479731C50290_48724DAD02E0_impl*
 f_Root := nil;
 inherited;
//#UC END# *479731C50290_48724DAD02E0_impl*
end;//Tl3SimpleTree.Cleanup

end.
