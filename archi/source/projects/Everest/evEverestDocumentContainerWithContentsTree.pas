unit evEverestDocumentContainerWithContentsTree;

{$Include Everest.inc}

interface

uses
 nevBase,
 l3Tree_TLB,
 k2Base,
 k2TagGen,
 evEverestDocumentContainer;

type
 TevEverestDocumentContainerWithContentsTree = class(TevEverestDocumentContainer)
 private
 // private fields
   f_ContentsTree : Il3Tree;
    {* Дерево оглавления.}
 private
 // private methods
   procedure MakeContentsTree;
     {* Создать, если нужно, дерево оглваления. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure SendTOCCreatedNotify; override;
   function GetContentsTree: InevSimpleTree; override;
   procedure DoPropChanged(Prop: Tk2Prop;
    const V: TnevValues;
    const anOpPack: InevOp); override;
   procedure DoGetWriter(aFormat: TnevFormat;
    anInternal: Boolean;
    var theWriter: Tk2TagGenerator;
    aCodePage: Integer); override;
 end;

implementation

uses
  evContentsTree,
  evCommentDecorator,
  evInternalInterfaces,
  nevTools,
  SysUtils,
  evTypes,
  l3Types,
  Block_Const,
  k2Tags,
  arConst
  ;

{ TevEverestDocumentContainerWithContentsTree }

procedure TevEverestDocumentContainerWithContentsTree.Cleanup;
begin
 f_ContentsTree := nil;
 inherited;
end;

function TevEverestDocumentContainerWithContentsTree.GetContentsTree: InevSimpleTree;
begin
 Result := f_ContentsTree;
end;

procedure TevEverestDocumentContainerWithContentsTree.MakeContentsTree;
var
 l_Listner : InevSubChangeListener;
 l_Filter  : InevContentsNodeFilter;
begin
 if f_ContentsTree = nil then
 begin
  f_ContentsTree := TevContentsTree.Make(Document.AsObject);
  if Supports(f_ContentsTree, InevContentsNodeFilter, l_Filter) then
   l_Filter.FilteredNodeFlag := nfContens;
  if Supports(f_ContentsTree, InevSubChangeListener, l_Listner) then
   LinkSubChangeListener(l_Listner);
 end; //if not f_TreeWasInit then
 if f_ContentsTree.RootNode.HasChild and
    not f_ContentsTree.IsExpanded(f_ContentsTree.RootNode.Child) then
  f_ContentsTree.CRootNode.ChildNode.ReleaseChilds;
end;

procedure TevEverestDocumentContainerWithContentsTree.SendTOCCreatedNotify;
begin
 MakeContentsTree;
 inherited;
end;

procedure TevEverestDocumentContainerWithContentsTree.DoPropChanged(Prop: Tk2Prop;
  const V: TnevValues;
  const anOpPack: InevOp);
begin
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
end;//TarDocumentContainerWithContentsTree.DoPropChanged

procedure TevEverestDocumentContainerWithContentsTree.DoGetWriter(
  aFormat: TnevFormat; anInternal: Boolean; var theWriter: Tk2TagGenerator;
  aCodePage: Integer);
begin
 inherited;
 if (aFormat = cf_RTF) or (aFormat = cf_RTFLite) or (aFormat = cf_HTML) then
  TevCommentDecorator.SetTo(theWriter);
end;

end.
