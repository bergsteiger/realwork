unit evBitmapParaPainter;
 {* "рисователь" параграфа с картинкой. Реализует интерфейс IevPainter. }

// Модуль: "w:\common\components\gui\Garant\Everest\evBitmapParaPainter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evLeafParaPainter
;

type
 TevBitmapParaPainter = class(TevLeafParaPainter)
  {* "рисователь" параграфа с картинкой. Реализует интерфейс IevPainter. }
  protected
   procedure DoFillSelection; override;
   function DrawLeaf: Boolean; override;
 end;//TevBitmapParaPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
;

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
{$IfEnd} // Defined(evNeedPainters)

end.
