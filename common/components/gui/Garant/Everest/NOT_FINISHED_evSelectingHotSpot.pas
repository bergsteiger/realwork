unit NOT_FINISHED_evSelectingHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evSelectingHotSpot.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevSelectingHotSpot
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  nevGUIInterfaces,
  evHotSpot,
  nevTools,
  l3Variant,
  l3Interfaces
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 _nevParaListTool_Parent_ = TevHotSpot;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 TevSelectingHotSpot = class(_nevParaListTool_, IevAdvancedHotSpot)
 protected
 // realized methods
   function MouseAction(const aView: InevControlView;
    aButton: Tl3MouseButton;
    anAction: Tl3MouseAction;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
     {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
   function CanDrag: Boolean;
 end;//TevSelectingHotSpot
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  SysUtils
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

// start class TevSelectingHotSpot

function TevSelectingHotSpot.MouseAction(const aView: InevControlView;
  aButton: Tl3MouseButton;
  anAction: Tl3MouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
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

{$IfEnd} //evNeedHotSpot

end.