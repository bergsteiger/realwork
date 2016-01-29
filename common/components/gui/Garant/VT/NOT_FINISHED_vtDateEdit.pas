unit NOT_FINISHED_vtDateEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtDateEdit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::DateEdit::TvtDateEdit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Messages,
  Classes,
  l3Date,
  Graphics,
  Controls,
  vtForm,
  vtCombo,
  l3Interfaces
  ;

type
 TPopupCalendar = class
 end;//TPopupCalendar

 TvtOnApplyDate = function (aSender: TObject;
  var aValue: TDateTime): Boolean of object;

 TvtOnAppliedDate = procedure (aSender: TObject;
  aValue: TDateTime) of object;

 TYearDigits = (
   dyDefault
 , dyFour
 , dyTwo
 );//TYearDigits

 TvtCustomDateEdit = class(TvtCustomCombo)
 private
 // private fields
   f_Hooked : Boolean;
   f_DateFormat : ShortString;
   f_OnApplyDate : TvtOnApplyDate;
    {* Поле для свойства OnApplyDate}
   f_OnAppliedDate : TvtOnAppliedDate;
    {* Поле для свойства OnAppliedDate}
   f_OnExecute : TNotifyEvent;
    {* Поле для свойства OnExecute}
   f_OnInvalidDate : TNotifyEvent;
    {* Поле для свойства OnInvalidDate}
   f_RestrictInvalidDate : Boolean;
    {* Поле для свойства RestrictInvalidDate}
   f_BlanksChar : AnsiChar;
    {* Поле для свойства BlanksChar}
   f_StartOfWeek : TStDayType;
    {* Поле для свойства StartOfWeek}
   f_Weekends : TDaysOfWeek;
    {* Поле для свойства Weekends}
   f_WeekendColor : TColor;
    {* Поле для свойства WeekendColor}
   f_YearDigits : TYearDigits;
    {* Поле для свойства YearDigits}
   f_CheckOnExit : Boolean;
    {* Поле для свойства CheckOnExit}
   f_Formatting : Boolean;
    {* Поле для свойства Formatting}
 private
 // private methods
   function FourDigitYear: Boolean;
   function FormatSettingsChange(var Message: TMessage): Boolean;
   procedure CMExit(var Message: TCMExit); message CM_EXIT;
   procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
   procedure WMMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
   procedure WMPaste(var Message: TMessage); message WM_PASTE;
 protected
 // property methods
   function pm_GetOnAutoCorrectDate: TNotifyEvent; virtual;
   procedure pm_SetOnAutoCorrectDate(aValue: TNotifyEvent); virtual;
   procedure pm_SetBlanksChar(aValue: AnsiChar);
   procedure pm_SetStartOfWeek(aValue: TStDayType);
   procedure pm_SetWeekends(aValue: TDaysOfWeek);
   procedure pm_SetWeekendColor(aValue: TColor);
   procedure pm_SetYearDigits(aValue: TYearDigits);
   function pm_GetTDateTime: TDateTime;
   procedure pm_SetTDateTime(aValue: TDateTime);
   {$If defined(SupportStDate)}
   function pm_GetStDate: TStDate; virtual;
   procedure pm_SetStDate(aValue: TStDate); virtual;
   {$IfEnd} //SupportStDate
 protected
 // realized methods
   function GetDropDownContainer: TWinControl; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure KeyPress(var Key: Char); override;
   procedure CreateWindowHandle(const Params: TCreateParams); override;
     {* Creates a Windows control to represent the control }
   procedure DestroyWindowHandle; override;
     {* Destroys the window created in the CreateWindowHandle method }
   procedure ActionChange(Sender: TObject;
    CheckDefaults: Boolean); override;
   function ProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; override;
   procedure Change; override;
     {* Сигнатура метода Change }
   procedure KeyDown(var Key: Word;
    Shift: TShiftState); override;
   {$If defined(l3HackedVCL) AND not defined(DesignTimeLibrary)}
   function TextFromClipboard: AnsiString; override;
   {$IfEnd} //l3HackedVCL AND not DesignTimeLibrary
   {$If defined(Delphi7)}
   procedure UpdateButtonPosition; override;
     {* Сигнатура метода UpdateButtonPosition }
   {$IfEnd} //Delphi7
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   procedure DropDown; override;
     {* Сигнатура метода DropDown }
   procedure CloseUp(Accept: Boolean); override;
 protected
 // protected fields
   f_CalendarPanel : TWinControl;
 protected
 // protected methods
   procedure DoExecute; virtual;
     {* Сигнатура метода DoExecute }
   procedure TriggerAutoCorrectDate; virtual;
     {* сообщает об автокоррекции }
   function TriggerOnInvalidDate: Boolean; virtual;
     {* возникает при неправильно введенной дате при выходе из компонента }
   procedure MakeCalendar; virtual;
     {* Сигнатура метода MakeCalendar }
   function GetDateFormat: ShortString;
   procedure ApplyDate(aValue: TDateTime); virtual;
   procedure UpdateFormat;
     {* Сигнатура метода UpdateFormat }
 public
 // public methods
   procedure CheckValidDate;
     {* Сигнатура метода CheckValidDate }
   function GetDateMask: ShortString;
   procedure UpdateMask; virtual;
     {* Сигнатура метода UpdateMask }
   procedure ClearDate;
     {* Сигнатура метода ClearDate }
   function IsValid: Boolean;
     {* введенная дата не является допустимой. 
Пустой бланк "__.__.____" тоже воспринимается как неверная дата. }
   function IsEmpty: Boolean;
     {* False, только когда введена верная дата.
Пустой бланк "__.__.____" воспринимается как неверная дата. }
   function IsBlank: Boolean;
     {* пользователь ничего не ввел в поле редактирования ("__.__.____") }
   procedure AutoResize;
     {* Сигнатура метода AutoResize }
 public
 // public properties
   property OnApplyDate: TvtOnApplyDate
     read f_OnApplyDate
     write f_OnApplyDate;
   property OnAppliedDate: TvtOnAppliedDate
     read f_OnAppliedDate
     write f_OnAppliedDate;
   property OnAutoCorrectDate: TNotifyEvent
     read pm_GetOnAutoCorrectDate
     write pm_SetOnAutoCorrectDate;
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
     write pm_SetStartOfWeek;
   property Weekends: TDaysOfWeek
     read f_Weekends
     write pm_SetWeekends;
   property WeekendColor: TColor
     read f_WeekendColor
     write pm_SetWeekendColor;
   property YearDigits: TYearDigits
     read f_YearDigits
     write pm_SetYearDigits;
   property CheckOnExit: Boolean
     read f_CheckOnExit
     write f_CheckOnExit;
   property Formatting: Boolean
     read f_Formatting;
   property TDateTime: TDateTime
     read pm_GetTDateTime
     write pm_SetTDateTime;
   {$If defined(SupportStDate)}
   property StDate: TStDate
     read pm_GetStDate
     write pm_SetStDate;
   {$IfEnd} //SupportStDate
 end;//TvtCustomDateEdit

 {$Define SupportStDate}

 TvtCalendarForm = class(TvtForm)
 private
 // private fields
   f_Calendar : TWinControl;
   f_DateFormat : ShortString;
   f_DateText : AnsiString;
    {* Поле для свойства DateText}
 protected
 // property methods
   procedure pm_SetDateText(const aValue: AnsiString);
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure WndProc(var Message: TMessage); override;
   procedure AfterConstruction; override;
     {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
 public
 // public properties
   property DateText: AnsiString
     read f_DateText
     write pm_SetDateText;
 end;//TvtCalendarForm

//#UC START# *4AA8AB7B038Fci*
//#UC END# *4AA8AB7B038Fci*
 TvtDateEdit = {final} class(TvtCustomDateEdit)
//#UC START# *4AA8AB7B038Fpubl*
//#UC END# *4AA8AB7B038Fpubl*
 end;//TvtDateEdit

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwClassRef
  {$IfEnd} //not NoScripts
  
  ;

// start class TvtCustomDateEdit

function TvtCustomDateEdit.FourDigitYear: Boolean;
//#UC START# *554C9CE10330_52A9ACFF0183_var*
//#UC END# *554C9CE10330_52A9ACFF0183_var*
begin
//#UC START# *554C9CE10330_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C9CE10330_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.FourDigitYear

function TvtCustomDateEdit.FormatSettingsChange(var Message: TMessage): Boolean;
//#UC START# *554C9D670390_52A9ACFF0183_var*
//#UC END# *554C9D670390_52A9ACFF0183_var*
begin
//#UC START# *554C9D670390_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C9D670390_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.FormatSettingsChange

procedure TvtCustomDateEdit.DoExecute;
//#UC START# *52A9AF0F021B_52A9ACFF0183_var*
//#UC END# *52A9AF0F021B_52A9ACFF0183_var*
begin
//#UC START# *52A9AF0F021B_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A9AF0F021B_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.DoExecute

procedure TvtCustomDateEdit.TriggerAutoCorrectDate;
//#UC START# *554CA29100ED_52A9ACFF0183_var*
//#UC END# *554CA29100ED_52A9ACFF0183_var*
begin
//#UC START# *554CA29100ED_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA29100ED_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TriggerAutoCorrectDate

function TvtCustomDateEdit.TriggerOnInvalidDate: Boolean;
//#UC START# *554CA2C1020B_52A9ACFF0183_var*
//#UC END# *554CA2C1020B_52A9ACFF0183_var*
begin
//#UC START# *554CA2C1020B_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA2C1020B_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TriggerOnInvalidDate

procedure TvtCustomDateEdit.MakeCalendar;
//#UC START# *554CA3BF011D_52A9ACFF0183_var*
//#UC END# *554CA3BF011D_52A9ACFF0183_var*
begin
//#UC START# *554CA3BF011D_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA3BF011D_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.MakeCalendar

function TvtCustomDateEdit.GetDateFormat: ShortString;
//#UC START# *554CA3ED007F_52A9ACFF0183_var*
//#UC END# *554CA3ED007F_52A9ACFF0183_var*
begin
//#UC START# *554CA3ED007F_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA3ED007F_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.GetDateFormat

procedure TvtCustomDateEdit.ApplyDate(aValue: TDateTime);
//#UC START# *554CA41F01D7_52A9ACFF0183_var*
//#UC END# *554CA41F01D7_52A9ACFF0183_var*
begin
//#UC START# *554CA41F01D7_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA41F01D7_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ApplyDate

procedure TvtCustomDateEdit.UpdateFormat;
//#UC START# *554CA47D03A0_52A9ACFF0183_var*
//#UC END# *554CA47D03A0_52A9ACFF0183_var*
begin
//#UC START# *554CA47D03A0_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA47D03A0_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.UpdateFormat

procedure TvtCustomDateEdit.CheckValidDate;
//#UC START# *554CA5170329_52A9ACFF0183_var*
//#UC END# *554CA5170329_52A9ACFF0183_var*
begin
//#UC START# *554CA5170329_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA5170329_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CheckValidDate

function TvtCustomDateEdit.GetDateMask: ShortString;
//#UC START# *554CA52902A3_52A9ACFF0183_var*
//#UC END# *554CA52902A3_52A9ACFF0183_var*
begin
//#UC START# *554CA52902A3_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA52902A3_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.GetDateMask

procedure TvtCustomDateEdit.UpdateMask;
//#UC START# *554CA555014B_52A9ACFF0183_var*
//#UC END# *554CA555014B_52A9ACFF0183_var*
begin
//#UC START# *554CA555014B_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA555014B_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.UpdateMask

procedure TvtCustomDateEdit.ClearDate;
//#UC START# *554CA5630382_52A9ACFF0183_var*
//#UC END# *554CA5630382_52A9ACFF0183_var*
begin
//#UC START# *554CA5630382_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA5630382_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ClearDate

function TvtCustomDateEdit.IsValid: Boolean;
//#UC START# *554CA580013A_52A9ACFF0183_var*
//#UC END# *554CA580013A_52A9ACFF0183_var*
begin
//#UC START# *554CA580013A_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA580013A_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.IsValid

function TvtCustomDateEdit.IsEmpty: Boolean;
//#UC START# *554CA652029E_52A9ACFF0183_var*
//#UC END# *554CA652029E_52A9ACFF0183_var*
begin
//#UC START# *554CA652029E_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA652029E_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.IsEmpty

function TvtCustomDateEdit.IsBlank: Boolean;
//#UC START# *554CA67F0123_52A9ACFF0183_var*
//#UC END# *554CA67F0123_52A9ACFF0183_var*
begin
//#UC START# *554CA67F0123_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA67F0123_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.IsBlank

procedure TvtCustomDateEdit.AutoResize;
//#UC START# *554CA6CB0191_52A9ACFF0183_var*
//#UC END# *554CA6CB0191_52A9ACFF0183_var*
begin
//#UC START# *554CA6CB0191_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA6CB0191_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.AutoResize

function TvtCustomDateEdit.pm_GetOnAutoCorrectDate: TNotifyEvent;
//#UC START# *554C8B2B0323_52A9ACFF0183get_var*
//#UC END# *554C8B2B0323_52A9ACFF0183get_var*
begin
//#UC START# *554C8B2B0323_52A9ACFF0183get_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8B2B0323_52A9ACFF0183get_impl*
end;//TvtCustomDateEdit.pm_GetOnAutoCorrectDate

procedure TvtCustomDateEdit.pm_SetOnAutoCorrectDate(aValue: TNotifyEvent);
//#UC START# *554C8B2B0323_52A9ACFF0183set_var*
//#UC END# *554C8B2B0323_52A9ACFF0183set_var*
begin
//#UC START# *554C8B2B0323_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8B2B0323_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetOnAutoCorrectDate

procedure TvtCustomDateEdit.pm_SetBlanksChar(aValue: AnsiChar);
//#UC START# *554C8C8802BD_52A9ACFF0183set_var*
//#UC END# *554C8C8802BD_52A9ACFF0183set_var*
begin
//#UC START# *554C8C8802BD_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8C8802BD_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetBlanksChar

procedure TvtCustomDateEdit.pm_SetStartOfWeek(aValue: TStDayType);
//#UC START# *554C8D6D001E_52A9ACFF0183set_var*
//#UC END# *554C8D6D001E_52A9ACFF0183set_var*
begin
//#UC START# *554C8D6D001E_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8D6D001E_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetStartOfWeek

procedure TvtCustomDateEdit.pm_SetWeekends(aValue: TDaysOfWeek);
//#UC START# *554C8E3103B3_52A9ACFF0183set_var*
//#UC END# *554C8E3103B3_52A9ACFF0183set_var*
begin
//#UC START# *554C8E3103B3_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8E3103B3_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetWeekends

procedure TvtCustomDateEdit.pm_SetWeekendColor(aValue: TColor);
//#UC START# *554C8E9601AB_52A9ACFF0183set_var*
//#UC END# *554C8E9601AB_52A9ACFF0183set_var*
begin
//#UC START# *554C8E9601AB_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8E9601AB_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetWeekendColor

procedure TvtCustomDateEdit.pm_SetYearDigits(aValue: TYearDigits);
//#UC START# *554C8F5C038E_52A9ACFF0183set_var*
//#UC END# *554C8F5C038E_52A9ACFF0183set_var*
begin
//#UC START# *554C8F5C038E_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C8F5C038E_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetYearDigits

function TvtCustomDateEdit.pm_GetTDateTime: TDateTime;
//#UC START# *554C92180230_52A9ACFF0183get_var*
//#UC END# *554C92180230_52A9ACFF0183get_var*
begin
//#UC START# *554C92180230_52A9ACFF0183get_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C92180230_52A9ACFF0183get_impl*
end;//TvtCustomDateEdit.pm_GetTDateTime

procedure TvtCustomDateEdit.pm_SetTDateTime(aValue: TDateTime);
//#UC START# *554C92180230_52A9ACFF0183set_var*
//#UC END# *554C92180230_52A9ACFF0183set_var*
begin
//#UC START# *554C92180230_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C92180230_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetTDateTime

{$If defined(SupportStDate)}
function TvtCustomDateEdit.pm_GetStDate: TStDate;
//#UC START# *554C924B03A3_52A9ACFF0183get_var*
//#UC END# *554C924B03A3_52A9ACFF0183get_var*
begin
//#UC START# *554C924B03A3_52A9ACFF0183get_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C924B03A3_52A9ACFF0183get_impl*
end;//TvtCustomDateEdit.pm_GetStDate
{$IfEnd} //SupportStDate

{$If defined(SupportStDate)}
procedure TvtCustomDateEdit.pm_SetStDate(aValue: TStDate);
//#UC START# *554C924B03A3_52A9ACFF0183set_var*
//#UC END# *554C924B03A3_52A9ACFF0183set_var*
begin
//#UC START# *554C924B03A3_52A9ACFF0183set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C924B03A3_52A9ACFF0183set_impl*
end;//TvtCustomDateEdit.pm_SetStDate
{$IfEnd} //SupportStDate

procedure TvtCustomDateEdit.CMExit(var Message: TCMExit);
//#UC START# *554C9F940101_52A9ACFF0183_var*
//#UC END# *554C9F940101_52A9ACFF0183_var*
begin
//#UC START# *554C9F940101_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C9F940101_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CMExit

procedure TvtCustomDateEdit.CMEnter(var Message: TCMEnter);
//#UC START# *554C9FAE023A_52A9ACFF0183_var*
//#UC END# *554C9FAE023A_52A9ACFF0183_var*
begin
//#UC START# *554C9FAE023A_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554C9FAE023A_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CMEnter

procedure TvtCustomDateEdit.WMMouseWheel(var Message: TMessage);
//#UC START# *554CA4D40035_52A9ACFF0183_var*
//#UC END# *554CA4D40035_52A9ACFF0183_var*
begin
//#UC START# *554CA4D40035_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA4D40035_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.WMMouseWheel

procedure TvtCustomDateEdit.WMPaste(var Message: TMessage);
//#UC START# *554CA4E801D4_52A9ACFF0183_var*
//#UC END# *554CA4E801D4_52A9ACFF0183_var*
begin
//#UC START# *554CA4E801D4_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA4E801D4_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.WMPaste

function TvtCustomDateEdit.GetDropDownContainer: TWinControl;
//#UC START# *554CA8F903AE_52A9ACFF0183_var*
//#UC END# *554CA8F903AE_52A9ACFF0183_var*
begin
//#UC START# *554CA8F903AE_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA8F903AE_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.GetDropDownContainer

procedure TvtCustomDateEdit.Cleanup;
//#UC START# *479731C50290_52A9ACFF0183_var*
//#UC END# *479731C50290_52A9ACFF0183_var*
begin
//#UC START# *479731C50290_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.Cleanup

constructor TvtCustomDateEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A9ACFF0183_var*
//#UC END# *47D1602000C6_52A9ACFF0183_var*
begin
//#UC START# *47D1602000C6_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *47D1602000C6_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.Create

procedure TvtCustomDateEdit.KeyPress(var Key: Char);
//#UC START# *482C4E0E01E4_52A9ACFF0183_var*
//#UC END# *482C4E0E01E4_52A9ACFF0183_var*
begin
//#UC START# *482C4E0E01E4_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C4E0E01E4_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.KeyPress

procedure TvtCustomDateEdit.CreateWindowHandle(const Params: TCreateParams);
//#UC START# *48C67EB000EE_52A9ACFF0183_var*
//#UC END# *48C67EB000EE_52A9ACFF0183_var*
begin
//#UC START# *48C67EB000EE_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C67EB000EE_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CreateWindowHandle

procedure TvtCustomDateEdit.DestroyWindowHandle;
//#UC START# *48C67EDF01C8_52A9ACFF0183_var*
//#UC END# *48C67EDF01C8_52A9ACFF0183_var*
begin
//#UC START# *48C67EDF01C8_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C67EDF01C8_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.DestroyWindowHandle

procedure TvtCustomDateEdit.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
//#UC START# *52A9A8710199_52A9ACFF0183_var*
//#UC END# *52A9A8710199_52A9ACFF0183_var*
begin
//#UC START# *52A9A8710199_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A9A8710199_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ActionChange

function TvtCustomDateEdit.ProcessCommand(Cmd: Tl3OperationCode;
  aForce: Boolean;
  aCount: Integer): Boolean;
//#UC START# *554CA18500FB_52A9ACFF0183_var*
//#UC END# *554CA18500FB_52A9ACFF0183_var*
begin
//#UC START# *554CA18500FB_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CA18500FB_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.ProcessCommand

procedure TvtCustomDateEdit.Change;
//#UC START# *554CAA8400E5_52A9ACFF0183_var*
//#UC END# *554CAA8400E5_52A9ACFF0183_var*
begin
//#UC START# *554CAA8400E5_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CAA8400E5_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.Change

procedure TvtCustomDateEdit.KeyDown(var Key: Word;
  Shift: TShiftState);
//#UC START# *554CABC100AC_52A9ACFF0183_var*
//#UC END# *554CABC100AC_52A9ACFF0183_var*
begin
//#UC START# *554CABC100AC_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CABC100AC_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.KeyDown

{$If defined(l3HackedVCL) AND not defined(DesignTimeLibrary)}
function TvtCustomDateEdit.TextFromClipboard: AnsiString;
//#UC START# *554CBB4B0240_52A9ACFF0183_var*
//#UC END# *554CBB4B0240_52A9ACFF0183_var*
begin
//#UC START# *554CBB4B0240_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBB4B0240_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.TextFromClipboard
{$IfEnd} //l3HackedVCL AND not DesignTimeLibrary

{$If defined(Delphi7)}
procedure TvtCustomDateEdit.UpdateButtonPosition;
//#UC START# *554CBBA3004E_52A9ACFF0183_var*
//#UC END# *554CBBA3004E_52A9ACFF0183_var*
begin
//#UC START# *554CBBA3004E_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBBA3004E_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.UpdateButtonPosition
{$IfEnd} //Delphi7

procedure TvtCustomDateEdit.DropDown;
//#UC START# *554CBC32006E_52A9ACFF0183_var*
//#UC END# *554CBC32006E_52A9ACFF0183_var*
begin
//#UC START# *554CBC32006E_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBC32006E_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.DropDown

procedure TvtCustomDateEdit.CloseUp(Accept: Boolean);
//#UC START# *554CBC4500ED_52A9ACFF0183_var*
//#UC END# *554CBC4500ED_52A9ACFF0183_var*
begin
//#UC START# *554CBC4500ED_52A9ACFF0183_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBC4500ED_52A9ACFF0183_impl*
end;//TvtCustomDateEdit.CloseUp
// start class TvtCalendarForm

procedure TvtCalendarForm.pm_SetDateText(const aValue: AnsiString);
//#UC START# *554CC0D002D0_554CBF5C01D8set_var*
//#UC END# *554CC0D002D0_554CBF5C01D8set_var*
begin
//#UC START# *554CC0D002D0_554CBF5C01D8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CC0D002D0_554CBF5C01D8set_impl*
end;//TvtCalendarForm.pm_SetDateText

procedure TvtCalendarForm.InitFields;
//#UC START# *47A042E100E2_554CBF5C01D8_var*
//#UC END# *47A042E100E2_554CBF5C01D8_var*
begin
//#UC START# *47A042E100E2_554CBF5C01D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_554CBF5C01D8_impl*
end;//TvtCalendarForm.InitFields

procedure TvtCalendarForm.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_554CBF5C01D8_var*
//#UC END# *47E136A80191_554CBF5C01D8_var*
begin
//#UC START# *47E136A80191_554CBF5C01D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E136A80191_554CBF5C01D8_impl*
end;//TvtCalendarForm.WndProc

procedure TvtCalendarForm.AfterConstruction;
//#UC START# *49F057120234_554CBF5C01D8_var*
//#UC END# *49F057120234_554CBF5C01D8_var*
begin
//#UC START# *49F057120234_554CBF5C01D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *49F057120234_554CBF5C01D8_impl*
end;//TvtCalendarForm.AfterConstruction

//#UC START# *4AA8AB7B038Fimpl*
//#UC END# *4AA8AB7B038Fimpl*

initialization
{$If not defined(NoScripts)}
// Регистрация TvtCustomDateEdit
 TtfwClassRef.Register(TvtCustomDateEdit);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtCalendarForm
 TtfwClassRef.Register(TvtCalendarForm);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtDateEdit
 TtfwClassRef.Register(TvtDateEdit);
{$IfEnd} //not NoScripts

end.