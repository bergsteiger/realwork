unit nsParentedTagNode;
 {* Тег над адаптерной нодой, представляющий ссылку на родителя }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagNode.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsTagNodePrim
 , k2Base
 , l3Variant
 , F1TagDataProviderInterface
;

type
 _k2ParentedTagObject_Parent_ = TnsTagNodePrim;
 {$Include k2ParentedTagObject.imp.pas}
 TnsParentedTagNode = class(_k2ParentedTagObject_)
  {* Тег над адаптерной нодой, представляющий ссылку на родителя }
  public
   class function MakeNodeTag(const aNode: DocTagNodeType;
    aParent: Tl3Tag = nil;
    aState: TnsNodeStates = []): Il3TagRef;
   constructor Create(aType: Tk2Type;
    const aNode: DocTagNodeType;
    aParent: Tl3Tag;
    aState: TnsNodeStates); reintroduce; virtual;
 end;//TnsParentedTagNode

implementation

uses
 l3ImplUses
 , nsLeafParaNode
 , nsParaListNode
 , k2NullTagImpl
 , k2Facade
 , QueryCard_Const
 , Document_Const
 , nsDocumentTagNodePrim
 , CommentPara_Const
 , Block_Const
 , ReqRow_Const
 , ReqCell_Const
 , ParaList_Const
 , ControlPara_Const
 , TextPara_Const
 , BitmapPara_Const
 , SectionBreak_Const
 , LeafPara_Const
 , SysUtils
 , nsSubNode
 , nsSectionBreakNode
 , nsTextParaNode
 , nsControlParaNode
 , nsBitmapParaNode
 , nsReqCellNode
 , nsReqRowNode
 , nsBlockNode
 , nsBlockNodePrim
;

{$Include k2ParentedTagObject.imp.pas}

class function TnsParentedTagNode.MakeNodeTag(const aNode: DocTagNodeType;
 aParent: Tl3Tag = nil;
 aState: TnsNodeStates = []): Il3TagRef;
//#UC START# *4C6E60FE0011_467FCD4401BD_var*
var
 l_Tag  : TnsParentedTagNode;
 l_Type : Tk2Type;
//#UC END# *4C6E60FE0011_467FCD4401BD_var*
begin
//#UC START# *4C6E60FE0011_467FCD4401BD_impl*
 if (aNode = nil) then
  Result := Tk2NullTagImpl.Instance
 else
 begin
  l_Type := aNode.TypeID;
  if (l_Type = nil) then
   Result := Tk2NullTagImpl.Instance
  else
  begin
   l_Tag := nil;
   if (aParent = nil) OR not aParent.IsValid then
   begin
    if l_Type.IsKindOf(k2_typQueryCard) then
    begin
     //l_Tag := TnsQueryCardNode.CreatePrim(aNode)
     l_Tag := nil;
     Assert(false, 'Устаревший код');
    end//l_Type.IsKindOf(k2_typQueryCard)
    else
    if l_Type.IsKindOf(k2_typDocument) then
    begin
     //l_Tag := TnsDocumentTagNode.CreatePrim(aNode);
     l_Tag := nil;
     Assert(false, 'Устаревший код');
    end;//l_Type.IsKindOf(k2_typDocument)
   end;//aParent = nil..
   if (l_Tag = nil) then
   begin
    if l_Type.IsKindOf(k2_typDocument) then
     l_Tag := TnsDocumentTagNodePrim.Create(l_Type, aNode, aParent, aState)
    else
    if l_Type.IsKindOf(k2_typCommentPara) then
    begin
     //l_Tag := TnsCommentNode.Create(l_Type, aNode, aParent, aState);
     l_Tag := nil;
     Assert(false, 'Устаревший код');
    end
    else
    if l_Type.IsKindOf(k2_typBlock) then
     l_Tag := TnsBlockNode.Create(l_Type, aNode, aParent, aState)
    else
    if l_Type.IsKindOf(k2_typReqRow) then
    begin
     l_Tag := TnsReqRowNode.Create(l_Type, aNode, aParent, aState);
    end//l_Type.IsKindOf(k2_typReqRow)
    else
    if l_Type.IsKindOf(k2_typReqCell) then
    begin
     l_Tag := TnsReqCellNode.Create(l_Type, aNode, aParent, aState);
    end//l_Type.IsKindOf(k2_typReqCell)
    else
    if l_Type.IsKindOf(k2_typParaList) then
     l_Tag := TnsParaListNode.Create(l_Type, aNode, aParent, aState)
    else
    if l_Type.IsKindOf(k2_typControlPara) then
    begin
     l_Tag := TnsControlParaNode.Create(l_Type, aNode, aParent, aState)
    end//l_Type.IsKindOf(k2_typControlPara)
    else
    if l_Type.IsKindOf(k2_typTextPara) then
     l_Tag := TnsTextParaNode.Create(l_Type, aNode, aParent, aState)
    else
    if l_Type.IsKindOf(k2_typBitmapPara) then
     l_Tag := TnsBitmapParaNode.Create(l_Type, aNode, aParent, aState)
    else
    if l_Type.IsKindOf(k2_typSectionBreak) then
     l_Tag := TnsSectionBreakNode.Create(l_Type, aNode, aParent, aState)
    else
    if l_Type.IsKindOf(k2_typLeafPara) then
     l_Tag := TnsLeafParaNode.Create(l_Type, aNode, aParent, aState)
    else
     l_Tag := Create(l_Type, aNode, aParent, aState);
   end;//l_Tag = nil
   try
    Result := l_Tag.AsRef;
   finally
    FreeAndNil(l_Tag);
   end;//try..finally
  end;//l_Type = nil
 end;//aNode = nil
//#UC END# *4C6E60FE0011_467FCD4401BD_impl*
end;//TnsParentedTagNode.MakeNodeTag

constructor TnsParentedTagNode.Create(aType: Tk2Type;
 const aNode: DocTagNodeType;
 aParent: Tl3Tag;
 aState: TnsNodeStates);
//#UC START# *4C6E60C80037_467FCD4401BD_var*
//#UC END# *4C6E60C80037_467FCD4401BD_var*
begin
//#UC START# *4C6E60C80037_467FCD4401BD_impl*
 f_Parent := aParent;
 inherited Create(aType, aNode, aState);
//#UC END# *4C6E60C80037_467FCD4401BD_impl*
end;//TnsParentedTagNode.Create

end.
