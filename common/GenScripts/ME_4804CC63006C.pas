unit evFormulaPainter;

// Модуль: "w:\common\components\gui\Garant\Everest\evFormulaPainter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evTextParaPainterEx
 , l3InternalInterfaces
;

type
 TevFormulaPainter = class(TevTextParaPainterEx)
  protected
   procedure DoFillSelection; override;
   function DrawLeaf: Boolean; override;
   function GetBitmapForPara: Il3Bitmap; override;
 end;//TevFormulaPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , k2Tags
;

procedure TevFormulaPainter.DoFillSelection;
//#UC START# *4804B86403BE_4804CC63006C_var*
//#UC END# *4804B86403BE_4804CC63006C_var*
begin
//#UC START# *4804B86403BE_4804CC63006C_impl*
//#UC END# *4804B86403BE_4804CC63006C_impl*
end;//TevFormulaPainter.DoFillSelection

function TevFormulaPainter.DrawLeaf: Boolean;
//#UC START# *4804C81000B9_4804CC63006C_var*
//#UC END# *4804C81000B9_4804CC63006C_var*
begin
//#UC START# *4804C81000B9_4804CC63006C_impl*
 if ParaX.AsObject.BoolA[k2_tiCollapsed] then
 begin
  //evCheckRenderedFormula(ParaX);
  Result := DrawPicture
 end//ParaX.BoolA[k2_tiCollapsed]
 else
  Result := inherited DrawLeaf;
//#UC END# *4804C81000B9_4804CC63006C_impl*
end;//TevFormulaPainter.DrawLeaf

function TevFormulaPainter.GetBitmapForPara: Il3Bitmap;
//#UC START# *4E53B9A500B4_4804CC63006C_var*
//#UC END# *4E53B9A500B4_4804CC63006C_var*
begin
//#UC START# *4E53B9A500B4_4804CC63006C_impl*
 Result := inherited GetBitmapForPara;
//#UC END# *4E53B9A500B4_4804CC63006C_impl*
end;//TevFormulaPainter.GetBitmapForPara
{$IfEnd} // Defined(evNeedPainters)

end.
