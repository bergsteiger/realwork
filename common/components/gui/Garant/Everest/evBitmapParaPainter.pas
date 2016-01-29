unit evBitmapParaPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evBitmapParaPainter.pas"
// Начат: 16.12.2002 14:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::LeafPara Painters::TevBitmapParaPainter
//
// "рисователь" параграфа с картинкой. Реализует интерфейс IevPainter.
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
  evLeafParaPainter
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevBitmapParaPainter = class(TevLeafParaPainter)
  {* "рисователь" параграфа с картинкой. Реализует интерфейс IevPainter. }
 protected
 // overridden protected methods
   procedure DoFillSelection; override;
   function DrawLeaf: Boolean; override;
 end;//TevBitmapParaPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}

// start class TevBitmapParaPainter

procedure TevBitmapParaPainter.DoFillSelection;
//#UC START# *4804B86403BE_4804CBCA0090_var*
//#UC END# *4804B86403BE_4804CBCA0090_var*
begin
//#UC START# *4804B86403BE_4804CBCA0090_impl*
//#UC END# *4804B86403BE_4804CBCA0090_impl*
end;//TevBitmapParaPainter.DoFillSelection

function TevBitmapParaPainter.DrawLeaf: Boolean;
//#UC START# *4804C81000B9_4804CBCA0090_var*
//#UC END# *4804C81000B9_4804CBCA0090_var*
begin
//#UC START# *4804C81000B9_4804CBCA0090_impl*
 Result := DrawPicture;
//#UC END# *4804C81000B9_4804CBCA0090_impl*
end;//TevBitmapParaPainter.DrawLeaf

{$IfEnd} //evNeedPainters

end.