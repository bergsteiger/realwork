unit evArchiCollapser;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evArchiCollapser.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevArchiCollapser
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
  nevTools,
  afwNavigation
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevArchiCollapser = class(TevSegmentHotSpot)
 protected
 // overridden protected methods
   function TryDoHyperlink(const aView: InevControlView;
     anEffects: TafwJumpToEffects): Boolean; override;
 end;//TevArchiCollapser
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  SysUtils
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TevArchiCollapser

function TevArchiCollapser.TryDoHyperlink(const aView: InevControlView;
  anEffects: TafwJumpToEffects): Boolean;
//#UC START# *4A269489009C_5530B9E90041_var*
//#UC END# *4A269489009C_5530B9E90041_var*
var
 l_MonikerSink : IevMonikerSink;
begin
//#UC START# *4A269489009C_5530B9E90041_impl*
 Result := EvExpandOrCollapse(aView, GetDownPointPara);
//#UC END# *4A269489009C_5530B9E90041_impl*
end;//TevArchiCollapser.TryDoHyperlink

{$IfEnd} //evNeedHotSpot

end.