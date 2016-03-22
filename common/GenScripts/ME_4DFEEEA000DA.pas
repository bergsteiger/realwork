unit evContentsTree;
 {* Дерево оглавления. }

// Модуль: "w:\common\components\gui\Garant\Everest\evContentsTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevContentsTree" MUID: (4DFEEEA000DA)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Tree
 , nevTools
 , evInternalInterfaces
 , l3Tree_TLB
 , l3Variant
 , l3IID
 , l3TreeInterfaces
 , l3PureMixIns
;

type
 _l3Changing_Parent_ = Tl3Tree;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 TevContentsTree = class(_l3Changing_, InevSubChangeListener)
  {* Дерево оглавления. }
  private
   f_ContentsNodeFilter: InevContentsNodeFilter;
  private
   procedure CreateRootChild(aDocument: Tl3Variant);
  protected
   procedure SubChanged(aSub: Tl3Variant;
    aChangeType: TevChangeType);
    {* Саб добавлен/удален. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure DoChanged; override;
  public
   constructor Create(aDocument: Tl3Variant); reintroduce; virtual;
   class function Make(aDocument: Tl3Variant): Il3Tree;
   procedure DoNotify(aOperation: Integer;
    const aNode: Il3SimpleNode); override;
 end;//TevContentsTree

implementation

uses
 l3ImplUses
 , evContentsNodeFilter
 , SysUtils
 , l3Base
 , l3Nodes
 , l3Types
 , evNode
 , Block_Const
 , l3Interfaces
 , evContentsNodeFactory
 , k2Prim
;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

procedure TevContentsTree.CreateRootChild(aDocument: Tl3Variant);
//#UC START# *4EAE7B0803B7_4DFEEEA000DA_var*
//#UC END# *4EAE7B0803B7_4DFEEEA000DA_var*
begin
//#UC START# *4EAE7B0803B7_4DFEEEA000DA_impl*
 RootNode.InsertChild(TevContentsNodeFactory.CreateContentsNode(aDocument, nil, f_ContentsNodeFilter));
 with f_ContentsNodeFilter do
  ColorNode(RootNode.ChildNode);
//#UC END# *4EAE7B0803B7_4DFEEEA000DA_impl*
end;//TevContentsTree.CreateRootChild

constructor TevContentsTree.Create(aDocument: Tl3Variant);
//#UC START# *4DFEF08201FC_4DFEEEA000DA_var*
var
 l_Root     : InevNode;
 l_RootNode : Il3SimpleRootNode;
//#UC END# *4DFEF08201FC_4DFEEEA000DA_var*
begin
//#UC START# *4DFEF08201FC_4DFEEEA000DA_impl*
 f_ContentsNodeFilter := TevContentsNodeFilter.Make(aDocument);
 l_RootNode := TevContentsNodeFactory.CreateRoot;
 inherited Create;
 Set_RootNode(l_RootNode);
 CreateRootChild(aDocument);
//#UC END# *4DFEF08201FC_4DFEEEA000DA_impl*
end;//TevContentsTree.Create

class function TevContentsTree.Make(aDocument: Tl3Variant): Il3Tree;
//#UC START# *4DFEF0A30330_4DFEEEA000DA_var*
var
 l_CT : TevContentsTree;
//#UC END# *4DFEF0A30330_4DFEEEA000DA_var*
begin
//#UC START# *4DFEF0A30330_4DFEEEA000DA_impl*
 l_CT := Create(aDocument);
 try
  Result := l_CT;
  l_CT.CommonExpanded := True;
 finally
  l3Free(l_CT);
 end;//try..finally
//#UC END# *4DFEF0A30330_4DFEEEA000DA_impl*
end;//TevContentsTree.Make

procedure TevContentsTree.SubChanged(aSub: Tl3Variant;
 aChangeType: TevChangeType);
 {* Саб добавлен/удален. }
//#UC START# *48EDB20501DD_4DFEEEA000DA_var*

  function lp_InParaEX(anAtom  : Tl3Variant;
                       aTypeID       : Tk2TypePrim;
                       out theParent : Tl3Variant): Boolean;
  var
   l_Parent : Tl3Variant;
  begin
   Result := false;
   l_Parent := anAtom.Owner;
   while (l_Parent <> nil) AND l_Parent.IsValid do
   begin
    if l_Parent.IsKindOf(aTypeID) then
    begin
     theParent := l_Parent;
     Result := True;
     Break;
    end;//l_Parent.IhneritsFrom(aTypeID)
    l_Parent := l_Parent.Owner;
   end;//while l_Parent.IsValid
  end;

var
 l_Node        : InevNode;
 l_Root        : InevNode;
 l_Expanded    : Boolean;
 l_ParentBlock : Tl3Variant;
//#UC END# *48EDB20501DD_4DFEEEA000DA_var*
begin
//#UC START# *48EDB20501DD_4DFEEEA000DA_impl*
 if aSub.IsValid then
 begin
  if aChangeType = ev_chtDocument then
  begin                                                    
   if Supports(Get_RootNode, InevNode, l_Root) then
   begin
    l_Root.ReleaseChilds;
    f_ContentsNodeFilter.ChangeDocument(aSub);
    CreateRootChild(aSub);
   end; // if Supports(Get_RootNode, InevNode, l_Root) then
   Exit;
  end; // if aChangeType = ev_chtDcoument then
  if Supports(RootNode, InevNode, l_Root) then
  begin
   if aChangeType = ev_chtAdded then
   begin
    f_ContentsNodeFilter.CheckTagList;
    lp_InParaEX(aSub, k2_typBlock, l_ParentBlock);
    if l_ParentBlock <> nil then
     if not l_ParentBlock.IsValid then //Нет смысла искать сам блок в дереве (если использовать _evInPara), если он только что добавился...
      l_ParentBlock := nil;
   end // if anAdded then
   else
   begin
    l_ParentBlock := aSub;
    f_ContentsNodeFilter.AddFilterTag(aSub);
   end;
   l_Node := FindNodeByTag(l_Root, l_ParentBlock, imExpandOnly);
   if l_Node <> nil then
   begin
    if aChangeType = ev_chtDeleted then
     l_Node := l_Node.ParentNode;
    if (l_Node <> nil) and l_Node.HasChild then
    begin
     l_Expanded := IsExpanded(l_Node);
     l_Node.Changing;
     try
      l_Node.ReleaseChilds;
      if l_Expanded then
       ChangeExpand(l_Node, sbSelect);
     finally
      l_Node.Changed;
     end;
    end // if (l_Node <> nil) and l_Node.HasChild then
    else
     // V - http://mdp.garant.ru/pages/viewpage.action?pageId=300028777
     if (l_Node <> nil) and not l_Node.HasChild and (aChangeType = ev_chtAdded) then
      l_Node.ReleaseChilds;
   end; // if l_Node <> nil then
  end; // if Supports(RootNode, InevNode, l_Root) then
 end; // if aSub.IsValid then
//#UC END# *48EDB20501DD_4DFEEEA000DA_impl*
end;//TevContentsTree.SubChanged

procedure TevContentsTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DFEEEA000DA_var*
//#UC END# *479731C50290_4DFEEEA000DA_var*
begin
//#UC START# *479731C50290_4DFEEEA000DA_impl*
 inherited;
 f_ContentsNodeFilter := nil;
//#UC END# *479731C50290_4DFEEEA000DA_impl*
end;//TevContentsTree.Cleanup

function TevContentsTree.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4DFEEEA000DA_var*
//#UC END# *4A60B23E00C3_4DFEEEA000DA_var*
begin
//#UC START# *4A60B23E00C3_4DFEEEA000DA_impl*
 if IID.EQ(InevContentsNodeFilter) then
 begin
  InevContentsNodeFilter(Obj) := f_ContentsNodeFilter;
  Result.SetOk;
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4DFEEEA000DA_impl*
end;//TevContentsTree.COMQueryInterface

procedure TevContentsTree.DoNotify(aOperation: Integer;
 const aNode: Il3SimpleNode);
//#UC START# *5329A20B0356_4DFEEEA000DA_var*

 function lp_FindMode(const aNode: Il3Node): Boolean;
 begin
  if aNode.ParentNode <> nil then
   with f_ContentsNodeFilter do
    ColorNode(aNode);
  Result := True;
 end;

//#UC END# *5329A20B0356_4DFEEEA000DA_var*
begin
//#UC START# *5329A20B0356_4DFEEEA000DA_impl*
 inherited;
 if (aOperation = ntDataChange) then
  IterateF(l3L2NA(@lp_FindMode), imExpandOnly)
//#UC END# *5329A20B0356_4DFEEEA000DA_impl*
end;//TevContentsTree.DoNotify

procedure TevContentsTree.DoChanged;
//#UC START# *54D9E08D0212_4DFEEEA000DA_var*
//#UC END# *54D9E08D0212_4DFEEEA000DA_var*
begin
//#UC START# *54D9E08D0212_4DFEEEA000DA_impl*
 try
  inherited;
 except
  on EDoChangedAlreadyDone do ;
 end;
//#UC END# *54D9E08D0212_4DFEEEA000DA_impl*
end;//TevContentsTree.DoChanged

end.
