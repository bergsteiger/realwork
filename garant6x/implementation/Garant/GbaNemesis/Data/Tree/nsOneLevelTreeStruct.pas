unit nsOneLevelTreeStruct;
 {* Одноуровневое дерево }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsOneLevelTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsOneLevelTreeStruct" MUID: (4683692B0105)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DynamicTreeUnit
 , nsINodeWrapBase
 , l3TreeInterfaces
 , l3Interfaces
;

type
 TnsOneLevelTreeStruct = {abstract} class(TnsDataResetTreeStruct)
  {* Одноуровневое дерево }
  protected
   function IsOneLevelPrim: Boolean; override;
   procedure ChangeChildrenCountPrim(aNodeIndex: TVisibleIndex;
    aDelta: Integer;
    const aIndexPath: INodeIndexPath;
    aChildIndex: TIndexInParent); override;
   function GetByVisibleIndex(anIndex: Integer): INodeBase; override;
    {* возвращает ноду по видимому индексу }
   function RootNodeClass: RnsINodeWrap; override;
    {* определяет класс обертки для Root }
   function DoChangeExpand(const aNode: Il3SimpleNode;
    aMode: Tl3SetBitType;
    aForceMode: Boolean): Boolean; override;
 end;//TnsOneLevelTreeStruct

implementation

uses
 l3ImplUses
 , nsINodeOneLevelRootWrap
 //#UC START# *4683692B0105impl_uses*
 //#UC END# *4683692B0105impl_uses*
;

function TnsOneLevelTreeStruct.IsOneLevelPrim: Boolean;
//#UC START# *48FDA0DD02E1_4683692B0105_var*
//#UC END# *48FDA0DD02E1_4683692B0105_var*
begin
//#UC START# *48FDA0DD02E1_4683692B0105_impl*
 Result := True;
//#UC END# *48FDA0DD02E1_4683692B0105_impl*
end;//TnsOneLevelTreeStruct.IsOneLevelPrim

procedure TnsOneLevelTreeStruct.ChangeChildrenCountPrim(aNodeIndex: TVisibleIndex;
 aDelta: Integer;
 const aIndexPath: INodeIndexPath;
 aChildIndex: TIndexInParent);
//#UC START# *48FDA11E02D1_4683692B0105_var*
//#UC END# *48FDA11E02D1_4683692B0105_var*
begin
//#UC START# *48FDA11E02D1_4683692B0105_impl*
 if (aDelta <> 0) and (RootNode <> nil) and (aNodeIndex = 0) then
  inherited;
//#UC END# *48FDA11E02D1_4683692B0105_impl*
end;//TnsOneLevelTreeStruct.ChangeChildrenCountPrim

function TnsOneLevelTreeStruct.GetByVisibleIndex(anIndex: Integer): INodeBase;
 {* возвращает ноду по видимому индексу }
//#UC START# *48FDC58F0218_4683692B0105_var*
var
 l_Child: INodeBase;
 l_Index: Integer;
//#UC END# *48FDC58F0218_4683692B0105_var*
begin
//#UC START# *48FDC58F0218_4683692B0105_impl*
 Result := nil;
 if (CurrentNode = nil) then
 begin
  if Get_ShowRoot then
   l_Index := anIndex - 1
  else
   l_Index := anIndex;
  if (RootNode <> nil) then
  begin
   RootNode.GetFirstChild(l_Child);
   try
    if l_Index = 0 then
     Result := l_Child
    else
     l_Child.GetBySibblingIndex(l_Index, Result);
   finally
    l_Child := nil;
   end;//try..finally
  end;//RootNode <> nil
 end//CurrentNode = nil
 else
  CurrentNode.GetBySibblingIndex(anIndex - CurrentNodeIndex, Result);
//#UC END# *48FDC58F0218_4683692B0105_impl*
end;//TnsOneLevelTreeStruct.GetByVisibleIndex

function TnsOneLevelTreeStruct.RootNodeClass: RnsINodeWrap;
 {* определяет класс обертки для Root }
//#UC START# *48FEE3640227_4683692B0105_var*
//#UC END# *48FEE3640227_4683692B0105_var*
begin
//#UC START# *48FEE3640227_4683692B0105_impl*
 Result := TnsINodeOneLevelRootWrap;
//#UC END# *48FEE3640227_4683692B0105_impl*
end;//TnsOneLevelTreeStruct.RootNodeClass

function TnsOneLevelTreeStruct.DoChangeExpand(const aNode: Il3SimpleNode;
 aMode: Tl3SetBitType;
 aForceMode: Boolean): Boolean;
//#UC START# *48FEFA1E02E7_4683692B0105_var*
//#UC END# *48FEFA1E02E7_4683692B0105_var*
begin
//#UC START# *48FEFA1E02E7_4683692B0105_impl*
 Result := False;
//#UC END# *48FEFA1E02E7_4683692B0105_impl*
end;//TnsOneLevelTreeStruct.DoChangeExpand

end.
