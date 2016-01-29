unit evExpandedTextActiveHyperlink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evExpandedTextActiveHyperlink.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevExpandedTextActiveHyperlink
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
  nevDecorActiveHyperlink,
  nevTools
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevExpandedTextActiveHyperlink = class(TnevDecorActiveHyperlink)
 protected
 // overridden protected methods
   function DoIsSame(const anElement: InevActiveElement): Boolean; override;
 end;//TevExpandedTextActiveHyperlink
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}

// start class TevExpandedTextActiveHyperlink

function TevExpandedTextActiveHyperlink.DoIsSame(const anElement: InevActiveElement): Boolean;
//#UC START# *4E1DB93401C4_55F7C7400251_var*
//#UC END# *4E1DB93401C4_55F7C7400251_var*
begin
//#UC START# *4E1DB93401C4_55F7C7400251_impl*
 Result := anElement <> nil;
 if Result then
  Result := Get_Obj.AsObject.Box.IsSame(anElement.Para.AsObject.Box);
//#UC END# *4E1DB93401C4_55F7C7400251_impl*
end;//TevExpandedTextActiveHyperlink.DoIsSame

{$IfEnd} //evNeedHotSpot

end.