unit evCollapserHyperlink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCollapserHyperlink.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevCollapserHyperlink
//
// Сворачивающая гиперссылка.
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
  evDecorHyperlink,
  evdTypes
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevCollapserHyperlink = class(TevDecorHyperlink)
  {* Сворачивающая гиперссылка. }
 protected
 // overridden protected methods
   function DoGetKind: TevLinkViewKind; override;
 end;//TevCollapserHyperlink
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}

// start class TevCollapserHyperlink

function TevCollapserHyperlink.DoGetKind: TevLinkViewKind;
//#UC START# *55F6C6DC018B_55F6C74B033E_var*
//#UC END# *55F6C6DC018B_55F6C74B033E_var*
begin
//#UC START# *55F6C6DC018B_55F6C74B033E_impl*
 Result := ev_lvkShellInternal;
//#UC END# *55F6C6DC018B_55F6C74B033E_impl*
end;//TevCollapserHyperlink.DoGetKind

{$IfEnd} //evNeedHotSpot

end.