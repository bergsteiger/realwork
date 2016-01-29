unit evDocumentPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDocumentPainter.pas"
// Начат: 10.11.97 12:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevDocumentPainter
//
// "рисователь" документа
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
  evParaListPainter
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevDocumentPainter = class(TevParaListPainter)
  {* "рисователь" документа }
 private
 // private fields
   f_ArrowWasDrawn : Boolean;
 protected
 // overridden protected methods
   function DoDraw: Boolean; override;
     {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure DoDrawFrameText(aTop: Boolean); override;
 end;//TevDocumentPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  nevBase,
  l3Units,
  l3Const
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}

// start class TevDocumentPainter

function TevDocumentPainter.DoDraw: Boolean;
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

{$IfEnd} //evNeedPainters

end.