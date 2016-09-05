unit nevFormatInfoFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevFormatInfoFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevFormatInfoFactory" MUID: (4E16E263024F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevFormatInfo
 , nevBase
;

type
 TnevFormatInfoFactory = class
  public
   class function CreateFormatInfo(const aChild: InevObjectPrim;
    aParent: TnevFormatInfo;
    const aMetrics: InevViewMetrics): TnevFormatInfo;
 end;//TnevFormatInfoFactory

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , TextPara_Const
 , CommentPara_Const
 , SBS_Const
 , SBSRow_Const
 , TableRow_Const
 , ReqRow_Const
 , SBSCell_Const
 , TableCell_Const
 , nevFacade
 , nevTableCellFormatInfo
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , l3MinMax
 , evSectionPara
 , nevListFormatInfo
 , nevRubberCellsRenderInfo
 , nevTableRowRenderInfo
 , nevTextParaRenderInfo
 , nevZoomedCellsRenderInfo
 , nevZoomedRubberCellsRenderInfo
 , nevLeafRenderInfo
 , Block_Const
 , Document_Const
 , nevDocumentPartFormatInfo
 , nevCommentFormatInfo
 , nevBitmapFormatInfo
 , nevControlFormatInfo
 , nevFormulaFormatInfo
 , Formula_Const
 , ControlPara_Const
 , BitmapPara_Const
 , nevControlsBlockFormatInfo
 , nevCloakFormatInfo
 , ControlsBlock_Const
 , Cloak_Const
 , nevSegmentFormatInfo
 , TextSegment_Const
 , nevObjectSegmentFormatInfo
 , ObjectSegment_Const
 , nevDocumentFormatInfo
 , k2Base
 , nevSBSCellFormatInfo
 , nevSBSRowFormatInfo
 , nevTableRowRenderInfoEx
 , nevReqRowFormatInfo
 , nevPageBreakFormatInfo
 , PageBreak_Const
 , nevNodeGroupFormatInfo
 , NodeGroup_Const
 //#UC START# *4E16E263024Fimpl_uses*
 //#UC END# *4E16E263024Fimpl_uses*
;

class function TnevFormatInfoFactory.CreateFormatInfo(const aChild: InevObjectPrim;
 aParent: TnevFormatInfo;
 const aMetrics: InevViewMetrics): TnevFormatInfo;
//#UC START# *4E16E29D02DF_4E16E263024F_var*
var
 l_FormatInfoRef : RnevFormatInfo;
 l_T : Tk2Type;
 l_C : TClass;
//#UC END# *4E16E29D02DF_4E16E263024F_var*
begin
//#UC START# *4E16E29D02DF_4E16E263024F_impl*
 l_FormatInfoRef := nil;
 l_T := Tk2Type(aChild.AsObject.TagType);
 Assert(l_T <> nil);
 l_C := l_T.FormatInfoFactory;
 if (l_C = nil) then
 begin
  if aChild.IsList then
  begin
   if l_T.IsKindOf(k2_typDocument) then
    l_FormatInfoRef := TnevDocumentFormatInfo
   else
   if l_T.IsKindOf(k2_typBlock) then
   begin
    if l_T.IsKindOf(k2_typCloak) then
     l_FormatInfoRef := TnevCloakFormatInfo
    else
    if l_T.IsKindOf(k2_typNodeGroup) then
     l_FormatInfoRef := TnevNodeGroupFormatInfo
    else
    if l_T.IsKindOf(k2_typControlsBlock) then
     l_FormatInfoRef := TnevControlsBlockFormatInfo
    else
    if l_T.IsKindOf(k2_typCommentPara) then
     l_FormatInfoRef := TnevCommentFormatInfo
    else
     l_FormatInfoRef := TnevDocumentPartFormatInfo;
   end//l_T.IsKindOf(k2_typBlock)
   else
   if l_T.IsKindOf(k2_typReqRow) then
    l_FormatInfoRef := TnevReqRowFormatInfo
   else 
   if l_T.IsKindOf(k2_typSBSRow) then
    l_FormatInfoRef := TnevSBSRowFormatInfo
   else
   if l_T.IsKindOf(k2_typTableRow) then
    l_FormatInfoRef := TnevTableRowRenderInfoEx
   else
   if l_T.IsKindOf(k2_typSBSCell) then
    l_FormatInfoRef := TnevSBSCellFormatInfo
   else
   if l_T.IsKindOf(k2_typTableCell) then
    l_FormatInfoRef := TnevTableCellFormatInfo
   else
    l_FormatInfoRef := TnevListFormatInfo;
  end//aChild.IsList
  else
  begin
   if l_T.IsKindOf(k2_typTextPara) then
   begin
    if l_T.IsKindOf(k2_typFormula) then
     l_FormatInfoRef := TnevFormulaFormatInfo
    else
    if l_T.IsKindOf(k2_typControlPara) then
     l_FormatInfoRef := TnevControlFormatInfo
    else
     l_FormatInfoRef := TnevTextParaRenderInfo;
   end//l_T.IsKindOf(k2_typTextPara)
   else
   if l_T.IsKindOf(k2_typObjectSegment) then
    l_FormatInfoRef := TnevObjectSegmentFormatInfo
   else
   if l_T.IsKindOf(k2_typTextSegment) then
    l_FormatInfoRef := TnevSegmentFormatInfo
   else
   if l_T.IsKindOf(k2_typBitmapPara) then
    l_FormatInfoRef := TnevBitmapFormatInfo
   else
   if l_T.IsKindOf(k2_typPageBreak) then
    l_FormatInfoRef := TnevPageBreakFormatInfo
   else
    l_FormatInfoRef := TnevLeafRenderInfo;
  end;//aChild.IsList
  l_T.FormatInfoFactory := l_FormatInfoRef;
 end//l_C = nil
 else
 begin
  Assert(l_C.InheritsFrom(TnevFormatInfo));
  l_FormatInfoRef := RnevFormatInfo(l_C);
 end;//l_C = nil
 Assert(l_FormatInfoRef <> nil);
 Result := l_FormatInfoRef.CreateInst(aChild, aParent, aMetrics);
//#UC END# *4E16E29D02DF_4E16E263024F_impl*
end;//TnevFormatInfoFactory.CreateFormatInfo

end.
