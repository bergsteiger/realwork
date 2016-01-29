unit evDropTree;

interface

uses
 l3IntfUses
 , AbsSubTree
 , Classes
 , Messages
 , l3TreeInterfaces
;

type
 TChooseItem = procedure(Sender: TObject;
  const Value: Il3SimpleNode) of object;
 
 TCheckEvent = function: Boolean of object;
 
 TevDropTree = class(TAbsSubTree)
  procedure Init(anInvert: Boolean;
   anIsList: Boolean;
   aWidth: Integer);
  procedure WMExitSizeMove(var Message: TMessage);
  procedure WMEnterSizeMove(var Message: TMessage);
  procedure WMActivate(var Message: TWMActivate);
  procedure WMLButtonDown(var Msg: TWMLButtonDown);
  function IsSizeableTree: Boolean;
  function IsShowGripper: Boolean;
  function IsList: Boolean;
  function IsInvert: Boolean;
  function IsOwnerAssigned: Boolean;
  function GetWidth: Integer;
 end;//TevDropTree
 
implementation

uses
 l3ImplUses
 , Windows
 , l3ControlsTypes
 , TtfwClassRef_Proxy
;

end.
