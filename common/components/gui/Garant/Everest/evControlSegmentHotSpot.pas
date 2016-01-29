unit evControlSegmentHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evControlSegmentHotSpot.pas"
// Начат: 12.11.2004 15:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevControlSegmentHotSpot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  evSegmentHotSpot,
  afwInterfaces,
  nevTools
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevControlSegmentHotSpot = class(TevSegmentHotSpot)
 protected
 // overridden protected methods
   procedure DoHitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); override;
 end;//TevControlSegmentHotSpot
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}

// start class TevControlSegmentHotSpot

procedure TevControlSegmentHotSpot.DoHitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *4A267FC6016B_4A27A44403BE_var*
//#UC END# *4A267FC6016B_4A27A44403BE_var*
begin
//#UC START# *4A267FC6016B_4A27A44403BE_impl*
 inherited;
 theInfo.rHint := nil;
//#UC END# *4A267FC6016B_4A27A44403BE_impl*
end;//TevControlSegmentHotSpot.DoHitTest

{$IfEnd} //evNeedHotSpot

end.