unit nsContentsTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsContentsTree.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DocumentInterfaces
 , l3Variant
 , l3TreeInterfaces
 , DynamicTreeUnit
 , nsINodeWrapBase
 , afwInterfaces
 , nsFilterableTreeStruct
;

type
 TnsContentsTree = class(TnsDataResetTreeStruct, InsContentsTree)
  private
   f_NeedResetRoot: Boolean;
   f_RootWasResetted: Boolean;
   f_Document: Tl3Tag;
    {* Документ. }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function FindBlock(aBlockID: Integer): Il3SimpleNode;
   function NeedResetRoot: Boolean;
   procedure ResetRoot(aDocument: Tl3Tag;
    const aRoot: Il3SimpleRootNode);
   function RootResetted: Boolean;
   procedure DataReceived;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure MakeRootNode(const aRoot: INodeBase); override;
   function RootNodeClass: RnsINodeWrap; override;
    {* определяет класс обертки для Root }
   function MakeChildNode(const aChild: INodeBase): Il3SimpleNode; override;
   constructor CreateFiltered(const aNewRoot: INodeBase;
    aSource: TnsFilterableTreeStruct;
    const aFilters: Il3TreeFilters); override;
   function SettingsID: TafwSettingId; override;
   procedure BeforeReset; override;
  public
   constructor Create(const aRoot: INodeBase;
    aDocument: Tl3Tag); reintroduce;
   class function Make(const aRoot: INodeBase;
    aDocument: Tl3Tag): Il3SimpleTree; reintroduce;
   class function MakeTagNode(aDocument: Tl3Tag;
    const aChild: INodeBase): Il3SimpleNode;
 end;//TnsContentsTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsContentsNode
 , SysUtils
 , nsConst
 , nsParentedTagNode
 , nsTagNodeTools
 , k2Tags
 , Document_Const
 , CommentPara_Const
 , Block_Const
 , LeafPara_Const
 , Bookmark_Const
 , Sub_Const
 , DocumentUnit
 , nsTagNodeToolsNew
 , k2Base
 , k2Facade
 , LeafParaDecorationsHolder_Const
 , k2Empty_Const
;

constructor TnsContentsTree.Create(const aRoot: INodeBase;
 aDocument: Tl3Tag);
//#UC START# *490860BD0003_4683630000A0_var*
//#UC END# *490860BD0003_4683630000A0_var*
begin
//#UC START# *490860BD0003_4683630000A0_impl*
 Assert(aDocument <> nil);
 aDocument.SetRef(f_Document);
 inherited Create(aRoot, False);
//#UC END# *490860BD0003_4683630000A0_impl*
end;//TnsContentsTree.Create

class function TnsContentsTree.Make(const aRoot: INodeBase;
 aDocument: Tl3Tag): Il3SimpleTree;
var
 l_Inst : TnsContentsTree;
