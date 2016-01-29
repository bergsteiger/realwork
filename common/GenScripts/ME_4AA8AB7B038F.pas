unit vtDateEdit;

interface

uses
 l3IntfUses
 , vtPanel
 , Buttons
 , Menus
 , vtCalendarPanel
 , Controls
 , Classes
 , vtCombo
 , l3Date
 , Graphics
 , Messages
 , l3Interfaces
 , vtForm
 , vtStdRes
;

type
 TPopupCalendar = class(TvtPanel)
  procedure CalendarMouseUp(Sender: TObject;
   Button: TMouseButton;
   Shift: TShiftState;
   X: Integer;
   Y: Integer);
  procedure PrevMonthBtnClick(Sender: TObject);
  procedure NextMonthBtnClick(Sender: TObject);
  procedure PrevYearBtnClick(Sender: TObject);
  procedure NextYearBtnClick(Sender: TObject);
  procedure CalendarChange(Sender: TObject);
  procedure TopPanelDblClick(Sender: TObject);
  procedure MonthClick(Sender: TObject);
  procedure MonthMenuSelect(Sender: TObject);
  procedure YearClick(Sender: TObject);
  procedure YearMenuSelect(Sender: TObject);
  procedure CancelClick(Sender: TObject);
  procedure ClickToday(Sender: TObject);
  function CalcTodayPadWidth: Integer;
  procedure MakeTodayPad;
  procedure AdjustTitleButtonFont(aLabel: TSpeedButton);
  procedure DoKeyDown(var Key: Word;
   Shift: TShiftState);
 end;//TPopupCalendar
 
 TvtOnApplyDate = function(aSender: TObject;
  var aValue: TDateTime): Boolean of object;
 
 TvtOnAppliedDate = procedure(aSender: TObject;
  aValue: TDateTime) of object;
 
 TYearDigits = (
  dyDefault
  , dyFour
  , dyTwo
 );//TYearDigits
 
 {$Define SupportStDate}
 
 TvtCustomDateEdit = class(TvtCustomCombo)
  procedure DoExecute;
  function FourDigitYear: Boolean;
  function FormatSettingsChange(var Message: TMessage): Boolean;
  procedure TriggerAutoCorrectDate;
   {* �������� �� ������������� }
  function TriggerOnInvalidDate: Boolean;
   {* ��������� ��� ����������� ��������� ���� ��� ������ �� ���������� }
  procedure MakeCalendar;
  function GetDateFormat: ShortString;
  procedure ApplyDate(aValue: TDateTime);
  procedure UpdateFormat;
  procedure CheckValidDate;
  function GetDateMask: ShortString;
  procedure UpdateMask;
  procedure ClearDate;
  function IsValid: Boolean;
   {* ��������� ���� �� �������� ����������. 
������ ����� "__.__.____" ���� �������������� ��� �������� ����. }
  function IsEmpty: Boolean;
   {* False, ������ ����� ������� ������ ����.
������ ����� "__.__.____" �������������� ��� �������� ����. }
  function IsBlank: Boolean;
   {* ������������ ������ �� ���� � ���� �������������� ("__.__.____") }
  procedure AutoResize;
  function TextStored: Boolean;
  procedure CMExit(var Message: TCMExit);
  procedure CMEnter(var Message: TCMEnter);
  procedure WMMouseWheel(var Message: TMessage);
  procedure WMPaste(var Message: TMessage);
  function GetDropDownContainer: TWinControl;
 end;//TvtCustomDateEdit
 
 TvtCalendarForm = class(TvtForm)
 end;//TvtCalendarForm
 
 TDblClickPopupCalendar = class(TPopupCalendar)
  procedure OkClick(Sender: TObject);
 end;//TDblClickPopupCalendar
 
 {$Define TodayPadPresent}
 
 TFoo = TvtStdResources;
  {* ���������� vtStdRes � ������������ ����� }
 
 TvtDateEdit = class(TvtCustomDateEdit)
 end;//TvtDateEdit
 
implementation

uses
 l3ImplUses
 , l3String
 , vtDateEditRes
 , DateUtils
 , Windows
 , Spin
 , Forms
 , l3MinMax
 , vtLabel
 , ActnList
 , Clipbrd
 , OvcConst
 , MaskUtils
 , TtfwClassRef_Proxy
;

type
 TvtCalendarPanelFriend = class(TvtCalendarPanel)
  {* ���� ��� TvtCalendarPanel }
 end;//TvtCalendarPanelFriend
 
end.
