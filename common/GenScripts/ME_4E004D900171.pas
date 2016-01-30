unit arDocumentContainerWithContentsTree;

// Модуль: "w:\archi\source\projects\Archi\Editor\arDocumentContainerWithContentsTree.pas"
// Стереотип: "SimpleClass"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arDocumentContainer
 , arCommonTypes
 , l3Tree_TLB
 , l3LongintList
 , evdTypes
 , nevBase
 , k2DocumentGenerator
 , k2Base
;

const
 cnUndefAACSubID = -1;

type
 TarDocumentContainerWithContentsTree = class(TarDocumentContainer, IarCheckLeftOrRightBlock)
  private
   f_ContentsTree: Il3Tree;
    {* Дерево оглавления. }
   f_RightSubID: Tl3LongintList;
   f_LeftSubID: Tl3LongintList;
  private
   procedure MakeContentsTree;
    {* Создать, если нужно, дерево оглваления. }
  protected
   function HasAACBlock(aLeft: Boolean): Boolean;
   procedure SetBlockKind(aOldSubID: Integer;
    aNewSubID: Integer;
    aBlockKind: TevBlockViewKind);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure SendTOCCreatedNotify; override;
   function DoBeforeFinishAtom1(aGenerator: Tk2DocumentGenerator;
    var anAtom: Tk2StackAtom): Boolean; override;
   function GetContentsTree: InevSimpleTree; override;
   procedure DoPropChanged(Prop: Tk2Prop;
    const V: TnevValues;
    const anOpPack: InevOp); override;
   procedure SubDeleted(aSubID: Integer); override;
 end;//TarDocumentContainerWithContentsTree
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , evContentsTree
 , evInternalInterfaces
 , nevTools
 , SysUtils
 , arConst
 , l3Types
 , Block_Const
 , k2Tags
 , Sub_Const
;

procedure TarDocumentContainerWithContentsTree.MakeContentsTree;
 {* Создать, если нужно, дерево оглваления. }
//#UC START# *4E0056E503BE_4E004D900171_var*
var
 l_Listener : InevSubChangeListener;
 l_Filter  : InevContentsNodeFilter;
//#UC END# *4E0056E503BE_4E004D900171_var*
begin
//#UC START# *4E0056E503BE_4E004D900171_impl*
 if f_ContentsTree = nil then
 begin
  f_ContentsTree := TevContentsTree.Make(Document.AsObject);
  if Supports(f_ContentsTree, InevContentsNodeFilter, l_Filter) then
   l_Filter.FilteredNodeFlag := nfContens;
  if Supports(f_ContentsTree, InevSubChangeListener, l_Listener) then
   LinkSubChangeListener(l_Listener);
 end; //if not f_TreeWasInit then
 if f_ContentsTree.RootNode.HasChild and
    not f_ContentsTree.IsExpanded(f_ContentsTree.RootNode.Child) then
  f_ContentsTree.CRootNode.ChildNode.ReleaseChilds;
//#UC END# *4E0056E503BE_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.MakeContentsTree

function TarDocumentContainerWithContentsTree.HasAACBlock(aLeft: Boolean): Boolean;
//#UC START# *52738B050043_4E004D900171_var*
//#UC END# *52738B050043_4E004D900171_var*
begin
//#UC START# *52738B050043_4E004D900171_impl*
 if aLeft then
  Result := f_LeftSubID.Count > 0
 else
  Result := f_RightSubID.Count > 0;
//#UC END# *52738B050043_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.HasAACBlock

procedure TarDocumentContainerWithContentsTree.SetBlockKind(aOldSubID: Integer;
 aNewSubID: Integer;
 aBlockKind: TevBlockViewKind);
//#UC START# *52738B2F02B7_4E004D900171_var*
//#UC END# *52738B2F02B7_4E004D900171_var*
begin
//#UC START# *52738B2F02B7_4E004D900171_impl*
 if (aNewSubID = - 1) then Exit;
 SubDeleted(aOldSubID);
 case aBlockKind of
  ev_bvkLeft: f_LeftSubID.Add(aNewSubID);
  ev_bvkRight: f_RightSubID.Add(aNewSubID);
 end; // case aBlockKind of
//#UC END# *52738B2F02B7_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.SetBlockKind

procedure TarDocumentContainerWithContentsTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E004D900171_var*
//#UC END# *479731C50290_4E004D900171_var*
begin
//#UC START# *479731C50290_4E004D900171_impl*
 f_ContentsTree := nil;
 FreeAndNil(f_LeftSubID);
 FreeAndNil(f_RightSubID);
 inherited;
//#UC END# *479731C50290_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.Cleanup

procedure TarDocumentContainerWithContentsTree.InitFields;
//#UC START# *47A042E100E2_4E004D900171_var*
//#UC END# *47A042E100E2_4E004D900171_var*
begin
//#UC START# *47A042E100E2_4E004D900171_impl*
 inherited;
 f_LeftSubID := Tl3LongintList.Create;
 f_RightSubID := Tl3LongintList.Create;
//#UC END# *47A042E100E2_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.InitFields

procedure TarDocumentContainerWithContentsTree.SendTOCCreatedNotify;
//#UC START# *47F0BA6E0019_4E004D900171_var*
//#UC END# *47F0BA6E0019_4E004D900171_var*
begin
//#UC START# *47F0BA6E0019_4E004D900171_impl*
 MakeContentsTree;
 inherited;
//#UC END# *47F0BA6E0019_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.SendTOCCreatedNotify

function TarDocumentContainerWithContentsTree.DoBeforeFinishAtom1(aGenerator: Tk2DocumentGenerator;
 var anAtom: Tk2StackAtom): Boolean;
//#UC START# *47F226170180_4E004D900171_var*
//#UC END# *47F226170180_4E004D900171_var*
begin
//#UC START# *47F226170180_4E004D900171_impl*
 Result := inherited DoBeforeFinishAtom1(aGenerator, anAtom);
 if anAtom.IsKindOf(k2_typSub) and anAtom.IsKindOf(k2_typBlock) then
  if anAtom.Box.Attr[k2_tiViewKind].IsValid then
  begin
   if anAtom.Box.IntA[k2_tiViewKind] = Ord(ev_bvkLeft) then
    f_LeftSubID.Add(anAtom.Box.IntA[k2_tiHandle]);
   if anAtom.Box.IntA[k2_tiViewKind] = Ord(ev_bvkRight) then
    f_RightSubID.Add(anAtom.Box.IntA[k2_tiHandle]);
  end; // if anAtom.Box.Attr[k2_tiViewKind].IsValid then
//#UC END# *47F226170180_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.DoBeforeFinishAtom1

function TarDocumentContainerWithContentsTree.GetContentsTree: InevSimpleTree;
//#UC START# *47F2802003C4_4E004D900171_var*
//#UC END# *47F2802003C4_4E004D900171_var*
begin
//#UC START# *47F2802003C4_4E004D900171_impl*
 Result := f_ContentsTree; 
//#UC END# *47F2802003C4_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.GetContentsTree

procedure TarDocumentContainerWithContentsTree.DoPropChanged(Prop: Tk2Prop;
 const V: TnevValues;
 const anOpPack: InevOp);
//#UC START# *49184A180301_4E004D900171_var*
//#UC END# *49184A180301_4E004D900171_var*
begin
//#UC START# *49184A180301_4E004D900171_impl*
 if not anOpPack.InIOProcess and ((Prop.TagIndex = k2_tiContentsLevel6) or (Prop.TagIndex = k2_tiShortName)) AND V.rTag.IsKindOf(k2_typBlock) then
 begin
  f_ContentsTree.Changing;
  try
   f_ContentsTree.Notify(ntDataChange, nil);
  finally
   f_ContentsTree.Changed;
  end;
 end//Prop.TagIndex = k2_tiContentsLevel6
 else
  inherited;
//#UC END# *49184A180301_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.DoPropChanged

procedure TarDocumentContainerWithContentsTree.SubDeleted(aSubID: Integer);
//#UC START# *527384840253_4E004D900171_var*
//#UC END# *527384840253_4E004D900171_var*
begin
//#UC START# *527384840253_4E004D900171_impl*
 if f_LeftSubID.Remove(aSubID) = -1 then
  f_RightSubID.Remove(aSubID);
//#UC END# *527384840253_4E004D900171_impl*
end;//TarDocumentContainerWithContentsTree.SubDeleted
{$IfEnd} // Defined(AppClientSide)

end.
