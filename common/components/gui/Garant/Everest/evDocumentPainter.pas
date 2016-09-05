unit evDocumentPainter;
 {* "рисователь" документа }

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDocumentPainter" MUID: (49DA417B010F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evParaListPainter
;

type
 TevDocumentPainter = class(TevParaListPainter)
  {* "рисователь" документа }
  private
   f_ArrowWasDrawn: Boolean;
  protected
   function DoDraw: Boolean; override;
    {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure DoDrawFrameText(aTop: Boolean); override;
 end;//TevDocumentPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , nevBase
 , l3Units
 , l3Const
 //#UC START# *49DA417B010Fimpl_uses*
 //#UC END# *49DA417B010Fimpl_uses*
;

function TevDocumentPainter.DoDraw: Boolean;
 {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
//#UC START# *4804BC2401C2_49DA417B010F_var*
//#UC END# *4804BC2401C2_49DA417B010F_var*
begin
//#UC START# *4804BC2401C2_49DA417B010F_impl*
 f_ArrowWasDrawn := False;
 Result := inherited DoDraw;
//#UC END# *4804BC2401C2_49DA417B010F_impl*
end;//TevDocumentPainter.DoDraw

procedure TevDocumentPainter.DoDrawFrameText(aTop: Boolean);
//#UC START# *4804C35B00B2_49DA417B010F_var*
//#UC END# *4804C35B00B2_49DA417B010F_var*
begin
//#UC START# *4804C35B00B2_49DA417B010F_impl*
 inherited DoDrawFrameText(aTop);
 if IsTopAnchorAtStart then
 begin
  with Area.rCanvas do
  begin
   PushWO;
   try
    CheckFormatInfo;
    if Printing then
     MoveWindowOrg(l3PointX(-FormatInfo.Spacing.Left));
    DrawDecorObject(false, aTop);
   finally
    PopWO;
   end;//try..finally
  end;//with Area.rCanvas
 end;//IsTopAnchorAtStart
//#UC END# *4804C35B00B2_49DA417B010F_impl*
end;//TevDocumentPainter.DoDrawFrameText
{$IfEnd} // Defined(evNeedPainters)

end.
