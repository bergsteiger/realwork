unit DropDownTree;

interface

uses
 l3IntfUses
 , AbstractDropDown
 , l3ControlsTypes
 , ImgList
 , l3TreeInterfaces
 , Messages
 , ctTypes
 , Types
 , Windows
 , Controls
 , nevTools
 , Classes
 , vcmExternalInterfaces
 , AbsSubTree
;

type
 TSubTree = class;
 
 TDropDownTreePrim = class(TAbstractDropDown)
  procedure RecreateTreeIfNeeded(aValue: TComboStyle);
  function CreateSubTree: TSubTree;
  function CursorStored: Boolean;
  function EstimateTreeHeight(aMinSize: Integer;
   aMaxSize: Integer): Integer;
  function EstimateTreeWidth(aMaxSizeX: Integer;
   aSizeY: Integer): Integer;
  procedure CalcDropDimensions;
  procedure DropSessionSettings;
  function CalcGrowingWidth: Integer;
  procedure TreeChangedNotification;
  procedure ActionElementHandler(Sender: TObject;
   Index: LongInt);
  procedure ProcessTreeSelect(ChooseFromTree: Boolean;
   aTriggerSelect: Boolean);
  function GetItemImageHandler(Sender: TObject;
   anIndex: Integer;
   var aImages: TCustomImageList): Integer;
  procedure CustomDoEnter;
  function InnerPoint(const aPoint: TPoint): Boolean;
  function IsInnerControl(aHandle: THandle): Boolean;
  procedure WMLButtonDown(var Message: TWMLButtonDown);
  procedure WMLButtonUp(var Message: TWMLButtonDown);
  procedure WMKillFocus(var Message: TWMKillFocus);
  procedure WMSetFocus(var Message: TWMSetFocus);
  procedure CMArtfulBehaviour(var Message: TMessage);
  function TreeImagesStored: Boolean;
   {* "‘ункци€ определ€юща€, что свойство TreeImages сохран€етс€" }
  function GetActiveSub: TWinControl;
 end;//TDropDownTreePrim
 
 TSubTree = class(TAbsSubTree)
  procedure Create(aOwner: TDropDownTreePrim);
  procedure WMSetFocus(var Message: TMessage);
  procedure WMExitSizeMove(var Message: TMessage);
  procedure WMEnterSizeMove(var Message: TMessage);
  function IsSizeableTree: Boolean;
  function IsShowGripper: Boolean;
  function IsList: Boolean;
  function IsInvert: Boolean;
  function IsOwnerAssigned: Boolean;
  function GetWidth: Integer;
 end;//TSubTree
 
 TDropDownTree = class(TDropDownTreePrim)
 end;//TDropDownTree
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , l3MinMax
 , afwFacade
 , SysUtils
 , Forms
 , l3ListenersManager
;

end.
