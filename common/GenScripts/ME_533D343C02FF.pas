unit ChromeLikeFormCaptionData;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Types
 , Windows
;

type
 TChromeLikeFormCaptionButtonKind = (
  cbkMinimize
  , cbkMaximizeRestore
  , cbkClose
 );//TChromeLikeFormCaptionButtonKind
 
 TChromeLikeFormCaptionData = class(Tl3ProtoObject)
  function MakeRelativeRect(const aWndRect: TRect;
   const aButtonRect: TRect): TRect;
  procedure InitTitleBarInfo;
  procedure UpdateTitleBarInfo(aHwnd: hWnd);
  function MakeButtonRect(aRight: Integer;
   aButtonKind: TChromeLikeFormCaptionButtonKind): TRect;
 end;//TChromeLikeFormCaptionData
 
implementation

uses
 l3ImplUses
 , ChromeLikeWinUtils
 , l3Base
 , ChromeLikeTypes
;

end.
