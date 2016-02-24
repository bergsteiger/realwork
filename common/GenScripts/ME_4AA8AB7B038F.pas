unit vtDateEdit;

// Модуль: "w:\common\components\gui\Garant\VT\vtDateEdit.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , Buttons
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vtCalendarPanel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
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
  private
   f_TitlePanel: TvtPanel;
   f_MonthLabel: TSpeedButton;
   f_YearLabel: TSpeedButton;
   f_MonthMenu: TPopupMenu;
   f_YearMenu: TPopupMenu;
   f_FourDigitYear: Boolean;
   f_MenuOpen: Boolean;
    {* Поле для свойства MenuOpen }
  protected
   f_Calendar: TvtCalendarPanel;
  private
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
  protected
   function pm_GetDate: TDateTime;
   procedure pm_SetDate(aValue: TDateTime);
   procedure CalendarMouseUp(Sender: TObject;
    Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); virtual;
   procedure CancelClick(Sender: TObject); virtual;
   procedure ClickToday(Sender: TObject); virtual;
   function CalcTodayPadWidth: Integer; virtual;
   procedure MakeTodayPad; virtual;
   procedure AdjustTitleButtonFont(aLabel: TSpeedButton); virtual;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure KeyDown(var Key: Word;
    Shift: TShiftState); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure DoKeyDown(var Key: Word;
    Shift: TShiftState);
   constructor Create(AOwner: TComponent); override;
  protected
   property MenuOpen: Boolean
    read f_MenuOpen
    write f_MenuOpen;
  public
   property Date: TDateTime
    read pm_GetDate
    write pm_SetDate;
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
  private
   f_Hooked: Boolean;
   f_DateFormat: ShortString;
   f_OnApplyDate: TvtOnApplyDate;
    {* Поле для свойства OnApplyDate }
   f_OnAppliedDate: TvtOnAppliedDate;
    {* Поле для свойства OnAppliedDate }
   f_OnAutoCorrectDate: TNotifyEvent;
    {* Поле для свойства OnAutoCorrectDate }
   f_OnExecute: TNotifyEvent;
    {* Поле для свойства OnExecute }
   f_OnInvalidDate: TNotifyEvent;
    {* Поле для свойства OnInvalidDate }
   f_RestrictInvalidDate: Boolean;
    {* Поле для свойства RestrictInvalidDate }
   f_BlanksChar: AnsiChar;
    {* Поле для свойства BlanksChar }
   f_StartOfWeek: TStDayType;
    {* Поле для свойства StartOfWeek }
   f_Weekends: TDaysOfWeek;
    {* Поле для свойства Weekends }
   f_WeekendColor: TColor;
    {* Поле для свойства WeekendColor }
   f_YearDigits: TYearDigits;
    {* Поле для свойства YearDigits }
   f_CheckOnExit: Boolean;
    {* Поле для свойства CheckOnExit }
   f_Formatting: Boolean;
    {* Поле для свойства Formatting }
  protected
   f_CalendarPanel: TWinControl;
  private
   function FourDigitYear: Boolean;
   function FormatSettingsChange(var Message: TMessage): Boolean;
   procedure CMExit(var Message: TCMExit); message CM_EXIT;
   procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
   procedure WMMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
   procedure WMPaste(var Message: TMessage); message WM_PASTE;
  protected
   procedure pm_SetBlanksChar(aValue: AnsiChar);
   procedure pm_SetYearDigits(aValue: TYearDigits);
   function pm_GetDate: TDateTime;
   procedure pm_SetDate(aValue: TDateTime);
   {$If Defined(SupportStDate)}
   function pm_GetStDate: TStDate; virtual;
   {$IfEnd} // Defined(SupportStDate)
   {$If Defined(SupportStDate)}
   procedure pm_SetStDate(const aValue: TStDate); virtual;
   {$IfEnd} // Defined(SupportStDate)
   procedure DoExecute; virtual;
   procedure TriggerAutoCorrectDate; virtual;
    {* сообщает об автокоррекции }
   function TriggerOnInvalidDate: Boolean; virtual;
    {* возникает при неправильно введенной дате при выходе из компонента }
   procedure MakeCalendar; virtual;
   function GetDateFormat: ShortString;
   procedure ApplyDate(aValue: TDateTime); virtual;
   procedure UpdateFormat;
   function TextStored: Boolean;
   function GetDropDownContainer: TWinControl; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure KeyPress(var Key: Char); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateWindowHandle(const Params: TCreateParams); override;
    {* Creates a Windows control to represent the control }
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DestroyWindowHandle; override;
    {* Destroys the window created in the CreateWindowHandle method }
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure ActionChange(Sender: TObject;
    CheckDefaults: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function ProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; override;
   {$If NOT Defined(NoVCL)}
   procedure Change; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure KeyDown(var Key: Word;
    Shift: TShiftState); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If Defined(l3HackedVCL) AND NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary)}
   function TextFromClipboard: AnsiString; override;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary)
  public
   procedure CheckValidDate;
   function GetDateMask: ShortString;
   procedure UpdateMask; virtual;
   procedure ClearDate;
   function IsValid: Boolean;
    {* введенная дата не является допустимой. 
Пустой бланк "__.__.____" тоже воспринимается как неверная дата. }
   function IsEmpty: Boolean;
    {* False, только когда введена верная дата.
Пустой бланк "__.__.____" воспринимается как неверная дата. }
   function IsBlank: Boolean;
    {* пользователь ничего не ввел в поле редактирования ("__.__.____") }
   procedure AutoResize;
   constructor Create(AOwner: TComponent); override;
   procedure DropDown; override;
   procedure CloseUp(Accept: Boolean); override;
  public
   property OnApplyDate: TvtOnApplyDate
    read f_OnApplyDate
    write f_OnApplyDate;
   property OnAppliedDate: TvtOnAppliedDate
    read f_OnAppliedDate
    write f_OnAppliedDate;
   property OnAutoCorrectDate: TNotifyEvent
    read f_OnAutoCorrectDate
    write f_OnAutoCorrectDate;
   property OnExecute: TNotifyEvent
    read f_OnExecute
    write f_OnExecute;
   property OnInvalidDate: TNotifyEvent
    read f_OnInvalidDate
    write f_OnInvalidDate;
   property RestrictInvalidDate: Boolean
    read f_RestrictInvalidDate
    write f_RestrictInvalidDate;
   property BlanksChar: AnsiChar
    read f_BlanksChar
    write pm_SetBlanksChar;
   property StartOfWeek: TStDayType
    read f_StartOfWeek
    write f_StartOfWeek;
   property Weekends: TDaysOfWeek
    read f_Weekends
    write f_Weekends;
   property WeekendColor: TColor
    read f_WeekendColor
    write f_WeekendColor;
   property YearDigits: TYearDigits
    read f_YearDigits
    write pm_SetYearDigits;
   property CheckOnExit: Boolean
    read f_CheckOnExit
    write f_CheckOnExit;
   property Formatting: Boolean
    read f_Formatting;
   property Date: TDateTime
    read pm_GetDate
    write pm_SetDate;
   {$If Defined(SupportStDate)}
   property StDate: TStDate
    read pm_GetStDate
    write pm_SetStDate;
   {$IfEnd} // Defined(SupportStDate)
 end;//TvtCustomDateEdit

 TvtCalendarForm = class(TvtForm)
  private
   f_Calendar: TWinControl;
   f_DateFormat: ShortString;
   f_DateText: AnsiString;
    {* Поле для свойства DateText }
  protected
   procedure pm_SetDateText(const aValue: AnsiString);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure InitFields; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If Defined(DesignTimeLibrary)}
   procedure AfterConstruction; override;
    {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
   {$IfEnd} // Defined(DesignTimeLibrary)
  public
   property DateText: AnsiString
    read f_DateText
    write pm_SetDateText;
 end;//TvtCalendarForm

 TDblClickPopupCalendar = class(TPopupCalendar)
  protected
   procedure OkClick(Sender: TObject); virtual;
   procedure CalendarMouseUp(Sender: TObject;
    Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   function CalcTodayPadWidth: Integer; override;
   procedure MakeTodayPad; override;
   procedure AdjustTitleButtonFont(aLabel: TSpeedButton); override;
 end;//TDblClickPopupCalendar

 {$Define TodayPadPresent}

 TFoo = TvtStdResources;
  {* Подключаем vtStdRes в интерфейсную часть }

 //#UC START# *4AA8AB7B038Fci*
 //#UC END# *4AA8AB7B038Fci*
 //#UC START# *4AA8AB7B038Fcit*
 //#UC END# *4AA8AB7B038Fcit*
 TvtDateEdit = {final} class(TvtCustomDateEdit)
 //#UC START# *4AA8AB7B038Fpubl*
  public
   property  StartOfWeek default Monday;
   property  Weekends default [Sunday];
   property  WeekendColor default clRed;
   property  YearDigits default dyDefault;
  published

   {$ifdef Delphi4}
   property Text stored TextStored;
   property Anchors;
   property BiDiMode;
   property Constraints;
   property ParentBiDiMode;
   {$endif}

   property AlignmentVertical;
   property AllowClearKey;
   property AutoSelect;
   property AutoSize;
   property ShowButton;
   property BorderStyle;
   property ButtonStyle default cbsDefault;
   property CharCase;
   property CheckOnExit;
   property Color;
   property Ctl3D;
   property DragMode;
   property DragCursor;
   property EditMask stored False;
   property Enabled;
   property Font;
   {$ifdef Delphi3}
   property ImeMode;
   property ImeName;
   {$endif}
   property Images;
   property ImageIndex default vt_imgCalendar;
   property MaxLength stored False;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ReadOnly;
   property RestrictInvalidDate default False;
   property ShowHint;
   property Style default csDropDownList;
   property TabOrder;
   property TabStop;
   property Visible;

   property OnApplyDate;
   property OnAppliedDate;
   property OnAutoCorrectDate;
   property OnChange;
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnDropDown;
   property OnCloseUp;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnStartDrag;
   property OnExecute;
   property OnInvalidDate;
 //#UC END# *4AA8AB7B038Fpubl*
 end;//TvtDateEdit

implementation

uses
 l3ImplUses
 , l3String
 , vtDateEditRes
 , DateUtils
 , Windows
 , Spin
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MinMax
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Clipbrd
 {$IfEnd} // NOT Defined(NoVCL)
 , OvcConst
 , MaskUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TvtCalendarPanelFriend = {abstract} class(TvtCalendarPanel)
  {* Друг для TvtCalendarPanel }
 end;//TvtCalendarPanelFriend

const
 cButtonWidth = 95;
 cButtonHeight = 20;

function TPopupCalendar.pm_GetDate: TDateTime;
//#UC START# *5562DAFA03CB_4F8D5553010Aget_var*
//#UC END# *5562DAFA03CB_4F8D5553010Aget_var*
begin
//#UC START# *5562DAFA03CB_4F8D5553010Aget_impl*
 if f_Calendar <> nil
  then Result := f_Calendar.Date
  else Result := NullDate;
//#UC END# *5562DAFA03CB_4F8D5553010Aget_impl*
end;//TPopupCalendar.pm_GetDate

procedure TPopupCalendar.pm_SetDate(aValue: TDateTime);
//#UC START# *5562DAFA03CB_4F8D5553010Aset_var*
//#UC END# *5562DAFA03CB_4F8D5553010Aset_var*
begin
//#UC START# *5562DAFA03CB_4F8D5553010Aset_impl*
 if (f_Calendar <> nil) then
 try
  f_Calendar.Date := aValue;
 except
  f_Calendar.Date := Now;
 end;
//#UC END# *5562DAFA03CB_4F8D5553010Aset_impl*
end;//TPopupCalendar.pm_SetDate

procedure TPopupCalendar.CalendarMouseUp(Sender: TObject;
 Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *5562DBEF006B_4F8D5553010A_var*
//#UC END# *5562DBEF006B_4F8D5553010A_var*
begin
//#UC START# *5562DBEF006B_4F8D5553010A_impl*
 f_MenuOpen := False;
 if (Button = mbLeft) and (Shift = []) then
  begin
   if TvtCalendarPanelFriend(f_Calendar).GetDayFromPoint(Point(X,Y)) > 0 then
    if Owner is TWinControl then
     PostMessage(TWinControl(Owner).Handle, WM_vt_CALLCLOSEUP, 1, 0)
  end;
//#UC END# *5562DBEF006B_4F8D5553010A_impl*
end;//TPopupCalendar.CalendarMouseUp

procedure TPopupCalendar.PrevMonthBtnClick(Sender: TObject);
//#UC START# *5562DC2B00A8_4F8D5553010A_var*
//#UC END# *5562DC2B00A8_4F8D5553010A_var*
begin
//#UC START# *5562DC2B00A8_4F8D5553010A_impl*
 f_Calendar.PrevMonth;
//#UC END# *5562DC2B00A8_4F8D5553010A_impl*
end;//TPopupCalendar.PrevMonthBtnClick

procedure TPopupCalendar.NextMonthBtnClick(Sender: TObject);
//#UC START# *5562DC4401F9_4F8D5553010A_var*
//#UC END# *5562DC4401F9_4F8D5553010A_var*
begin
//#UC START# *5562DC4401F9_4F8D5553010A_impl*
 f_Calendar.NextMonth;
//#UC END# *5562DC4401F9_4F8D5553010A_impl*
end;//TPopupCalendar.NextMonthBtnClick

procedure TPopupCalendar.PrevYearBtnClick(Sender: TObject);
//#UC START# *5562DC4E02D2_4F8D5553010A_var*
//#UC END# *5562DC4E02D2_4F8D5553010A_var*
begin
//#UC START# *5562DC4E02D2_4F8D5553010A_impl*
 f_Calendar.PrevYear;
//#UC END# *5562DC4E02D2_4F8D5553010A_impl*
end;//TPopupCalendar.PrevYearBtnClick

procedure TPopupCalendar.NextYearBtnClick(Sender: TObject);
//#UC START# *5562DC56029A_4F8D5553010A_var*
//#UC END# *5562DC56029A_4F8D5553010A_var*
begin
//#UC START# *5562DC56029A_4F8D5553010A_impl*
 f_Calendar.NextYear;
//#UC END# *5562DC56029A_4F8D5553010A_impl*
end;//TPopupCalendar.NextYearBtnClick

procedure TPopupCalendar.CalendarChange(Sender: TObject);
//#UC START# *5562DC5D03D9_4F8D5553010A_var*
var
 Year, Month, Day: Word;
//#UC END# *5562DC5D03D9_4F8D5553010A_var*
begin
//#UC START# *5562DC5D03D9_4F8D5553010A_impl*
 DecodeDate(f_Calendar.Date, Year, Month, Day);
 f_MonthLabel.Caption := vtMonthsCaptions(Month).AsStr;
 f_YearLabel.Caption := FormatDateTime('YYYY', f_Calendar.Date);
//#UC END# *5562DC5D03D9_4F8D5553010A_impl*
end;//TPopupCalendar.CalendarChange

procedure TPopupCalendar.TopPanelDblClick(Sender: TObject);
//#UC START# *5562DC65011C_4F8D5553010A_var*
//#UC END# *5562DC65011C_4F8D5553010A_var*
begin
//#UC START# *5562DC65011C_4F8D5553010A_impl*
 f_Calendar.Date := Trunc(Now);
//#UC END# *5562DC65011C_4F8D5553010A_impl*
end;//TPopupCalendar.TopPanelDblClick

procedure TPopupCalendar.MonthClick(Sender: TObject);
//#UC START# *5562DC710040_4F8D5553010A_var*
var
 lPos: TPoint;
//#UC END# *5562DC710040_4F8D5553010A_var*
begin
//#UC START# *5562DC710040_4F8D5553010A_impl*
 lPos.X := f_MonthLabel.Left;
 lPos.Y := f_MonthLabel.Top + f_MonthLabel.Height;
 lPos := f_TitlePanel.ClientToScreen(lPos);
 f_MonthMenu.Items[MonthOf(pm_GetDate)-1].Checked := True;
 f_MenuOpen := True;
 f_MonthMenu.Popup(lPos.X, lPos.Y);
 f_MenuOpen := False;
//#UC END# *5562DC710040_4F8D5553010A_impl*
end;//TPopupCalendar.MonthClick

procedure TPopupCalendar.MonthMenuSelect(Sender: TObject);
//#UC START# *5562DC9B004D_4F8D5553010A_var*
var
 lMonth: Integer;
 Y, M, D: Word;
 TmpDate: TDateTime;
//#UC END# *5562DC9B004D_4F8D5553010A_var*
begin
//#UC START# *5562DC9B004D_4F8D5553010A_impl*
 lMonth := f_MonthMenu.Items.IndexOf(TMenuItem(Sender)) + 1;
 DecodeDate(pm_GetDate, Y, M, D);
 if not IsValidDate(Y, lMonth, D)
  then TmpDate := EndOfTheMonth(EncodeDate(Y, lMonth, 1))
  else TmpDate := EncodeDate(Y, lMonth, D);
 pm_SetDate(TmpDate);
 f_MenuOpen := False;
//#UC END# *5562DC9B004D_4F8D5553010A_impl*
end;//TPopupCalendar.MonthMenuSelect

procedure TPopupCalendar.YearClick(Sender: TObject);
//#UC START# *5562DCA501FA_4F8D5553010A_var*
var
 lPos: TPoint;
 I, B, E, Y: Integer;
 MI: TMenuItem;
//#UC END# *5562DCA501FA_4F8D5553010A_var*
begin
//#UC START# *5562DCA501FA_4F8D5553010A_impl*
 f_YearMenu.Items.Clear;
 Y := YearOf(pm_GetDate);
 B := Y - 8;
 E := B + 16;
 f_YearMenu.Items.AutoHotkeys := maManual;
 for I:= B to E do
 begin
  MI := TMenuItem.Create(Self);
  MI.AutoHotkeys := maManual;
  MI.Caption := IntToStr(I);
  MI.OnClick := YearMenuSelect;
  if I = Y then // пометим текущий год
  begin
   MI.RadioItem := True;
   MI.Checked := True;
  end;
  f_YearMenu.Items.Add(MI);
 end;
 lPos.X := f_YearLabel.Left;
 lPos.Y := f_YearLabel.Top;// - GetSystemMetrics(SM_CYMENU)*7;
 lPos := f_TitlePanel.ClientToScreen(lPos);
 if ((lPos.Y + GetSystemMetrics(SM_CYMENU) * 9) < Screen.Height) and
    ((lPos.Y - GetSystemMetrics(SM_CYMENU) * 9) > 0) then
  lPos.Y := lPos.Y - GetSystemMetrics(SM_CYMENU) * 8;
 f_MenuOpen := True;
 f_YearMenu.Popup(lPos.X, lPos.Y);
 f_MenuOpen := False;
//#UC END# *5562DCA501FA_4F8D5553010A_impl*
end;//TPopupCalendar.YearClick

procedure TPopupCalendar.YearMenuSelect(Sender: TObject);
//#UC START# *5562DCAD03A9_4F8D5553010A_var*
var
 lIndex: Integer;
 YearS: AnsiString;
//#UC END# *5562DCAD03A9_4F8D5553010A_var*
begin
//#UC START# *5562DCAD03A9_4F8D5553010A_impl*
 lIndex := f_YearMenu.Items.IndexOf(TMenuItem(Sender));
 YearS := f_YearMenu.Items[lIndex].Caption;
 try
  pm_SetDate(RecodeYear(pm_GetDate, StrToInt(YearS)));
 except
  // http://mdp.garant.ru/pages/viewpage.action?pageId=330697003
  on EConvertError do
  begin
   pm_SetDate(RecodeYear(pm_GetDate - 1, StrToInt(YearS)));
  end;
  on Exception do
   raise;
 end;
 f_MenuOpen := False;
//#UC END# *5562DCAD03A9_4F8D5553010A_impl*
end;//TPopupCalendar.YearMenuSelect

procedure TPopupCalendar.CancelClick(Sender: TObject);
//#UC START# *5562DCBF022F_4F8D5553010A_var*
//#UC END# *5562DCBF022F_4F8D5553010A_var*
begin
//#UC START# *5562DCBF022F_4F8D5553010A_impl*
 PostMessage(TWinControl(Owner).Handle, WM_vt_CALLCLOSEUP, 0, 0);
//#UC END# *5562DCBF022F_4F8D5553010A_impl*
end;//TPopupCalendar.CancelClick

procedure TPopupCalendar.ClickToday(Sender: TObject);
//#UC START# *5562DCCD00E0_4F8D5553010A_var*
//#UC END# *5562DCCD00E0_4F8D5553010A_var*
begin
//#UC START# *5562DCCD00E0_4F8D5553010A_impl*
 f_Calendar.Date := Trunc(Now);
 PostMessage(TWinControl(Owner).Handle, WM_vt_CALLCLOSEUP, 1, 0);
//#UC END# *5562DCCD00E0_4F8D5553010A_impl*
end;//TPopupCalendar.ClickToday

function TPopupCalendar.CalcTodayPadWidth: Integer;
//#UC START# *5562DDAF0285_4F8D5553010A_var*
//#UC END# *5562DDAF0285_4F8D5553010A_var*
begin
//#UC START# *5562DDAF0285_4F8D5553010A_impl*
 Result := 0;
//#UC END# *5562DDAF0285_4F8D5553010A_impl*
end;//TPopupCalendar.CalcTodayPadWidth

procedure TPopupCalendar.MakeTodayPad;
//#UC START# *5562DE3A02DF_4F8D5553010A_var*
var
 lPanel: TvtPanel;
//#UC END# *5562DE3A02DF_4F8D5553010A_var*
begin
//#UC START# *5562DE3A02DF_4F8D5553010A_impl*
 lPanel := TvtPanel.Create(Self);
 with lPanel do
 begin
  Parent := Self;
  Height := 25;
  BevelOuter := bvNone;
  Align := alBottom;
 end;

 with TvtLabel.Create(Self) do
 begin
  Parent := lPanel;
  Left := 3;
  Top := 5;
  Font.Style := [fsBold];
  CCaption := l3Fmt(str_vtTodayLongLabel.AsCStr, [FormatDateTime('DD.MM.YYYY', Now)]);
  OnClick := ClickToday;
  ShowHint := True;
  Hint := str_vtTodayHint.AsStr;
 end;

 with TSpeedButton.Create(Self) do
 begin
  Parent := lPanel;
  SetBounds(lPanel.Width-3-19, 3, 19,19);
  Anchors := [akRight, akTop];
  vtStdResources.Images.GetBitmap(17, Glyph);
  Flat := True;
  OnClick := CancelClick;
  ShowHint := True;
  Hint := str_vtCancel.AsStr;
 end;
//#UC END# *5562DE3A02DF_4F8D5553010A_impl*
end;//TPopupCalendar.MakeTodayPad

procedure TPopupCalendar.AdjustTitleButtonFont(aLabel: TSpeedButton);
//#UC START# *5562DE4D0243_4F8D5553010A_var*
//#UC END# *5562DE4D0243_4F8D5553010A_var*
begin
//#UC START# *5562DE4D0243_4F8D5553010A_impl*
// Do nothing;
//#UC END# *5562DE4D0243_4F8D5553010A_impl*
end;//TPopupCalendar.AdjustTitleButtonFont

procedure TPopupCalendar.DoKeyDown(var Key: Word;
 Shift: TShiftState);
//#UC START# *556486A5039E_4F8D5553010A_var*
//#UC END# *556486A5039E_4F8D5553010A_var*
begin
//#UC START# *556486A5039E_4F8D5553010A_impl*
 KeyDown(Key, Shift);
//#UC END# *556486A5039E_4F8D5553010A_impl*
end;//TPopupCalendar.DoKeyDown

constructor TPopupCalendar.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4F8D5553010A_var*
const
  BtnSide = 21;
  cBevelWidth = 2;
var
 I: Integer;
 MItem: TMenuItem;
//#UC END# *47D1602000C6_4F8D5553010A_var*
begin
//#UC START# *47D1602000C6_4F8D5553010A_impl*
 inherited Create(AOwner);
 f_FourDigitYear := FourDigitYear;
 I := Screen.PixelsPerInch;
 {$IFDEF TodayPadPresent}
 Height := Round(1.875*I);
 {$ELSE}
 Height := Round(1.6145833333333333333333333333333*I);
 {$ENDIF}
 {$IFDEF TodayPadPresent}
 Width := Max(Round(2.0104166666666666666666666666667*I), CalcTodayPadWidth + 2*cBevelWidth);
 {$ELSE}
 Width := Round(2.0104166666666666666666666666667*I);
 {$ENDIF}
 Color := clBtnFace;
 FontSetDefault(Font);
 Font.Charset := RUSSIAN_CHARSET; // чтоб на NT-ях правильно все рисовалось
 ShowHint := True;

 ControlStyle := ControlStyle + [csReplicatable];

 BevelInner := bvNone;
 BevelOuter := bvRaised;
 BevelWidth := cBevelWidth;

 f_TitlePanel := TvtPanel.Create(Self);
 with f_TitlePanel do
 begin
  Parent := Self;
  Align := alTop;
  Width := Self.Width - 4;
  Height := 23;
  BevelOuter := bvNone;
  ParentColor := True;
  OnDblClick := TopPanelDblClick;
  ControlStyle := ControlStyle + [csReplicatable];
 end;

 {$IFDEF TodayPadPresent}
 MakeTodayPad;
 {$ENDIF}

 f_MonthMenu := TPopupMenu.Create(Self);
 with f_MonthMenu do
 begin
  Font.Charset := RUSSIAN_CHARSET;
  for I := 1 to 12 do
  begin
   MItem := TMenuItem.Create(Self);
   MItem.Caption := vtMonthsCaptions(I).AsStr;
   MItem.OnClick := MonthMenuSelect;
   MItem.RadioItem := True;
   Items.Add(MItem);
  end;
 end;

 f_YearMenu := TPopupMenu.Create(Self);

 f_MonthLabel := TSpeedButton.Create(Self);
 AdjustTitleButtonFont(f_MonthLabel);
 f_TitlePanel.InsertControl(f_MonthLabel);
 with f_MonthLabel do
 begin
  Left := 40;
  Top := 2;
  Width := Round((f_TitlePanel.Width - BtnSide * 4)/3*2) ;
  Height := 20;
  Flat := True;
  Alignment := taRightJustify;
  Anchors := [akLeft,akRight,akTop];
  Caption := vtMonthsCaptions(9).AsStr;
  OnClick := MonthClick;
  Font.Charset := RUSSIAN_CHARSET;
 end;

 f_YearLabel := TSpeedButton.Create(Self);
 AdjustTitleButtonFont(f_YearLabel);
 with f_YearLabel do
 begin
  Parent := f_TitlePanel;
  Left := f_MonthLabel.Left + f_MonthLabel.Width;
  Top := 2;
  Alignment := taLeftJustify;
  Anchors := [akLeft,akRight,akTop];
  Height := 20;
  Width := f_TitlePanel.Width - Left - BtnSide * 2;
  Flat := True;
  OnClick := YearClick;
  Font.Charset := RUSSIAN_CHARSET;
 end;

 f_Calendar := TvtCalendarPanel.Create(Self);
 with f_Calendar do
 begin
  Parent := Self;
  Align := alClient;
  BevelInner := bvLowered;
  BevelOuter := bvNone;
  BorderStyle := bsNone;
  OnChange := CalendarChange;
  OnMouseUp := CalendarMouseUp;
 end;

 with TTimerSpeedButton.Create(Self) do
 begin
  Parent := f_TitlePanel;
  SetBounds(1, 1, BtnSide, BtnSide);
  Glyph.Handle := LoadBitmapA(hInstance, SBtnGlyphs[0]);
  OnClick := PrevYearBtnClick;
  Hint := str_vtStrPrevYear.AsStr;
  Flat:=True;
  TimeBtnState := [tbAllowTimer];
 end;

 with TTimerSpeedButton.Create(Self) do
 begin
  Parent := f_TitlePanel;
  SetBounds(BtnSide + 1, 1, BtnSide, BtnSide);
  Glyph.Handle := LoadBitmapA(hInstance, SBtnGlyphs[1]);
  OnClick := PrevMonthBtnClick;
  Hint := str_vtStrPrevMonth.AsStr;
  Flat := True;
  TimeBtnState := [tbAllowTimer];
 end;

 with TTimerSpeedButton.Create(Self) do
 begin
  Parent := f_TitlePanel;
  SetBounds(f_TitlePanel.Width - 2 * BtnSide - 2 , 1, BtnSide, BtnSide);
  Glyph.Handle := LoadBitmapA(hInstance, SBtnGlyphs[2]);
  OnClick := NextMonthBtnClick;
  Hint := str_vtStrNextMonth.AsStr;
  Flat := True;
  TimeBtnState := [tbAllowTimer];
 end;

 with TTimerSpeedButton.Create(Self) do
 begin
  Parent := f_TitlePanel;
  SetBounds(f_TitlePanel.Width - BtnSide - 2, 1, BtnSide, BtnSide);
  Glyph.Handle := LoadBitmapA(hInstance, SBtnGlyphs[3]);
  OnClick := NextYearBtnClick;
  Hint := str_vtStrNextYear.AsStr;
  Flat := True;
  TimeBtnState := [tbAllowTimer];
 end;
 CalendarChange(Self);

{$IfDef Delphi7}
 ParentBackground := False;
{$EndIf}
//#UC END# *47D1602000C6_4F8D5553010A_impl*
end;//TPopupCalendar.Create

{$If NOT Defined(NoVCL)}
procedure TPopupCalendar.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4F8D5553010A_var*
//#UC END# *48C7925A02E5_4F8D5553010A_var*
begin
//#UC START# *48C7925A02E5_4F8D5553010A_impl*
 inherited CreateParams(Params);
 with Params do
 begin
  ExStyle := WS_EX_TOOLWINDOW;
  WindowClass.Style := CS_SAVEBITS;
  ControlStyle := ControlStyle + [csNoDesignVisible];
 end;
//#UC END# *48C7925A02E5_4F8D5553010A_impl*
end;//TPopupCalendar.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TPopupCalendar.KeyDown(var Key: Word;
 Shift: TShiftState);
//#UC START# *554CABC100AC_4F8D5553010A_var*
//#UC END# *554CABC100AC_4F8D5553010A_var*
begin
//#UC START# *554CABC100AC_4F8D5553010A_impl*
 inherited KeyDown(Key, Shift);
 if (f_Calendar <> nil) then
  TvtCalendarPanelFriend(f_Calendar).KeyDown(Key, Shift);
//#UC END# *554CABC100AC_4F8D5553010A_impl*
end;//TPopupCalendar.KeyDown
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtCustomDateEdit.pm_SetBlanksChar(aValue: AnsiChar);
//#UC START# *554C8C8802BD_52A9ACFF0183set_var*
//#UC END# *554C8C8802BD_52A9ACFF0183set_var*
begin
//#UC START# *554C8C8802BD_52A9ACFF0183set_impl*
 if aValue <> f_BlanksChar then
 begin
  if (aValue < ' ') then
   aValue := ' ';
  f_BlanksChar := aValue;
  UpdateMask;
 end;
//#UC END# *554C8C8802BD_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetBlanksChar

procedure TvtCustomDateEdit.pm_SetYearDigits(aValue: TYearDigits);
//#UC START# *554C8F5C038E_52A9ACFF0183set_var*
//#UC END# *554C8F5C038E_52A9ACFF0183set_var*
begin
//#UC START# *554C8F5C038E_52A9ACFF0183set_impl*
 if f_YearDigits <> aValue then
 begin
  f_YearDigits := aValue;
  UpdateMask;
 end;
//#UC END# *554C8F5C038E_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetYearDigits

function TvtCustomDateEdit.pm_GetDate: TDateTime;
//#UC START# *554C92180230_52A9ACFF0183get_var*
//#UC END# *554C92180230_52A9ACFF0183get_var*
begin
//#UC START# *554C92180230_52A9ACFF0183get_impl*
 Result := StrToDateFmtDef(f_DateFormat, Text, NullDate);
//#UC END# *554C92180230_52A9ACFF0183get_impl*
end;//TvtCustomDateEdit.pm_GetDate

procedure TvtCustomDateEdit.pm_SetDate(aValue: TDateTime);
//#UC START# *554C92180230_52A9ACFF0183set_var*
//#UC END# *554C92180230_52A9ACFF0183set_var*
begin
//#UC START# *554C92180230_52A9ACFF0183set_impl*
 if not ValidDate(aValue) then
  aValue := NullDate;
 if aValue = NullDate
  then Text := ''
  else Text := FormatDateTime(f_DateFormat, aValue);
 if IsDroppedDown then
  TPopupCalendar(f_CalendarPanel).Date := aValue;
//#UC END# *554C92180230_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetDate

{$If Defined(SupportStDate)}
function TvtCustomDateEdit.pm_GetStDate: TStDate;
//#UC START# *554C924B03A3_52A9ACFF0183get_var*
//#UC END# *554C924B03A3_52A9ACFF0183get_var*
begin
//#UC START# *554C924B03A3_52A9ACFF0183get_impl*
 Result := DateTimeToStDate(Date);
//#UC END# *554C924B03A3_52A9ACFF0183get_impl*
end;//TvtCustomDateEdit.pm_GetStDate
{$IfEnd} // Defined(SupportStDate)

{$If Defined(SupportStDate)}
procedure TvtCustomDateEdit.pm_SetStDate(const aValue: TStDate);
//#UC START# *554C924B03A3_52A9ACFF0183set_var*
//#UC END# *554C924B03A3_52A9ACFF0183set_var*
begin
//#UC START# *554C924B03A3_52A9ACFF0183set_impl*
 if aValue = 0
  then Date := NullDate
  else Date := StDateToDateTime(aValue);
//#UC END# *554C924B03A3_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetStDate
{$IfEnd} // Defined(SupportStDate)

procedure TvtCustomDateEdit.DoExecute;
//#UC START# *52A9AF0F021B_52A9ACFF0183_var*
//#UC END# *52A9AF0F021B_52A9ACFF0183_var*
begin
//#UC START# *52A9AF0F021B_52A9ACFF0183_impl*
 if Assigned(f_OnExecute) then
  f_OnExecute(Self)
//#UC END# *52A9AF0F021B_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.DoExecute

function TvtCustomDateEdit.FourDigitYear: Boolean;
//#UC START# *554C9CE10330_52A9ACFF0183_var*
//#UC END# *554C9CE10330_52A9ACFF0183_var*
begin
//#UC START# *554C9CE10330_52A9ACFF0183_impl*
 Result := (f_YearDigits = dyFour) or ((f_YearDigits = dyDefault) and l3Date.FourDigitYear);
//#UC END# *554C9CE10330_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.FourDigitYear

function TvtCustomDateEdit.FormatSettingsChange(var Message: TMessage): Boolean;
//#UC START# *554C9D670390_52A9ACFF0183_var*
//#UC END# *554C9D670390_52A9ACFF0183_var*
begin
//#UC START# *554C9D670390_52A9ACFF0183_impl*
 Result := False;
 if (Message.Msg = WM_WININICHANGE) {$IFDEF WIN32}and Application.UpdateFormatSettings{$ENDIF} then
  UpdateMask;
//#UC END# *554C9D670390_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.FormatSettingsChange

procedure TvtCustomDateEdit.TriggerAutoCorrectDate;
 {* сообщает об автокоррекции }
//#UC START# *554CA29100ED_52A9ACFF0183_var*
//#UC END# *554CA29100ED_52A9ACFF0183_var*
begin
//#UC START# *554CA29100ED_52A9ACFF0183_impl*
 // Общий обработчик
 if Assigned(g_vtBeforeCorrectDate) then
  g_vtBeforeCorrectDate(Text)
 else
 // Обработчик данного экземпляра
 if Assigned(f_OnAutoCorrectDate) then
  f_OnAutoCorrectDate(Self);
//#UC END# *554CA29100ED_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TriggerAutoCorrectDate

function TvtCustomDateEdit.TriggerOnInvalidDate: Boolean;
 {* возникает при неправильно введенной дате при выходе из компонента }
//#UC START# *554CA2C1020B_52A9ACFF0183_var*
//#UC END# *554CA2C1020B_52A9ACFF0183_var*
begin
//#UC START# *554CA2C1020B_52A9ACFF0183_impl*
 if not IsBlank and not IsValid and Assigned(f_OnInvalidDate) then
 begin
  f_OnInvalidDate(Self);
  Result := True;
 end
 else
  Result := False;
//#UC END# *554CA2C1020B_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TriggerOnInvalidDate

procedure TvtCustomDateEdit.MakeCalendar;
//#UC START# *554CA3BF011D_52A9ACFF0183_var*
//#UC END# *554CA3BF011D_52A9ACFF0183_var*
begin
//#UC START# *554CA3BF011D_52A9ACFF0183_impl*
 if f_CalendarPanel <> nil then
  Exit;
 f_CalendarPanel := TPopupCalendar.Create(Self);
//#UC END# *554CA3BF011D_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.MakeCalendar

function TvtCustomDateEdit.GetDateFormat: ShortString;
//#UC START# *554CA3ED007F_52A9ACFF0183_var*
//#UC END# *554CA3ED007F_52A9ACFF0183_var*
begin
//#UC START# *554CA3ED007F_52A9ACFF0183_impl*
 Result := f_DateFormat;
//#UC END# *554CA3ED007F_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.GetDateFormat

procedure TvtCustomDateEdit.ApplyDate(aValue: TDateTime);
//#UC START# *554CA41F01D7_52A9ACFF0183_var*
//#UC END# *554CA41F01D7_52A9ACFF0183_var*
begin
//#UC START# *554CA41F01D7_52A9ACFF0183_impl*
 if Assigned(f_OnApplyDate) and not OnApplyDate(Self, aValue) then
  Exit;
 pm_SetDate(aValue);
 SelectAll;
 if Assigned(f_OnAppliedDate) then
  OnAppliedDate(Self, aValue);
//#UC END# *554CA41F01D7_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ApplyDate

procedure TvtCustomDateEdit.UpdateFormat;
//#UC START# *554CA47D03A0_52A9ACFF0183_var*
//#UC END# *554CA47D03A0_52A9ACFF0183_var*
begin
//#UC START# *554CA47D03A0_52A9ACFF0183_impl*
 f_DateFormat := DefDateFormat(FourDigitYear);
//#UC END# *554CA47D03A0_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.UpdateFormat

procedure TvtCustomDateEdit.CheckValidDate;
//#UC START# *554CA5170329_52A9ACFF0183_var*
//#UC END# *554CA5170329_52A9ACFF0183_var*
begin
//#UC START# *554CA5170329_52A9ACFF0183_impl*
 if TextStored then
 try
  f_Formatting := True;
  try
   pm_SetDate(StrToDateFmt(f_DateFormat, Text));
  finally
   f_Formatting := False;
  end;
 except
  if CanFocus then
   SetFocus;
  raise;
 end;
//#UC END# *554CA5170329_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CheckValidDate

function TvtCustomDateEdit.GetDateMask: ShortString;
//#UC START# *554CA52902A3_52A9ACFF0183_var*
//#UC END# *554CA52902A3_52A9ACFF0183_var*
begin
//#UC START# *554CA52902A3_52A9ACFF0183_impl*
 Result := DefDateMask(f_BlanksChar, FourDigitYear);
//#UC END# *554CA52902A3_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.GetDateMask

procedure TvtCustomDateEdit.UpdateMask;
//#UC START# *554CA555014B_52A9ACFF0183_var*
var
 DateValue: TDateTime;
 OldFormat: ShortString;
//#UC END# *554CA555014B_52A9ACFF0183_var*
begin
//#UC START# *554CA555014B_52A9ACFF0183_impl*
 f_Formatting := True;
 try
  DateValue := pm_GetDate;
  OldFormat := f_DateFormat;
  UpdateFormat;
  if (GetDateMask <> EditMask) or (OldFormat <> f_DateFormat) then
  begin
   { force update }
   EditMask := '';
   EditMask := GetDateMask;
  end;
  pm_SetDate(DateValue);
 finally
  f_Formatting := False;
 end;
 UpdateButtonPosition;
//#UC END# *554CA555014B_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.UpdateMask

procedure TvtCustomDateEdit.ClearDate;
//#UC START# *554CA5630382_52A9ACFF0183_var*
//#UC END# *554CA5630382_52A9ACFF0183_var*
begin
//#UC START# *554CA5630382_52A9ACFF0183_impl*
 Date := NullDate;
//#UC END# *554CA5630382_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ClearDate

function TvtCustomDateEdit.IsValid: Boolean;
 {* введенная дата не является допустимой. 
Пустой бланк "__.__.____" тоже воспринимается как неверная дата. }
//#UC START# *554CA580013A_52A9ACFF0183_var*
//#UC END# *554CA580013A_52A9ACFF0183_var*
begin
//#UC START# *554CA580013A_52A9ACFF0183_impl*
 Result := StrToDateFmtDef(f_DateFormat, Text, NullDate) <> NullDate;
//#UC END# *554CA580013A_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.IsValid

function TvtCustomDateEdit.IsEmpty: Boolean;
 {* False, только когда введена верная дата.
Пустой бланк "__.__.____" воспринимается как неверная дата. }
//#UC START# *554CA652029E_52A9ACFF0183_var*
//#UC END# *554CA652029E_52A9ACFF0183_var*
begin
//#UC START# *554CA652029E_52A9ACFF0183_impl*
 Result := Date = NullDate;
//#UC END# *554CA652029E_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.IsEmpty

function TvtCustomDateEdit.IsBlank: Boolean;
 {* пользователь ничего не ввел в поле редактирования ("__.__.____") }
//#UC START# *554CA67F0123_52A9ACFF0183_var*
//#UC END# *554CA67F0123_52A9ACFF0183_var*
begin
//#UC START# *554CA67F0123_52A9ACFF0183_impl*
 Result := PadInputLiterals(EditMask, '', f_BlanksChar) = Text;
//#UC END# *554CA67F0123_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.IsBlank

procedure TvtCustomDateEdit.AutoResize;
//#UC START# *554CA6CB0191_52A9ACFF0183_var*
const
 cBtnTextSpace = 10;
//#UC END# *554CA6CB0191_52A9ACFF0183_var*
begin
//#UC START# *554CA6CB0191_52A9ACFF0183_impl*
 Width := Canvas.TextWidth('88.88.8888') + Button.Width + BorderWidth * 2 + cBtnTextSpace;
//#UC END# *554CA6CB0191_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.AutoResize

function TvtCustomDateEdit.TextStored: Boolean;
//#UC START# *556305870087_52A9ACFF0183_var*
//#UC END# *556305870087_52A9ACFF0183_var*
begin
//#UC START# *556305870087_52A9ACFF0183_impl*
 Result := not IsEmptyStr(Text, [#0, ' ', {$IfDef XE}FormatSettings.{$EndIf}DateSeparator, f_BlanksChar]);
//#UC END# *556305870087_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TextStored

procedure TvtCustomDateEdit.CMExit(var Message: TCMExit);
//#UC START# *554C9F940101_52A9ACFF0183_var*
//#UC END# *554C9F940101_52A9ACFF0183_var*
begin
//#UC START# *554C9F940101_52A9ACFF0183_impl*
 if not TriggerOnInvalidDate then
 begin
  Date := Date;
  if not (csDesigning in ComponentState) and CheckOnExit then
    CheckValidDate;
  inherited;
 end;
//#UC END# *554C9F940101_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CMExit

procedure TvtCustomDateEdit.CMEnter(var Message: TCMEnter);
//#UC START# *554C9FAE023A_52A9ACFF0183_var*
//#UC END# *554C9FAE023A_52A9ACFF0183_var*
begin
//#UC START# *554C9FAE023A_52A9ACFF0183_impl*
 inherited;
 if not IsValid then
 begin
  SelStart := 0;
  SelLength := 1;
 end;
//#UC END# *554C9FAE023A_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CMEnter

procedure TvtCustomDateEdit.WMMouseWheel(var Message: TMessage);
//#UC START# *554CA4D40035_52A9ACFF0183_var*
//#UC END# *554CA4D40035_52A9ACFF0183_var*
begin
//#UC START# *554CA4D40035_52A9ACFF0183_impl*
 if Parent <> nil then
  SendMessage(Parent.Handle, Message.Msg, Message.wParam, Message.lParam);
//#UC END# *554CA4D40035_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.WMMouseWheel

procedure TvtCustomDateEdit.WMPaste(var Message: TMessage);
//#UC START# *554CA4E801D4_52A9ACFF0183_var*
//#UC END# *554CA4E801D4_52A9ACFF0183_var*
begin
//#UC START# *554CA4E801D4_52A9ACFF0183_impl*
 Clear;
 inherited;
//#UC END# *554CA4E801D4_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.WMPaste

function TvtCustomDateEdit.GetDropDownContainer: TWinControl;
//#UC START# *554CA8F903AE_52A9ACFF0183_var*
//#UC END# *554CA8F903AE_52A9ACFF0183_var*
begin
//#UC START# *554CA8F903AE_52A9ACFF0183_impl*
 MakeCalendar;
 Result := f_CalendarPanel;
//#UC END# *554CA8F903AE_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.GetDropDownContainer

procedure TvtCustomDateEdit.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52A9ACFF0183_var*
//#UC END# *479731C50290_52A9ACFF0183_var*
begin
//#UC START# *479731C50290_52A9ACFF0183_impl*
 if f_Hooked then
 begin
  Application.UnhookMainWindow(FormatSettingsChange);
  f_Hooked := False;
 end;
 FreeAndNil(f_CalendarPanel);
 inherited;
//#UC END# *479731C50290_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.Cleanup

constructor TvtCustomDateEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A9ACFF0183_var*
//#UC END# *47D1602000C6_52A9ACFF0183_var*
begin
//#UC START# *47D1602000C6_52A9ACFF0183_impl*
 inherited Create(AOwner);
 f_RestrictInvalidDate := false;
 f_BlanksChar := ' ';
 //FPopupColor := clBtnFace;
 //FDefNumGlyphs := 2;
 f_StartOfWeek := Monday;
 f_Weekends := [Sunday];
 f_WeekendColor := clRed;
 f_YearDigits := dyDefault;
 ControlState := ControlState + [csCreating];
 try
  UpdateFormat;
  //GlyphKind := gkDefault; { force update }
 finally
  ControlState := ControlState - [csCreating];
 end;
 //CalendarStyle := dcsDefault;

 ButtonStyle := cbsDefault;
// Код закомментирован см. комментарий к vt_imgThemedCalendar (vtStdRes)
// {$IfDef Delphi7}
//  if ThemeServices.ThemesEnabled then
//   ImageIndex := vt_imgThemedCalendar
//  else
// {$EndIf Delphi7}
 ImageIndex := vt_imgCalendar;
//#UC END# *47D1602000C6_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.Create

{$If NOT Defined(NoVCL)}
procedure TvtCustomDateEdit.KeyPress(var Key: Char);
//#UC START# *482C4E0E01E4_52A9ACFF0183_var*
var
 l_Text: AnsiString;
 l_Start, l_Stop, l_Index: Integer;
//#UC END# *482C4E0E01E4_52A9ACFF0183_var*
begin
//#UC START# *482C4E0E01E4_52A9ACFF0183_impl*
 if (DirectInput or IsDroppedDown) and (Key in ['T', 't', 'Е', 'е', '+', '-']) then
  Key := #0;
 if (Key = #0) then
  Exit;
 if IsDroppedDown then
  TvtCalendarPanelFriend(f_CalendarPanel).KeyPress(Key);

 if not f_RestrictInvalidDate then
  inherited KeyPress(Key)
 else
 begin
  l_Text := Text;
  GetSel(l_Start, l_Stop);
  inherited KeyPress(Key);

  for l_Index := l_Start downto 0 do
  begin
   if ((Ord(f_DateFormat[l_Index]) < Ord('a')) or (Ord(f_DateFormat[l_Index]) > Ord('z'))) and
      ((Ord(f_DateFormat[l_Index]) < Ord('A')) or (Ord(f_DateFormat[l_Index]) > Ord('Z'))) then
    Exit;
   if Text[l_Index] <> ' ' then
    Break
  end;

  if not IsDateHalfValid(f_DateFormat, Text) then
   if IsDateFullyFilled(f_DateFormat, Text) then
   begin
    TriggerAutoCorrectDate;
    Text := l3CorrectDate(f_DateFormat, Text);
    SetCursor(l_Start);
    SetSel(l_Start, l_Stop);
   end
   else
   begin
    Text := l_Text;
    SetCursor(l_Start);
    SetSel(l_Start, l_Stop);
   end;
 end;
//#UC END# *482C4E0E01E4_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.KeyPress
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomDateEdit.CreateWindowHandle(const Params: TCreateParams);
 {* Creates a Windows control to represent the control }
//#UC START# *48C67EB000EE_52A9ACFF0183_var*
//#UC END# *48C67EB000EE_52A9ACFF0183_var*
begin
//#UC START# *48C67EB000EE_52A9ACFF0183_impl*
 inherited CreateWindowHandle(Params);
 if Handle <> 0 then
 begin
  UpdateMask;
  if not (csDesigning in ComponentState) and not (IsLibrary or f_Hooked) then
  begin
   Application.HookMainWindow(FormatSettingsChange);
   f_Hooked := True;
  end;
 end;
//#UC END# *48C67EB000EE_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CreateWindowHandle
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomDateEdit.DestroyWindowHandle;
 {* Destroys the window created in the CreateWindowHandle method }
//#UC START# *48C67EDF01C8_52A9ACFF0183_var*
//#UC END# *48C67EDF01C8_52A9ACFF0183_var*
begin
//#UC START# *48C67EDF01C8_52A9ACFF0183_impl*
 if f_Hooked then
 begin
  Application.UnhookMainWindow(FormatSettingsChange);
  f_Hooked := False;
 end;
 inherited DestroyWindowHandle;
//#UC END# *48C67EDF01C8_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.DestroyWindowHandle
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomDateEdit.ActionChange(Sender: TObject;
 CheckDefaults: Boolean);
//#UC START# *52A9A8710199_52A9ACFF0183_var*
//#UC END# *52A9A8710199_52A9ACFF0183_var*
begin
//#UC START# *52A9A8710199_52A9ACFF0183_impl*
 inherited ActionChange(Sender, CheckDefaults);
 if Sender is TCustomAction then
  f_OnExecute := TCustomAction(Sender).OnExecute;
//#UC END# *52A9A8710199_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ActionChange
{$IfEnd} // NOT Defined(NoVCL)

function TvtCustomDateEdit.ProcessCommand(Cmd: Tl3OperationCode;
 aForce: Boolean;
 aCount: Integer): Boolean;
//#UC START# *554CA18500FB_52A9ACFF0183_var*
//#UC END# *554CA18500FB_52A9ACFF0183_var*
begin
//#UC START# *554CA18500FB_52A9ACFF0183_impl*
 Result := inherited ProcessCommand(Cmd, aForce, aCount);
 if Cmd = ccPaste then
 begin
  Perform(WM_PASTE, 0, 0);
  Result := True;
 end;
//#UC END# *554CA18500FB_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ProcessCommand

{$If NOT Defined(NoVCL)}
procedure TvtCustomDateEdit.Change;
//#UC START# *554CAA8400E5_52A9ACFF0183_var*
//#UC END# *554CAA8400E5_52A9ACFF0183_var*
begin
//#UC START# *554CAA8400E5_52A9ACFF0183_impl*
 if not f_Formatting then
  inherited Change;
//#UC END# *554CAA8400E5_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.Change
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomDateEdit.KeyDown(var Key: Word;
 Shift: TShiftState);
//#UC START# *554CABC100AC_52A9ACFF0183_var*
var
 l_DroppedDown: Boolean;
 l_NeedReturnFocus: Boolean;
//#UC END# *554CABC100AC_52A9ACFF0183_var*
begin
//#UC START# *554CABC100AC_52A9ACFF0183_impl*
 l_NeedReturnFocus := False;
 if (DirectInput or IsDroppedDown) and (Shift = []) then
 case Key of
  Ord('T'), Ord('t'), Ord('Е'), Ord('е'):
   begin
    ApplyDate(Trunc(Now));
    Key := 0;
   end;
  VK_ADD:
   begin
    ApplyDate(NormDate(Date, Now) + 1);
    Key := 0;
   end;
  VK_SUBTRACT:
   begin
    ApplyDate(NormDate(Date, Now) - 1);
    Key := 0;
   end;
  VK_RETURN:
   begin
    l_DroppedDown := DroppedDown;
    Windows.SetFocus(0);
    l_NeedReturnFocus := True;
    if l_DroppedDown then
     ApplyDate(TPopupCalendar(f_CalendarPanel).Date)
    else
     DoExecute;
   end;
 end;
 if (Key <> 0) then
 begin
  if IsDroppedDown then
   TvtCalendarPanelFriend(f_CalendarPanel).KeyDown(Key, Shift);
  inherited KeyDown(Key, Shift);
 end;//Key <> 0
 if l_NeedReturnFocus then
  Windows.SetFocus(Handle);
//#UC END# *554CABC100AC_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.KeyDown
{$IfEnd} // NOT Defined(NoVCL)

{$If Defined(l3HackedVCL) AND NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary)}
function TvtCustomDateEdit.TextFromClipboard: AnsiString;
//#UC START# *554CBB4B0240_52A9ACFF0183_var*
//#UC END# *554CBB4B0240_52A9ACFF0183_var*
begin
//#UC START# *554CBB4B0240_52A9ACFF0183_impl*
 Clipboard.Open;
 try
  Result := l3CorrectDateSeparators(EditMask, Clipboard.AsText, BlanksChar);
 finally
  Clipboard.Close;
 end;
//#UC END# *554CBB4B0240_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TextFromClipboard
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL) AND NOT Defined(DesignTimeLibrary)

procedure TvtCustomDateEdit.DropDown;
//#UC START# *554CBC32006E_52A9ACFF0183_var*
//#UC END# *554CBC32006E_52A9ACFF0183_var*
begin
//#UC START# *554CBC32006E_52A9ACFF0183_impl*
 if DroppedDown then
  SendMessage(TWinControl(Self).Handle, WM_vt_CALLCLOSEUP, 0, 0)
 else
 begin
  Date := Date;
  MakeCalendar;
  TPopupCalendar(f_CalendarPanel).Date := NormDate(Date, Now);
  inherited DropDown;
  ///Windows.SetFocus(TPopupCalendar(f_CalendarPanel).f_Calendar.Handle);
 end;
//#UC END# *554CBC32006E_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.DropDown

procedure TvtCustomDateEdit.CloseUp(Accept: Boolean);
//#UC START# *554CBC4500ED_52A9ACFF0183_var*
//#UC END# *554CBC4500ED_52A9ACFF0183_var*
begin
//#UC START# *554CBC4500ED_52A9ACFF0183_impl*
 if Assigned(f_CalendarPanel) and
  not TPopupCalendar(f_CalendarPanel).f_MenuOpen then
 begin
  if Accept then
   ApplyDate(TPopupCalendar(f_CalendarPanel).Date);
  inherited CloseUp(Accept);
 end;
//#UC END# *554CBC4500ED_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CloseUp

procedure TvtCalendarForm.pm_SetDateText(const aValue: AnsiString);
//#UC START# *554CC0D002D0_554CBF5C01D8set_var*
var
 l_Date: TDateTime;
//#UC END# *554CC0D002D0_554CBF5C01D8set_var*
begin
//#UC START# *554CC0D002D0_554CBF5C01D8set_impl*
 if aValue <> '' then
 begin
  TPopupCalendar(f_Calendar).Date := StrToDateFmtDef(f_DateFormat, aValue, NullDate);
  f_DateText := aValue;
 end
 else
 begin
  l_Date := Now;
  TPopupCalendar(f_Calendar).Date := l_Date;
  f_DateText := FormatDateTime(f_DateFormat, l_Date);
 end;
//#UC END# *554CC0D002D0_554CBF5C01D8set_impl*
end;//TvtCalendarForm.pm_SetDateText

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtCalendarForm.InitFields;
//#UC START# *47A042E100E2_554CBF5C01D8_var*
//#UC END# *47A042E100E2_554CBF5C01D8_var*
begin
//#UC START# *47A042E100E2_554CBF5C01D8_impl*
 inherited;
 f_Calendar := TDblClickPopupCalendar.Create(self);
 f_Calendar.Parent := Self;
 AutoSize := True;
 BorderStyle := bsToolWindow;
//#UC END# *47A042E100E2_554CBF5C01D8_impl*
end;//TvtCalendarForm.InitFields
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(NoVCL)}
procedure TvtCalendarForm.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_554CBF5C01D8_var*
var
 l_Date: TDateTime;
//#UC END# *47E136A80191_554CBF5C01D8_var*
begin
//#UC START# *47E136A80191_554CBF5C01D8_impl*
 if Message.Msg = WM_vt_CALLCLOSEUP then
 begin
  if Message.WParam = 1 then
  begin
   ModalResult := mrOk;
   l_Date := TPopupCalendar(f_Calendar).Date;
   if l_Date = NullDate then
    f_DateText := ''
   else
    f_DateText := FormatDateTime(f_DateFormat, l_Date);
  end
  else
   ModalResult := mrCancel;
 end
 else
  inherited;
//#UC END# *47E136A80191_554CBF5C01D8_impl*
end;//TvtCalendarForm.WndProc
{$IfEnd} // NOT Defined(NoVCL)

{$If Defined(DesignTimeLibrary)}
procedure TvtCalendarForm.AfterConstruction;
 {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
//#UC START# *49F057120234_554CBF5C01D8_var*
//#UC END# *49F057120234_554CBF5C01D8_var*
begin
//#UC START# *49F057120234_554CBF5C01D8_impl*
 inherited;
 f_Calendar := TDblClickPopupCalendar.Create(self);
 f_Calendar.Parent := Self;
 AutoSize := True;
 BorderStyle := bsToolWindow;
//#UC END# *49F057120234_554CBF5C01D8_impl*
end;//TvtCalendarForm.AfterConstruction
{$IfEnd} // Defined(DesignTimeLibrary)

procedure TDblClickPopupCalendar.OkClick(Sender: TObject);
//#UC START# *5562DEB2009F_5562DE9702A4_var*
//#UC END# *5562DEB2009F_5562DE9702A4_var*
begin
//#UC START# *5562DEB2009F_5562DE9702A4_impl*
 PostMessage(TWinControl(Owner).Handle, WM_vt_CALLCLOSEUP, 1, 0);
//#UC END# *5562DEB2009F_5562DE9702A4_impl*
end;//TDblClickPopupCalendar.OkClick

procedure TDblClickPopupCalendar.CalendarMouseUp(Sender: TObject;
 Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *5562DBEF006B_5562DE9702A4_var*
//#UC END# *5562DBEF006B_5562DE9702A4_var*
begin
//#UC START# *5562DBEF006B_5562DE9702A4_impl*
 f_MenuOpen := False;
 if (Button = mbLeft) and (Shift = []) then
  with TvtCalendarPanelFriend(f_Calendar) do
   if (GetDayFromPoint(Point(X,Y)) > 0) and (GetDayFromPoint(Point(X,Y)) = OldDay) then
    if (Owner is TWinControl) then
     PostMessage(TWinControl(Owner).Handle, WM_vt_CALLCLOSEUP, 1, 0);
//#UC END# *5562DBEF006B_5562DE9702A4_impl*
end;//TDblClickPopupCalendar.CalendarMouseUp

function TDblClickPopupCalendar.CalcTodayPadWidth: Integer;
//#UC START# *5562DDAF0285_5562DE9702A4_var*
//#UC END# *5562DDAF0285_5562DE9702A4_var*
begin
//#UC START# *5562DDAF0285_5562DE9702A4_impl*
 Result := 2 * (3 + cButtonWidth);
//#UC END# *5562DDAF0285_5562DE9702A4_impl*
end;//TDblClickPopupCalendar.CalcTodayPadWidth

procedure TDblClickPopupCalendar.MakeTodayPad;
//#UC START# *5562DE3A02DF_5562DE9702A4_var*
var
 lPanel: TvtPanel;
//#UC END# *5562DE3A02DF_5562DE9702A4_var*
begin
//#UC START# *5562DE3A02DF_5562DE9702A4_impl*
 lPanel := TvtPanel.Create(Self);
 with lPanel do
 begin
  Parent := Self;
  Height := 25;
  BevelOuter := bvNone;
  Align := alBottom;
 end;

 with TSpeedButton.Create(Self) do
 begin
  Parent := lPanel;
  SetBounds(lPanel.Width - 3 - cButtonWidth - cButtonWidth, 3, cButtonWidth, cButtonHeight);
  Anchors := [akRight, akTop];
{$IF not Defined(nsTest) OR Defined(InsiderTest)}
  vtStdResources.Images.GetBitmap(vt_imgOk, Glyph);
{$IfEND}
  Flat := True;
  OnClick := OkClick;
  ShowHint := True;
  Caption := str_vtChoose.AsStr;
  Hint := str_vtChoose.AsStr;
  Font.Charset := RUSSIAN_CHARSET;
 end;

 with TSpeedButton.Create(Self) do
 begin
  Parent := lPanel;
  SetBounds(lPanel.Width - 3 - cButtonWidth, 3, cButtonWidth, cButtonHeight);
  Anchors := [akRight, akTop];
{$IF not Defined(nsTest) OR Defined(InsiderTest)}
  vtStdResources.Images.GetBitmap(vt_imgCancel, Glyph);
{$IfEND}
  Flat := True;
  OnClick := CancelClick;
  ShowHint := True;
  Caption := str_vtCancel.AsStr;
  Hint := str_vtCancel.AsStr;
 end;
//#UC END# *5562DE3A02DF_5562DE9702A4_impl*
end;//TDblClickPopupCalendar.MakeTodayPad

procedure TDblClickPopupCalendar.AdjustTitleButtonFont(aLabel: TSpeedButton);
//#UC START# *5562DE4D0243_5562DE9702A4_var*
//#UC END# *5562DE4D0243_5562DE9702A4_var*
begin
//#UC START# *5562DE4D0243_5562DE9702A4_impl*
 aLabel.Font.Style := aLabel.Font.Style + [fsUnderline];
 aLabel.Font.Color := clBlue;
//#UC END# *5562DE4D0243_5562DE9702A4_impl*
end;//TDblClickPopupCalendar.AdjustTitleButtonFont

//#UC START# *4AA8AB7B038Fimpl*
{$R calendar.RES}
//#UC END# *4AA8AB7B038Fimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPopupCalendar);
 {* Регистрация TPopupCalendar }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomDateEdit);
 {* Регистрация TvtCustomDateEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCalendarForm);
 {* Регистрация TvtCalendarForm }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDblClickPopupCalendar);
 {* Регистрация TDblClickPopupCalendar }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtDateEdit);
 {* Регистрация TvtDateEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
