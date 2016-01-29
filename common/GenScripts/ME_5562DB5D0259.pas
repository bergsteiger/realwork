unit vtCalendarPanel;

interface

uses
 l3IntfUses
 , vtPanel
 , l3Date
 , Graphics
 , Classes
 , Messages
 , Types
 , l3InternalInterfaces
;

type
 TvtCustomCalendarPanel = class(TvtCustomPanel)
  function GetDayFromPoint(const Pt: TPoint): Integer;
  function GetDayRect(aDay: Word): TRect;
  procedure DrawFocusFrame(aPredDay: Word);
  procedure InvalidateDayArray;
  procedure Change;
  procedure NextDay;
  procedure PrevDay;
  procedure NextWeek;
  procedure PrevWeek;
  procedure NextMonth;
  procedure PrevMonth;
  procedure NextYear;
  procedure PrevYear;
  procedure RelMoveDate(nDays: Integer);
  procedure WMGetDlgCode(var Msg: TWMGetDlgCode);
  procedure WMLButtonDown(var Message: TWMLButtonDown);
  procedure WMLButtonUp(var Message: TWMLButtonUp);
  procedure WMMouseMove(var Message: TWMMouseMove);
  procedure WMShowWindow(var Message: TWMShowWindow);
 end;//TvtCustomCalendarPanel
 
 TvtCalendarPanel = class(TvtCustomCalendarPanel)
 end;//TvtCalendarPanel
 
implementation

uses
 l3ImplUses
 , vtDateEditRes
 , l3Units
 , l3String
 , Controls
 , Windows
 , TtfwClassRef_Proxy
;

end.
