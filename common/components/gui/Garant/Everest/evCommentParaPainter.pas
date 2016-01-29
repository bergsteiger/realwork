unit evCommentParaPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCommentParaPainter.pas"
// Начат: 10.11.2004 19:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevCommentParaPainter
//
// Реализация интерфейса IevPainter для блока с комментариями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters)}
uses
  evDocumentPartPainter,
  l3Interfaces,
  nevBase,
  l3Variant
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevCommentParaPainter = class(TevDocumentPartPainter)
  {* Реализация интерфейса IevPainter для блока с комментариями }
 protected
 // overridden protected methods
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
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evDocumentPart
  {$IfEnd} //k2ForEditor
  ,
  TextPara_Const,
  evdStyles,
  k2Tags,
  k2Base,
  Graphics,
  l3Units,
  l3MinMax,
  l3String,
  nevInterfaces
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}

// start class TevCommentParaPainter

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
//#UC START# *49DB1B9E0191_49DB2E390053_var*
//#UC END# *49DB1B9E0191_49DB2E390053_var*
begin
//#UC START# *49DB1B9E0191_49DB2E390053_impl*
//#UC END# *49DB1B9E0191_49DB2E390053_impl*
end;//TevCommentParaPainter.DrawFrameName

function TevCommentParaPainter.NeedDrawPlus: Boolean;
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

{$IfEnd} //evNeedPainters

end.