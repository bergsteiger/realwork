unit evSelectingHotSpot;

interface

uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , l3Interfaces
;

type
 TevSelectingHotSpot = class(_nevParaListTool_, IevAdvancedHotSpot)
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
  function CanDrag: Boolean;
 end;//TevSelectingHotSpot
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
