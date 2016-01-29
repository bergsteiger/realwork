unit nscCustomTreeComboWithHistory;

interface

uses
 l3IntfUses
 , DropDownTree
 , l3VCLStrings
 , l3TreeInterfaces
 , Graphics
 , l3ControlsTypes
 , l3Interfaces
 , Classes
 , afwFont
 , ExtCtrls
 , Messages
 , evEditorWithOperations
 , ctTypes
 , Types
 , Windows
 , l3InternalInterfaces
 , Controls
 , l3Region
 , vtLister
;

type
 TnscSubTree = class(TSubTree)
  procedure SetMouseTrackItemIndex(aIndex: Integer);
  procedure DrawCloseButton(aDC: hDC;
   const DrawRect: TRect);
  procedure WMNCLButtonDown(var Message: TWMNCLButtonDown);
  procedure WMNCLButtonUp(var Message: TWMNCLButtonUp);
  procedure WMNCHitTest(var Message: TWMNCHitTest);
  procedure WMSetCursor(var Message: TWMSetCursor);
  procedure WMNCCalcSize(var Message: TWMNCCalcSize);
  procedure WMMouseMove(var Message: TWMMouseMove);
  procedure CMMouseLeave(var Message: TMessage);
 end;//TnscSubTree
 
 TnscOnPastingString = procedure(Sender: TObject;
  var aText: Il3CString) of object;
 
 TnscCustomTreeComboWithHistory = class(TDropDownTree)
  procedure MakeNodesFromItems;
  procedure FilterNewTree;
  procedure ChangeDropTree(ForHistory: Boolean;
   ForceChange: Boolean);
  procedure TreeCurrentChanged(Sender: TObject;
   aNewCurrent: LongInt;
   aOldCurrent: LongInt);
  procedure DoSetContextText(const aText: Il3CString;
   SetToEnd: Boolean);
  function CloseFont: TFont;
  procedure ChangeTimerTick(Sender: TObject);
  procedure SetRoot(const aRoot: Il3SimpleNode);
  function GetFullPath(const aNode: Il3SimpleNode): Il3CString;
  function CurrentIsLink: Boolean;
  function GetNodeText(const aNode: Il3SimpleNode): Il3CString;
  procedure CloseDropDownByHyperlink;
  procedure ResetPropmtTreeUsage;
  procedure DoSelect;
  procedure CNKeyDown(var Message: TWMKeyDown);
  procedure CMFontChanged(var Message: TMessage);
  procedure WMSysKeyDown(var Message: TWMSysKeyDown);
 end;//TnscCustomTreeComboWithHistory
 
implementation

uses
 l3ImplUses
 , nscCustomTreeComboWithHistoryRes
 , SysUtils
 , l3Defaults
 , l3String
 , l3Base
 , evOp
 , nscNewInterfaces
 , l3Drawer
 , l3Units
 , l3MinMax
 , Forms
 , nscConst
 , afwFacade
 , OvcCmd
 , OvcConst
 , ComboBoxStrings
 , nevBase
 , l3SimpleTree
 , l3Nodes
 , evMsgCode
 , l3GetComponentBoundsHelper
 , TtfwClassRef_Proxy
 , Themes
;

end.
