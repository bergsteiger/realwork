unit vtMultilineHint;

interface

uses
 l3IntfUses
 , Controls
 , l3Interfaces
 , l3WinControlCanvas
 , l3FormattedLines
 , Types
 , Classes
 , Windows
;

type
 TvtMultilineHint = class(THintWindow)
  procedure ActivateHintEx(Rect: TRect;
   const AHint: Il3CString);
  procedure vtActivateHint(aWindow: THintWindow;
   const Rect: TRect;
   const AHint: Il3CString);
 end;//TvtMultilineHint
 
implementation

uses
 l3ImplUses
 , vtHintManager
 , l3InternalInterfaces
 , Forms
 , l3String
 , l3Chars
 , l3ScreenIC
 , l3Base
 , l3CustomControlCanvas
 , Messages
 , TtfwClassRef_Proxy
;

end.
