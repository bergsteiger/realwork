unit evExpandedTextCollapser;

// Модуль: "w:\common\components\gui\Garant\Everest\evExpandedTextCollapser.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevExpandedTextCollapser" MUID: (552FAA38015B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evParaCollapser
 , nevDecorActiveHyperlink
 , nevTools
;

type
 TevExpandedTextCollapser = class(TevParaCollapser)
  protected
   function DoCollapse(const aView: InevControlView): Boolean; override;
  public
   function GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass; override;
 end;//TevExpandedTextCollapser
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , nevBase
 , evExpandedTextActiveHyperlink
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2Tags
;

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
{$IfEnd} // Defined(evNeedHotSpot)

end.
