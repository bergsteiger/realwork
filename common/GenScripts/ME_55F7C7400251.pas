unit evExpandedTextActiveHyperlink;

// Модуль: "w:\common\components\gui\Garant\Everest\evExpandedTextActiveHyperlink.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , nevDecorActiveHyperlink
 , nevTools
;

type
 TevExpandedTextActiveHyperlink = class(TnevDecorActiveHyperlink)
  protected
   function DoIsSame(const anElement: InevActiveElement): Boolean; override;
 end;//TevExpandedTextActiveHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
;

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
{$IfEnd} // Defined(evNeedHotSpot)

end.
