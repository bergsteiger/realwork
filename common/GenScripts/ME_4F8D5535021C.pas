unit AbsSubTree;

interface

uses
 l3IntfUses
 , vtOutlinerWithQuickSearch
 , afwInterfaces
 , Messages
 , Windows
 , l3TreeInterfaces
 , Controls
;

type
 TAbsSubTree = class(TvtOutlinerWithQuickSearch, IafwDropDownWindow)
  function IsSizeableTree: Boolean;
  function IsShowGripper: Boolean;
  function IsList: Boolean;
  function IsInvert: Boolean;
  function IsOwnerAssigned: Boolean;
  function GetWidth: Integer;
  procedure NCDraw(aDC: hDC);
  function GetMinVisibleDropCount: Integer;
  function GetMaxVisibleDropCount: Integer;
  procedure RecreateTree;
  function GetMinSizeY: Integer;
  function GetMaxSizeY: Integer;
  function GetMinSizeX: Integer;
  function GetBorderSize: Integer;
  function GetTreeY: Integer;
  procedure SetTreeRoot(const aRoot: Il3SimpleNode);
  procedure SetSimpleTree(const aTree: Il3SimpleTree);
  procedure WMNCPaint(var Message: TMessage);
  procedure WMMouseActivate(var Msg: TMessage);
  procedure WMNChitTest(var Msg: TWMNCHitTest);
  procedure WMNCCalcSize(var Message: TWMNCCalcSize);
  procedure WMSize(var Message: TWMSize);
  procedure WMGetMinMaxInfo(var Message: TMessage);
 end;//TAbsSubTree
 
implementation

uses
 l3ImplUses
 , ctTypes
 , SysUtils
 , l3MinMax
 , l3ControlsTypes
 , l3Tree_TLB
 , Types
 , Graphics
 , l3Defaults
 , ElVclUtils
 , TtfwClassRef_Proxy
;

end.
