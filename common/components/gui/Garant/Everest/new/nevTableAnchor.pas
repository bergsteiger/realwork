unit nevTableAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTableAnchor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevTableAnchor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\new\nevDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevParaListAnchor,
  k2Interfaces
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevTableAnchor = class(TnevParaListAnchor)
 protected
 // overridden protected methods
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); override;
 end;//TnevTableAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TnevTableAnchor

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

{$IfEnd} //k2ForEditor

end.