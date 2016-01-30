unit nsParaListNodeModelPart;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParaListNodeModelPart.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsParentedTagNode
 , F1TagDataProviderInterface
 , l3Interfaces
 , l3Variant
 , nevTools
;

type
 TnsParaListNodeModelPart = class(TnsParentedTagNode)
  protected
   f_CurIndex: Integer;
   f_CurNode: If1TagDataProvider;
  protected
   procedure ClearFields; override;
  public
   function MakeChildTag(aChildIndex: Integer;
    const aNode: If1TagDataProvider;
    aState: TnsNodeStates = []): Il3TagRef;
 end;//TnsParaListNodeModelPart

implementation

uses
 l3ImplUses
 , LeafPara_Const
 , k2Facade
 , k2Base
 , nsNativeCommentPara
 , CommentPara_Const
 , LeafParaDecorationsHolder_Const
 , k2Tags
 , nsLeafParaDecorationsHolder
 , nsTagString
 , SysUtils
 , TextPara_Const
 , IOUnit
 , evdStyles
 , Document_Const
 , Block_Const
 , DecorTextPara_Const
;

function TnsParaListNodeModelPart.MakeChildTag(aChildIndex: Integer;
 const aNode: If1TagDataProvider;
 aState: TnsNodeStates = []): Il3TagRef;
//#UC START# *4CEFAD320395_4CEFA95A0301_var*

 procedure MakeTechComment(const aNode: If1TagDataProvider);
 var
  l_TechComment : IString;
  l_TechCommentPara : Tl3Variant;
  l_Text            : TnsTagString;
 begin//MakeTechComment
  l_TechComment := aNode.TechComment;
  if (l_TechComment <> nil) then
   try
    if (l_TechComment.GetLength > 0) then
    begin
     if (l_HolderTag = nil) then
     begin
      l_HolderTag := TnsLeafParaDecorationsHolder.Make;
      l_HolderTag.AsObject.Owner := Self;
     end;//l_HolderTag = nil
     l_TechCommentPara := k2_typDecorTextPara.MakeTag.AsObject;
     try
      l_Text := TnsTagString.Create(l_TechComment);
      try
       l_TechCommentPara.AttrW[k2_tiText, nil] := l_Text;
       l_TechCommentPara.IntA[k2_tiStyle] := ev_saTechComment;
       l_HolderTag.AsObject.AddChild(l_TechCommentPara);
      finally
       FreeAndNil(l_Text);
      end;//try..finally
     finally
      l_TechCommentPara := nil;
     end;//try..finaly
    end;//l_TechComment.GetLength > 0
   finally
    l_TechComment := nil;
   end;//try..finally
 end;//MakeTechComment

var
 l_ID : Integer;
 l_IsLeaf  : Boolean;
 l_IsBlock : Boolean;
//#UC END# *4CEFAD320395_4CEFA95A0301_var*
begin
//#UC START# *4CEFAD320395_4CEFA95A0301_impl*
 Result := TnsParentedTagNode.MakeNodeTag(aNode,
                           Self,
                           (f_State * [ns_nsNotNeedSynchronizeWithTree]) + aState);
 l_HolderTag := nil;
(* if (aChildIndex = 0) AND
    Self.InheritsFrom(k2_typDocument) then
  MakeTechComment(Self.TagDataProvider);*)
 l_IsLeaf := Result.AsObject.IsKindOf(k2_typLeafPara);
 if l_IsLeaf then
  l_IsBlock := false
 else
  l_IsBlock := Result.AsObject.IsKindOf(k2_typBlock);
 if l_IsBlock then
 begin
//  MakeTechComment(aNode);
 end//l_IsBlock
 else
 if l_IsLeaf then
 begin
  if (aChildIndex = 0) then
  begin
   if Self.IsKindOf(k2_typBlock) then
   begin
    // !!! Здесь может понадобиться РЕКУРСИЯ по всем родительским блокам вверх !!!
    // Если найдётся блок, который начинается НЕ с текстового параграфа 
    MakeTechComment(Self.TagDataProvider);
   end;//Self.IsKindOf(k2_typBlock)
  end;//aChildIndex = 0
  if Result.AsObject.Attr[k2_tiSubs].IsValid then
   MakeTechComment(aNode);
 end;//l_IsLeaf
 if (l_HolderTag <> nil) then
  l_HolderTag.AsObject.AddChild(Result.AsObject);
 if l_IsLeaf then
 begin
  l_Comment := aNode.Comment;
  if (l_Comment <> nil) then
  begin
   if (l_HolderTag = nil) then
   begin
    l_HolderTag := TnsLeafParaDecorationsHolder.Make;
    l_HolderTag.AsObject.Owner := Self;
    l_HolderTag.AsObject.AddChild(Result.AsObject);
   end;//l_HolderTag = nil
   l_CommentTag := TnsNativeCommentPara.MakeFromStyle(l_Comment, l_HolderTag.AsObject).AsObject;
   l_HolderTag.AsObject.AddChild(l_CommentTag);
   l_ID := Result.AsObject.IntA[k2_tiHandle];
   if (l_ID <> 0) then
    l_CommentTag.IntA[k2_tiHandle] := l_ID;
   if not Self.QT(InevPara, l_Para) then
    Assert(false);
   l_Container := l_Para.DocumentContainer;
   if (l_Container <> nil) then
    l_Container.RealizeSub(l_CommentTag.IntA[k2_tiLayerID],
                           l_CommentTag,
                           l_CommentTag);
  end;//l_Comment <> nil
 end;//Result.AsObject.IsKindOf(k2_typLeafPara)
 if (l_HolderTag <> nil) then
 begin
  l_HolderTag.AsObject.Owner := Self;
  Result := l_HolderTag;
 end;//l_HolderTag <> nil
//#UC END# *4CEFAD320395_4CEFA95A0301_impl*
end;//TnsParaListNodeModelPart.MakeChildTag

procedure TnsParaListNodeModelPart.ClearFields;
begin
 f_CurNode := nil;
 inherited;
end;//TnsParaListNodeModelPart.ClearFields

end.
