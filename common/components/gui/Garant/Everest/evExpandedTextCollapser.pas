unit evExpandedTextCollapser;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evExpandedTextCollapser.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevExpandedTextCollapser
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
  evParaCollapser,
  nevTools,
  nevDecorActiveHyperlink
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevExpandedTextCollapser = class(TevParaCollapser)
 protected
 // overridden protected methods
   function DoCollapse(const aView: InevControlView): Boolean; override;
 public
 // overridden public methods
   function GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass; override;
 end;//TevExpandedTextCollapser
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  nevBase,
  evExpandedTextActiveHyperlink
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  k2Tags
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TevExpandedTextCollapser

function TevExpandedTextCollapser.DoCollapse(const aView: InevControlView): Boolean;
//#UC START# *4E1D87640086_552FAA38015B_var*
//#UC END# *4E1D87640086_552FAA38015B_var*
begin
//#UC START# *4E1D87640086_552FAA38015B_impl*
 Result := EvExpandOrCollapse(aView, f_Para);
//#UC END# *4E1D87640086_552FAA38015B_impl*
end;//TevExpandedTextCollapser.DoCollapse

function TevExpandedTextCollapser.GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass;
//#UC START# *55F7C7110022_552FAA38015B_var*
//#UC END# *55F7C7110022_552FAA38015B_var*
begin
//#UC START# *55F7C7110022_552FAA38015B_impl*
 Result := TevExpandedTextActiveHyperlink;
//#UC END# *55F7C7110022_552FAA38015B_impl*
end;//TevExpandedTextCollapser.GetDecorActiveHyperlinkClass

{$IfEnd} //evNeedHotSpot

end.