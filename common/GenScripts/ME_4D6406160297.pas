unit NOT_FINISHED_evSelectingHotSpot;

// ћодуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSelectingHotSpot.pas"
// —тереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , l3Interfaces
 , l3Variant
;

type
 _nevParaListTool_Parent_ = TevHotSpot;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 TevSelectingHotSpot = class(_nevParaListTool_, IevAdvancedHotSpot)
  protected
   function MouseAction(const aView: InevControlView;
    aButton: Tl3MouseButton;
    anAction: Tl3MouseAction;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
    {* обрабатывает событие от мыши. ¬озвращает true - если обработано, иначе - false }
   function CanDrag: Boolean;
 end;//TevSelectingHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , SysUtils
;

type _Instance_R_ = TevSelectingHotSpot;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

function TevSelectingHotSpot.MouseAction(const aView: InevControlView;
 aButton: Tl3MouseButton;
 anAction: Tl3MouseAction;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
 {* обрабатывает событие от мыши. ¬озвращает true - если обработано, иначе - false }
//#UC START# *48E263CD01BD_4D6406160297_var*
//#UC END# *48E263CD01BD_4D6406160297_var*
begin
//#UC START# *48E263CD01BD_4D6406160297_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E263CD01BD_4D6406160297_impl*
end;//TevSelectingHotSpot.MouseAction

function TevSelectingHotSpot.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4D6406160297_var*
//#UC END# *4ECCD6840014_4D6406160297_var*
begin
//#UC START# *4ECCD6840014_4D6406160297_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ECCD6840014_4D6406160297_impl*
end;//TevSelectingHotSpot.CanDrag
{$IfEnd} // Defined(evNeedHotSpot)

end.
