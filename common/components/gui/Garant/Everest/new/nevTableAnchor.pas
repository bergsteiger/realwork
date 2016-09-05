unit nevTableAnchor;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTableAnchor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevTableAnchor" MUID: (4F1EC738000E)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaListAnchor
 , k2Interfaces
;

type
 TnevTableAnchor = class(TnevParaListAnchor)
  protected
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); override;
 end;//TnevTableAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *4F1EC738000Eimpl_uses*
 //#UC END# *4F1EC738000Eimpl_uses*
;

procedure TnevTableAnchor.DoFire(const anEvent: Tk2Event;
 const anOp: Ik2Op);
//#UC START# *48CF73CE00B5_4F1EC738000E_var*
//#UC END# *48CF73CE00B5_4F1EC738000E_var*
begin
//#UC START# *48CF73CE00B5_4F1EC738000E_impl*
 inherited DoFire(anEvent, anOp);
 if (anEvent.ID = k2_eidChildrenDeleted) then
 begin
  if HasInner then
  begin
   GetInner.Outer := nil;
   SetInner(nil);
  end; // if HasInner then
 end;
//#UC END# *48CF73CE00B5_4F1EC738000E_impl*
end;//TnevTableAnchor.DoFire
{$IfEnd} // Defined(k2ForEditor)

end.