begin
 l_Inst := Create(aRoot, aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsContentsTree.Make

class function TnsContentsTree.MakeTagNode(aDocument: Tl3Tag;
 const aChild: INodeBase): Il3SimpleNode;
//#UC START# *49086150030C_4683630000A0_var*
var
 l_Provider : IDocumentTextProvider;
 l_Tag     : Tl3Variant;
 l_Path    : INodeIndexPath;
 l_ID      : Integer;
 l_Type    : Tk2Type;
//#UC END# *49086150030C_4683630000A0_var*
begin
//#UC START# *49086150030C_4683630000A0_impl*
 Result := nil;
 l_Tag := nil;
 try
  if aDocument.QI(IDocumentTextProvider, l_Provider) then
   try
    if (aChild <> nil) then
    begin
     l_Type := k2.TypeTable.TypeByHandle[aChild.GetType];
     if (l_Type <> nil) AND (l_Type <> k2_typEmpty) then
     // - иначе - это скрытый корень дерева
     begin
      l_ID := aChild.GetNodeId;
      // http://mdp.garant.ru/pages/viewpage.action?pageId=235055410&focusedCommentId=235056286#comment-235056286
      if l_Type.IsKindOf(k2_typSub) then
      begin
       if (l_ID = 0) then
        l_Tag := aDocument.AsObject
       else
       begin
        l_Provider.FindBlockOrSub(l_ID, l_Path);
        l_Tag := nsTagByPath(aDocument.AsObject, l_Path, true);
        if (l_Tag <> nil) then
        begin
(*         if l_Type.IsKindOf(k2_typBlock) AND
            l_Tag.IsKindOf(k2_typLeafParaDecorationsHolder) then
         begin
          Assert(l_Tag.ChildrenCount >= 2);
          l_Tag := l_Tag.Child[1];
         end;//l_Type.IsKindOf(k2_typBlock)*)
         Assert(l_Tag.IsKindOf(l_Type), l_Tag.TagType.AsString + ' != ' + l_Type.AsString);
         Assert(l_Tag.IntA[k2_tiHandle] = l_ID, IntToStr(l_Tag.IntA[k2_tiHandle]) + ' != ' + IntToStr(l_ID));
        end;//l_Tag <> nil
       end;//l_ID = 0
      end//l_Type.IsKindOf(k2_typSub)
      else
      begin
       Assert(false, 'Неверный тип метки - ' + l_Type.AsString);
      end;//l_Type.IsKindOf(k2_typSub)
     end;//l_Type <> nil
     //l_Tag := TnsParentedTagNode.MakeNodeTag(Tf1TagDataFromIDocTagNodeProvider.Make(l_DocNode));
    end;//aChild <> nil
   finally
    l_Provider := nil;
   end//try..finally
  ;
  if (l_Tag <> nil) AND l_Tag.IsValid then
  begin
   if l_Tag.IsKindOf(k2_typDocument) then
    Result := TnsDocumentNode.Make(aChild, aDocument, l_Tag)
   else
   if l_Tag.IsKindOf(k2_typCommentPara) then
    Result := TnsContentsCommentNode.Make(aChild, aDocument, l_Tag)
   else
   if l_Tag.IsKindOf(k2_typBlock) then
    Result := TnsRealBlockNode.Make(aChild, aDocument, l_Tag)
   else
   if l_Tag.IsKindOf(k2_typLeafPara) then
    Result := TnsContentsLeafParaNode.Make(aChild, aDocument, l_Tag)
   else
   if l_Tag.IsKindOf(k2_typBookmark) then
    Result := TnsBookmarkNode.Make(aChild, aDocument, l_Tag)
   else
   if l_Tag.IsKindOf(k2_typSub) then
    Result := TnsContentsSubNode.Make(aChild, aDocument, l_Tag);
  end;//(l_Tag <> nil) AND l_Tag.IsValid
 finally
  l_Tag := nil;
 end;//try..finally
//#UC END# *49086150030C_4683630000A0_impl*
end;//TnsContentsTree.MakeTagNode

function TnsContentsTree.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4683630000A0_var*
//#UC END# *48FF64F60078_4683630000A0_var*
begin
//#UC START# *48FF64F60078_4683630000A0_impl*
 Result := nil;
  // - оглавление приходит из документа, нет фиксированного места из которого
  //   всегда можно получить корень для оглавления.
 f_NeedResetRoot := True;
//#UC END# *48FF64F60078_4683630000A0_impl*
end;//TnsContentsTree.ReAqurieUnfilteredRoot

function TnsContentsTree.FindBlock(aBlockID: Integer): Il3SimpleNode;
//#UC START# *49085E9202C5_4683630000A0_var*
var
 l_Root: INodeBase;
 l_List: IFilterList;
 l_Path: INodeIndexPath;
 l_FoundNode: INodeBase;
 l_P : IDocumentTextProvider;
//#UC END# *49085E9202C5_4683630000A0_var*
begin
//#UC START# *49085E9202C5_4683630000A0_impl*
 Result := nil;
 if f_Document.QI(IDocumentTextProvider, l_P) then
 begin
  if (aBlockID = 0) then
   Result := Root.Child
  else
  begin
   l_List := nsCreateFilterForFindTagByID(k2_idBlock, aBlockID);
   if Supports(Root, INodeBase, l_Root) then
   begin
    l_Root.GetFirstFit(l_List, l_Path);
    if Assigned(l_Path) then
    begin
     l_Root.GetNodeByPath(l_Path, l_FoundNode);
     Result := MakeTagNode(f_Document, l_FoundNode);
    end//Assigned(l_Path)
    else
     Result := nil;
   end;//Supports(Root, INodeBase, l_Root)
  end;//aBlockID = 0
 end;//f_Document.QI(IDocumentTextProvider)
//#UC END# *49085E9202C5_4683630000A0_impl*
end;//TnsContentsTree.FindBlock

function TnsContentsTree.NeedResetRoot: Boolean;
//#UC START# *49085EA001E8_4683630000A0_var*
//#UC END# *49085EA001E8_4683630000A0_var*
begin
//#UC START# *49085EA001E8_4683630000A0_impl*
 Result := f_NeedResetRoot;
//#UC END# *49085EA001E8_4683630000A0_impl*
end;//TnsContentsTree.NeedResetRoot

procedure TnsContentsTree.ResetRoot(aDocument: Tl3Tag;
 const aRoot: Il3SimpleRootNode);
//#UC START# *49085EAE0132_4683630000A0_var*
var
 l_Root: INodeBase;
 l_Sync: Integer;
//#UC END# *49085EAE0132_4683630000A0_var*
begin
//#UC START# *49085EAE0132_4683630000A0_impl*
 aDocument.SetRef(f_Document);
 if Supports(aRoot, INodeBase, l_Root) then
 begin
  Changing;
  try
   f_RootWasResetted := True;
   MakeRootNode(GetFilteredRoot(l_Root, Filters, nil, l_Sync, true, true, False));
  finally
   Changed;
  end;
 end;
 f_NeedResetRoot := False;
//#UC END# *49085EAE0132_4683630000A0_impl*
end;//TnsContentsTree.ResetRoot

function TnsContentsTree.RootResetted: Boolean;
//#UC START# *49085EDA00CC_4683630000A0_var*
//#UC END# *49085EDA00CC_4683630000A0_var*
begin
//#UC START# *49085EDA00CC_4683630000A0_impl*
 Result := f_NeedResetRoot or f_RootWasResetted;
//#UC END# *49085EDA00CC_4683630000A0_impl*
end;//TnsContentsTree.RootResetted

procedure TnsContentsTree.DataReceived;
//#UC START# *49085EE502F1_4683630000A0_var*
//#UC END# *49085EE502F1_4683630000A0_var*
begin
//#UC START# *49085EE502F1_4683630000A0_impl*
 f_RootWasResetted := False;
//#UC END# *49085EE502F1_4683630000A0_impl*
end;//TnsContentsTree.DataReceived

procedure TnsContentsTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4683630000A0_var*
//#UC END# *479731C50290_4683630000A0_var*
begin
//#UC START# *479731C50290_4683630000A0_impl*
 inherited;
 f_NeedResetRoot := False;
 f_RootWasResetted := False;
 FreeAndNil(f_Document);
//#UC END# *479731C50290_4683630000A0_impl*
end;//TnsContentsTree.Cleanup

procedure TnsContentsTree.MakeRootNode(const aRoot: INodeBase);
//#UC START# *48FDDE69025A_4683630000A0_var*
//#UC END# *48FDDE69025A_4683630000A0_var*
begin
//#UC START# *48FDDE69025A_4683630000A0_impl*
 Root := TnsContentsRoot.Make(aRoot, f_Document) as Il3SimpleRootNode;
//#UC END# *48FDDE69025A_4683630000A0_impl*
end;//TnsContentsTree.MakeRootNode

function TnsContentsTree.RootNodeClass: RnsINodeWrap;
 {* определяет класс обертки для Root }
//#UC START# *48FEE3640227_4683630000A0_var*
//#UC END# *48FEE3640227_4683630000A0_var*
begin
//#UC START# *48FEE3640227_4683630000A0_impl*
 Result := TnsContentsRoot;
//#UC END# *48FEE3640227_4683630000A0_impl*
end;//TnsContentsTree.RootNodeClass

function TnsContentsTree.MakeChildNode(const aChild: INodeBase): Il3SimpleNode;
//#UC START# *48FEE50002EB_4683630000A0_var*
//#UC END# *48FEE50002EB_4683630000A0_var*
begin
//#UC START# *48FEE50002EB_4683630000A0_impl*
 Result := MakeTagNode(f_Document, aChild);
 if (Result = nil) then
  Result := TnsContentsNode.Make(aChild, f_Document);//inherited MakeChildNode(aChild);
//#UC END# *48FEE50002EB_4683630000A0_impl*
end;//TnsContentsTree.MakeChildNode

constructor TnsContentsTree.CreateFiltered(const aNewRoot: INodeBase;
 aSource: TnsFilterableTreeStruct;
 const aFilters: Il3TreeFilters);
//#UC START# *48FF458602EC_4683630000A0_var*
//#UC END# *48FF458602EC_4683630000A0_var*
begin
//#UC START# *48FF458602EC_4683630000A0_impl*
 if aSource is TnsContentsTree then
  TnsContentsTree(aSource).f_Document.SetRef(f_Document);
 inherited;
//#UC END# *48FF458602EC_4683630000A0_impl*
end;//TnsContentsTree.CreateFiltered

function TnsContentsTree.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_4683630000A0_var*
//#UC END# *48FF56D003E6_4683630000A0_var*
begin
//#UC START# *48FF56D003E6_4683630000A0_impl*
 Result := gi_cpContents;
//#UC END# *48FF56D003E6_4683630000A0_impl*
end;//TnsContentsTree.SettingsID

procedure TnsContentsTree.BeforeReset;
//#UC START# *48FF64E700E5_4683630000A0_var*
//#UC END# *48FF64E700E5_4683630000A0_var*
begin
//#UC START# *48FF64E700E5_4683630000A0_impl*
 inherited;
 f_NeedResetRoot := True;
//#UC END# *48FF64E700E5_4683630000A0_impl*
end;//TnsContentsTree.BeforeReset
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
