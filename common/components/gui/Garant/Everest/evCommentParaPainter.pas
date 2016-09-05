unit evCommentParaPainter;
 {* Реализация интерфейса IevPainter для блока с комментариями }

// Модуль: "w:\common\components\gui\Garant\Everest\evCommentParaPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCommentParaPainter" MUID: (49DB2E390053)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evDocumentPartPainter
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevCommentParaPainter = class(TevDocumentPartPainter)
  {* Реализация интерфейса IevPainter для блока с комментариями }
  protected
   function InfiniteFrame: Boolean; override;
   procedure GetFramePartPrim(aFrame: Tl3Variant;
    anIndex: Tl3FramePartIndex;
    var thePart: TnevFramePart); override;
   procedure DoDrawFrameText(aTop: Boolean); override;
   procedure DrawFrameName; override;
    {* Рисует имя блока в области рамки }
   function NeedDrawPlus: Boolean; override;
    {* Нужно ли рисовать плюс/минус для открытия/сворачивания блока }
 end;//TevCommentParaPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , TextPara_Const
 , evdStyles
 , k2Tags
 , k2Base
 , Graphics
 , l3Units
 , l3MinMax
 , l3String
 , nevInterfaces
 //#UC START# *49DB2E390053impl_uses*
 //#UC END# *49DB2E390053impl_uses*
;

function TevCommentParaPainter.InfiniteFrame: Boolean;
//#UC START# *4804B78B0397_49DB2E390053_var*
//#UC END# *4804B78B0397_49DB2E390053_var*
begin
//#UC START# *4804B78B0397_49DB2E390053_impl*
 Result := false;
 // - не надо рисовать рамку в бесконечность
//#UC END# *4804B78B0397_49DB2E390053_impl*
end;//TevCommentParaPainter.InfiniteFrame

procedure TevCommentParaPainter.GetFramePartPrim(aFrame: Tl3Variant;
 anIndex: Tl3FramePartIndex;
 var thePart: TnevFramePart);
//#UC START# *4804B9BB0383_49DB2E390053_var*
//#UC END# *4804B9BB0383_49DB2E390053_var*
begin
//#UC START# *4804B9BB0383_49DB2E390053_impl*
 if (anIndex = l3_fpiUp) OR
    (anIndex = l3_fpiDown) then
 begin
  //thePart.rVisible := True;
  thePart.rDrawType := lpdDraw;
  thePart.rColor := clBlack;
  thePart.rWidth := 1;
  thePart.rSpaceBefore := evDocumentPartMargin div 2;
  thePart.rSpaceAfter := evDocumentPartMargin div 2;
 end//anIndex = k2_tiFrameUp
 else
  thePart.rDrawType := lpdHidden;//lpdSpecialDraw;
  //thePart.rVisible := False;
//#UC END# *4804B9BB0383_49DB2E390053_impl*
end;//TevCommentParaPainter.GetFramePartPrim

procedure TevCommentParaPainter.DoDrawFrameText(aTop: Boolean);
//#UC START# *4804C35B00B2_49DB2E390053_var*
var
 l_NCR  : Tl3Rect;
//#UC END# *4804C35B00B2_49DB2E390053_var*
begin
//#UC START# *4804C35B00B2_49DB2E390053_impl*
 if not aTop then
  Exit;
 if IsTopAnchorAtStart then
 begin
  Area.rCanvas.Font := FormatInfo.FrameTextFont;
  l_NCR := Area.rCanvas.PushClipRect;
  try
   l_NCR.Right := Min(l_NCR.Right, FormatInfo.rLimitWidth);
   Area.rCanvas.ClipRect := l_NCR;
   Area.rCanvas.TextOut(l3Point(evDocumentPartMargin {div 2}, -evDocumentPartMargin div 2),
              l3PCharLen(str_nevmmComment.AsCStr));
  finally
   Area.rCanvas.PopClipRect;
  end;//try..finally
 end;//IsTopAnchorAtStart
//#UC END# *4804C35B00B2_49DB2E390053_impl*
end;//TevCommentParaPainter.DoDrawFrameText

procedure TevCommentParaPainter.DrawFrameName;
 {* Рисует имя блока в области рамки }
//#UC START# *49DB1B9E0191_49DB2E390053_var*
//#UC END# *49DB1B9E0191_49DB2E390053_var*
begin
//#UC START# *49DB1B9E0191_49DB2E390053_impl*
//#UC END# *49DB1B9E0191_49DB2E390053_impl*
end;//TevCommentParaPainter.DrawFrameName

function TevCommentParaPainter.NeedDrawPlus: Boolean;
 {* Нужно ли рисовать плюс/минус для открытия/сворачивания блока }
//#UC START# *49DB1BF30312_49DB2E390053_var*
//#UC END# *49DB1BF30312_49DB2E390053_var*
begin
//#UC START# *49DB1BF30312_49DB2E390053_impl*
 {$IfDef evCommentParaHasPlus}
 Result := true;
 {$Else  evCommentParaHasPlus}
 Result := false;
 {$EndIf evCommentParaHasPlus}
//#UC END# *49DB1BF30312_49DB2E390053_impl*
end;//TevCommentParaPainter.NeedDrawPlus
{$IfEnd} // Defined(evNeedPainters)

end.
