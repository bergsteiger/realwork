unit vtCalendarPanel;

// Модуль: "w:\common\components\gui\Garant\VT\vtCalendarPanel.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

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
  private
   f_ForceRedraw: Boolean;
   f_MouseDown: Boolean;
   f_MonthIndent: Byte;
   f_CurYear: Word;
   f_CurMonth: Word;
   f_CurDay: Word;
   f_StartOfWeek: TStDayType;
    {* Поле для свойства StartOfWeek }
   f_Weekends: TDaysOfWeek;
    {* Поле для свойства Weekends }
   f_WeekendColor: TColor;
    {* Поле для свойства WeekendColor }
   f_OnChange: TNotifyEvent;
    {* Поле для свойства OnChange }
   f_OldDay: Integer;
    {* Поле для свойства OldDay }
  private
   procedure WMGetDlgCode(var Msg: TWMGetDlgCode);
   procedure WMLButtonDown(var Message: TWMLButtonDown);
   procedure WMLButtonUp(var Message: TWMLButtonUp);
   procedure WMMouseMove(var Message: TWMMouseMove);
   procedure WMShowWindow(var Message: TWMShowWindow);
  protected
   function pm_GetDate: TDateTime;
   procedure pm_SetDate(aValue: TDateTime);
   function GetDayFromPoint(const Pt: TPoint): Integer;
   function GetDayRect(aDay: Word): TRect;
   procedure DrawFocusFrame(aPredDay: Word);
   procedure InvalidateDayArray;
   procedure Change;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure KeyDown(var Key: Word;
    Shift: TShiftState); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure NextDay;
   procedure PrevDay;
   procedure NextWeek;
   procedure PrevWeek;
   procedure NextMonth;
   procedure PrevMonth;
   procedure NextYear;
   procedure PrevYear;
   procedure RelMoveDate(nDays: Integer);
   constructor Create(AOwner: TComponent); override;
  public
   property StartOfWeek: TStDayType
    read f_StartOfWeek
    write f_StartOfWeek;
   property Weekends: TDaysOfWeek
    read f_Weekends
    write f_Weekends;
   property WeekendColor: TColor
    read f_WeekendColor
    write f_WeekendColor;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property OldDay: Integer
    read f_OldDay
    write f_OldDay;
   property Date: TDateTime
    read pm_GetDate
    write pm_SetDate;
 end;//TvtCustomCalendarPanel

 //#UC START# *5562DB5D0259ci*
 //#UC END# *5562DB5D0259ci*
 //#UC START# *5562DB5D0259cit*
 //#UC END# *5562DB5D0259cit*
 TvtCalendarPanel = {final} class(TvtCustomCalendarPanel)
 //#UC START# *5562DB5D0259publ*
  public
   property Weekends default [Sunday];
   property WeekendColor default clRed;
  published
   property Align;
   property BevelInner;
   property BevelOuter;
   property BevelWidth;
   property BorderWidth;
   property BorderStyle;

   property DragCursor;
   property DragMode;
   property Enabled;
   property Color;
   property Ctl3D;
   property Font;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;

   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnChange;
 //#UC END# *5562DB5D0259publ*
 end;//TvtCalendarPanel

implementation

uses
 l3ImplUses
 , vtDateEditRes
 , l3Units
 , l3String
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 BorderIndent = 4;
 SplitLineHeight = 8;

function TvtCustomCalendarPanel.pm_GetDate: TDateTime;
//#UC START# *55670FF801D4_556709D10061get_var*
//#UC END# *55670FF801D4_556709D10061get_var*
begin
//#UC START# *55670FF801D4_556709D10061get_impl*
 Result := EncodeDate(f_CurYear, f_CurMonth, f_CurDay);
//#UC END# *55670FF801D4_556709D10061get_impl*
end;//TvtCustomCalendarPanel.pm_GetDate

procedure TvtCustomCalendarPanel.pm_SetDate(aValue: TDateTime);
//#UC START# *55670FF801D4_556709D10061set_var*
var
 SaveYear,
 SaveMonth,
 SaveDay: Word;
//#UC END# *55670FF801D4_556709D10061set_var*
begin
//#UC START# *55670FF801D4_556709D10061set_impl*
 // Проверим что не выходим за границы диапазона
 DecodeDate(aValue, SaveYear, SaveMonth, SaveDay);
 if (SaveYear > MaxYear) or (SaveYear < MinYear) then
  Exit;

 SaveYear := f_CurYear;
 SaveMonth := f_CurMonth;
 SaveDay := f_CurDay;

 DecodeDate(aValue, f_CurYear, f_CurMonth, f_CurDay);
 f_MonthIndent := SysUtils.DayOfWeek(EncodeDate(f_CurYear, f_CurMonth, 1) - 2) mod 7;

 if HandleAllocated then
 begin
  if f_ForceRedraw or (SaveYear <> f_CurYear) or ( SaveMonth <> f_CurMonth) then
   InvalidateDayArray
  else
   DrawFocusFrame(SaveDay);
  f_ForceRedraw := False;
 end else
  f_ForceRedraw := False;

 Change;
//#UC END# *55670FF801D4_556709D10061set_impl*
end;//TvtCustomCalendarPanel.pm_SetDate

function TvtCustomCalendarPanel.GetDayFromPoint(const Pt: TPoint): Integer;
//#UC START# *55670EF101FF_556709D10061_var*
var
 nWeekCel: Integer;
 nDayCel: Integer;
 CelH, CelW: Integer;
 CelNum: Integer;
//#UC END# *55670EF101FF_556709D10061_var*
begin
//#UC START# *55670EF101FF_556709D10061_impl*
 Result := 0;
 CelH := (ClientRect.Bottom - ClientRect.Top - BorderIndent * 2 - SplitLineHeight) div 7;
 CelW := (ClientRect.Right - ClientRect.Left - BorderIndent * 2) div 7;
 with Pt do
 begin
  nWeekCel := (Y - ClientRect.Top - BorderIndent - SplitLineHeight - CelH) div CelH;
  if (nWeekCel < 0) or (nWeekCel > 6) then
   Exit;
  nDayCel := (X - ClientRect.Left - BorderIndent) div CelW + 1;
  if (nDayCel > 7) then
   Exit;
  CelNum := nWeekCel * 7 + nDayCel;
  Result := CelNum - f_MonthIndent;
  if (Result > DaysInMonth(f_CurMonth, f_CurYear)) or (Result < 1) then
  begin
   Result := 0;
   Exit;
  end;
 end;
//#UC END# *55670EF101FF_556709D10061_impl*
end;//TvtCustomCalendarPanel.GetDayFromPoint

function TvtCustomCalendarPanel.GetDayRect(aDay: Word): TRect;
//#UC START# *55670F3A02E0_556709D10061_var*
var
 nWeekCel: Byte;
 nDayCel: Byte;
 CelH, CelW: Integer;
//#UC END# *55670F3A02E0_556709D10061_var*
begin
//#UC START# *55670F3A02E0_556709D10061_impl*
 aDay := aDay + f_MonthIndent;
 nWeekCel := (aDay - 1) div 7;
 nDayCel := (aDay - 1) mod 7 + 1;

 CelH := (ClientRect.Bottom - ClientRect.Top - BorderIndent * 2 - SplitLineHeight) div 7;
 CelW := (ClientRect.Right - ClientRect.Left - BorderIndent * 2) div 7;

 Result.Top := ClientRect.Top + BorderIndent + CelH + SplitLineHeight + nWeekCel * CelH;
 Result.Bottom := Result.Top + CelH;
 Result.Left := ClientRect.Left + BorderIndent + CelW * (nDayCel - 1);
 Result.Right := Result.Left + CelW;
//#UC END# *55670F3A02E0_556709D10061_impl*
end;//TvtCustomCalendarPanel.GetDayRect

procedure TvtCustomCalendarPanel.DrawFocusFrame(aPredDay: Word);
//#UC START# *55670F7202CB_556709D10061_var*
var
 TempRect: TRect;
 DtStr: AnsiString;
 l_CN: Il3Canvas;
//#UC END# *55670F7202CB_556709D10061_var*
begin
//#UC START# *55670F7202CB_556709D10061_impl*
 l_CN := Canvas;
 l_CN.BeginPaint;
 try
  l_CN.DrawEnabled := true;
  if (aPredDay > 0) then
  begin
   TempRect := GetDayRect(aPredDay);

   DtStr := IntToStr(aPredDay);

   l_CN.BackColor := Color;
   l_CN.Canvas.Brush.Color := Color;

   Inc(TempRect.Right);
   Inc(TempRect.Bottom);
   l_CN.FillRect(Tl3SRect(TempRect));
   Dec(TempRect.Right);
   Dec(TempRect.Bottom);

   Inc(TempRect.Right);
   Inc(TempRect.Left);

   if TStDayType((aPredDay + f_MonthIndent) mod 7) in f_Weekends then
    l_CN.Font.ForeColor := f_WeekendColor
   else
    l_CN.Font.ForeColor := Font.Color;
   l_CN.DrawText(l3PCharLen(DtStr), TempRect, DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE);
  end;//aPredDay > 0

  TempRect := GetDayRect(f_CurDay);
  DtStr := IntToStr(f_CurDay);
  l_CN.BackColor := Color;
  l_CN.Canvas.Brush.Color := Color;
  l_CN.FillRect(Tl3SRect(TempRect));
  Inc(TempRect.Right);
  Inc(TempRect.Left);

  l_CN.Font.Style := [fsBold];
  if TStDayType((f_CurDay + f_MonthIndent) mod 7) in f_Weekends then
   l_CN.Font.ForeColor := f_WeekendColor
  else
   l_CN.Font.ForeColor := Font.Color;
  l_CN.DrawText(l3PCharLen(DtStr), TempRect, DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE);

  { Frame date with Shadow }
  //l_CN.Pen.Color := clGray;
  Dec(TempRect.Right);
  Dec(TempRect.Left);

  with l_CN do
  begin
   Canvas.Pen.Color := clWhite;
   Canvas.MoveTo(TempRect.Left, TempRect.Bottom);
   Canvas.LineTo(TempRect.Left, TempRect.Top );
   Canvas.LineTo(TempRect.Right, TempRect.Top );

   { Frame date with Highlight }
   //Canvas.Pen.Color := clWhite;
   Canvas.Pen.Color := clGray;
   Canvas.LineTo(TempRect.Right, TempRect.Bottom);
   Canvas.LineTo(TempRect.Left, TempRect.Bottom);

   { Restore Canvas settings}
   Canvas.Pen.Color := clBlack;
   Font.Style := [];
  end;//with l_CN
 finally
  l_CN.EndPaint;
 end;//try,,finally
//#UC END# *55670F7202CB_556709D10061_impl*
end;//TvtCustomCalendarPanel.DrawFocusFrame

procedure TvtCustomCalendarPanel.InvalidateDayArray;
//#UC START# *55670F9602CB_556709D10061_var*
//#UC END# *55670F9602CB_556709D10061_var*
begin
//#UC START# *55670F9602CB_556709D10061_impl*
 Invalidate;
//#UC END# *55670F9602CB_556709D10061_impl*
end;//TvtCustomCalendarPanel.InvalidateDayArray

procedure TvtCustomCalendarPanel.Change;
//#UC START# *55670FA502B8_556709D10061_var*
//#UC END# *55670FA502B8_556709D10061_var*
begin
//#UC START# *55670FA502B8_556709D10061_impl*
 if Assigned(f_OnChange) then
  f_OnChange(Self);
//#UC END# *55670FA502B8_556709D10061_impl*
end;//TvtCustomCalendarPanel.Change

procedure TvtCustomCalendarPanel.NextDay;
//#UC START# *55671071035C_556709D10061_var*
//#UC END# *55671071035C_556709D10061_var*
begin
//#UC START# *55671071035C_556709D10061_impl*
 Date := Date + 1;
//#UC END# *55671071035C_556709D10061_impl*
end;//TvtCustomCalendarPanel.NextDay

procedure TvtCustomCalendarPanel.PrevDay;
//#UC START# *5567107A01EF_556709D10061_var*
//#UC END# *5567107A01EF_556709D10061_var*
begin
//#UC START# *5567107A01EF_556709D10061_impl*
 Date := Date - 1;
//#UC END# *5567107A01EF_556709D10061_impl*
end;//TvtCustomCalendarPanel.PrevDay

procedure TvtCustomCalendarPanel.NextWeek;
//#UC START# *55671084000E_556709D10061_var*
//#UC END# *55671084000E_556709D10061_var*
begin
//#UC START# *55671084000E_556709D10061_impl*
 Date := Date + 7;
//#UC END# *55671084000E_556709D10061_impl*
end;//TvtCustomCalendarPanel.NextWeek

procedure TvtCustomCalendarPanel.PrevWeek;
//#UC START# *5567108F020C_556709D10061_var*
//#UC END# *5567108F020C_556709D10061_var*
begin
//#UC START# *5567108F020C_556709D10061_impl*
 Date := Date - 7;
//#UC END# *5567108F020C_556709D10061_impl*
end;//TvtCustomCalendarPanel.PrevWeek

procedure TvtCustomCalendarPanel.NextMonth;
//#UC START# *5567109A01A1_556709D10061_var*
//#UC END# *5567109A01A1_556709D10061_var*
begin
//#UC START# *5567109A01A1_556709D10061_impl*
 f_ForceRedraw := True;
 if f_CurMonth < 12 then
  Inc(f_CurMonth)
 else
 begin
  if f_CurYear = MaxYear then
   Exit;
  f_CurMonth := 1;
  Inc(f_CurYear);
 end;
 if DaysInMonth(f_CurMonth, f_CurYear) < f_CurDay then
  f_CurDay := DaysInMonth(f_CurMonth, f_CurYear);
 Date := Date; {Activate Refresh etc}
//#UC END# *5567109A01A1_556709D10061_impl*
end;//TvtCustomCalendarPanel.NextMonth

procedure TvtCustomCalendarPanel.PrevMonth;
//#UC START# *556710A500BA_556709D10061_var*
//#UC END# *556710A500BA_556709D10061_var*
begin
//#UC START# *556710A500BA_556709D10061_impl*
 f_ForceRedraw := True;
 if f_CurMonth > 1 then
  Dec(f_CurMonth)
 else
 begin
  if f_CurYear = MinYear then
   Exit;
  f_CurMonth := 12;
  Dec(f_CurYear);
 end;
 if DaysInMonth(f_CurMonth, f_CurYear) < f_CurDay then
  f_CurDay := DaysInMonth(f_CurMonth, f_CurYear);
 Date := Date; {Activate Refresh etc}
//#UC END# *556710A500BA_556709D10061_impl*
end;//TvtCustomCalendarPanel.PrevMonth

procedure TvtCustomCalendarPanel.NextYear;
//#UC START# *556710AF02F4_556709D10061_var*
//#UC END# *556710AF02F4_556709D10061_var*
begin
//#UC START# *556710AF02F4_556709D10061_impl*
 if Succ(f_CurYear) > MaxYear then
  Exit;
 f_ForceRedraw := True;
 Inc(f_CurYear);
 if DaysInMonth(f_CurMonth, f_CurYear) < f_CurDay then
  f_CurDay := DaysInMonth(f_CurMonth, f_CurYear);
 Date := Date; {Activate Refresh etc}
//#UC END# *556710AF02F4_556709D10061_impl*
end;//TvtCustomCalendarPanel.NextYear

procedure TvtCustomCalendarPanel.PrevYear;
//#UC START# *556710BA0108_556709D10061_var*
//#UC END# *556710BA0108_556709D10061_var*
begin
//#UC START# *556710BA0108_556709D10061_impl*
 if Pred(f_CurYear) < MinYear then
  Exit;
 f_ForceRedraw := True;
 Dec(f_CurYear);
 if DaysInMonth(f_CurMonth, f_CurYear) < f_CurDay then
  f_CurDay := DaysInMonth(f_CurMonth, f_CurYear);
 Date := Date; {Activate Refresh etc}
//#UC END# *556710BA0108_556709D10061_impl*
end;//TvtCustomCalendarPanel.PrevYear

procedure TvtCustomCalendarPanel.RelMoveDate(nDays: Integer);
//#UC START# *556710D300D7_556709D10061_var*
//#UC END# *556710D300D7_556709D10061_var*
begin
//#UC START# *556710D300D7_556709D10061_impl*
 Date := Date + nDays;
//#UC END# *556710D300D7_556709D10061_impl*
end;//TvtCustomCalendarPanel.RelMoveDate

procedure TvtCustomCalendarPanel.WMGetDlgCode(var Msg: TWMGetDlgCode);
//#UC START# *5567115E02E0_556709D10061_var*
//#UC END# *5567115E02E0_556709D10061_var*
begin
//#UC START# *5567115E02E0_556709D10061_impl*
 inherited;
 Msg.Result := Msg.Result {or DLGC_WANTCHARS} or DLGC_WANTARROWS;
//#UC END# *5567115E02E0_556709D10061_impl*
end;//TvtCustomCalendarPanel.WMGetDlgCode

procedure TvtCustomCalendarPanel.WMLButtonDown(var Message: TWMLButtonDown);
//#UC START# *5567117301B0_556709D10061_var*
var
 NewDay, SaveDay : Integer;
//#UC END# *5567117301B0_556709D10061_var*
begin
//#UC START# *5567117301B0_556709D10061_impl*
 inherited;
 NewDay := GetDayFromPoint(SmallPointToPoint(Message.Pos));
 f_MouseDown := NewDay > 0;
 if f_MouseDown then
 begin
  OldDay := f_CurDay;
  if NewDay <> f_CurDay then
  begin
   SaveDay := f_CurDay;
   RelMoveDate(NewDay - f_CurDay);
   DrawFocusFrame(SaveDay);
  end;
 end;
//#UC END# *5567117301B0_556709D10061_impl*
end;//TvtCustomCalendarPanel.WMLButtonDown

procedure TvtCustomCalendarPanel.WMLButtonUp(var Message: TWMLButtonUp);
//#UC START# *55671181020A_556709D10061_var*
//#UC END# *55671181020A_556709D10061_var*
begin
//#UC START# *55671181020A_556709D10061_impl*
 if f_MouseDown then
  inherited;
 f_MouseDown := False;
//#UC END# *55671181020A_556709D10061_impl*
end;//TvtCustomCalendarPanel.WMLButtonUp

procedure TvtCustomCalendarPanel.WMMouseMove(var Message: TWMMouseMove);
//#UC START# *5567118E02EF_556709D10061_var*
var
 NewDay, SaveDay: Integer;
//#UC END# *5567118E02EF_556709D10061_var*
begin
//#UC START# *5567118E02EF_556709D10061_impl*
 inherited;
 if f_MouseDown then
 begin
  NewDay := GetDayFromPoint(SmallPointToPoint(Message.Pos));
  if (NewDay > 0) and (NewDay <> f_CurDay) then
   begin
    SaveDay := f_CurDay;
    RelMoveDate(NewDay - f_CurDay);
    DrawFocusFrame(SaveDay);
   end;
 end;
//#UC END# *5567118E02EF_556709D10061_impl*
end;//TvtCustomCalendarPanel.WMMouseMove

procedure TvtCustomCalendarPanel.WMShowWindow(var Message: TWMShowWindow);
//#UC START# *5567119C03D0_556709D10061_var*
//#UC END# *5567119C03D0_556709D10061_var*
begin
//#UC START# *5567119C03D0_556709D10061_impl*
 f_MouseDown := False;
//#UC END# *5567119C03D0_556709D10061_impl*
end;//TvtCustomCalendarPanel.WMShowWindow

constructor TvtCustomCalendarPanel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_556709D10061_var*
//#UC END# *47D1602000C6_556709D10061_var*
begin
//#UC START# *47D1602000C6_556709D10061_impl*
 inherited Create(AOwner);
 ControlStyle := ControlStyle + [csClickEvents, csOpaque] -
                                [csAcceptsControls, csCaptureMouse, csSetCaption];
 Date := Now;
 Change;
 f_Weekends := [Sunday];
 f_WeekendColor := clRed;
//#UC END# *47D1602000C6_556709D10061_impl*
end;//TvtCustomCalendarPanel.Create

procedure TvtCustomCalendarPanel.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_556709D10061_var*
var
 CelH, CelW: Integer;

 procedure DrawDaysHeader;
 var
  I: Byte;
  TempRect: TRect;
 begin//DrawDaysHeader
  with CN do
  begin
   BackColor := Color;
   Brush.Color := Color;
   Brush.Style := bsSolid;
   TempRect := ClientRect;
   InflateRect(TempRect, -1, -1);
   FillRect(Tl3SRect(TempRect));
   Brush.Style := bsClear;
  end;//with CN
  CelH := (ClientRect.Bottom - ClientRect.Top - BorderIndent * 2 - SplitLineHeight) div 7;
  CelW := (ClientRect.Right - ClientRect.Left - BorderIndent * 2) div 7;

  TempRect.Top := ClientRect.Top + BorderIndent;
  TempRect.Bottom := TempRect.Top + CelH;
  TempRect.Left := ClientRect.Left + BorderIndent;
  TempRect.Right := TempRect.Left + CelW;

  for I := 1 to 7 do
  begin
   if TStDayType(I mod 7) in f_Weekends then
    CN.Font.ForeColor := f_WeekendColor
   else
    CN.Font.ForeColor := Font.Color;

   CN.DrawText(l3PCharLen(vtWeekDaysCaptions(TStDayType(I mod 7)).AsStr), TempRect, DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE);
   TempRect.Left := TempRect.Right;
   Inc(TempRect.Right, CelW);
  end;//for I

  { Draw line below days }
  with CN do
  begin
   TempRect.Top := TempRect.Bottom + SplitLineHeight div 2 - 1;
   TempRect.Bottom := TempRect.Top + 2;
   TempRect.Left := ClientRect.Left + BorderIndent;
   TempRect.Right := ClientRect.Right - BorderIndent;

   with Canvas do
   begin
    Pen.Color := clGray;
    MoveTo(TempRect.Left , TempRect.Top);
    LineTo(TempRect.Right, TempRect.Top );
    Pen.Color := clWhite;
    MoveTo(TempRect.Left,  TempRect.Top + 1);
    LineTo(TempRect.Right, TempRect.Top + 1);
   end;//with Canvas
  end;
 end;//DrawDaysHeader

 procedure DrawDates;
 var
  nWeek: Integer;
  nDay: Integer;
  DtStr: AnsiString;
  DT: Integer;
  DM: Byte;
  TempRect: Trect;
 begin//DrawDates
  TempRect.Top := ClientRect.Top + BorderIndent + CelH + SplitLineHeight;
  TempRect.Bottom := TempRect.Top + CelH;

  { Cycle through the weeks }
  DM := DaysInMonth(f_CurMonth, f_CurYear);
  for nWeek := 0 to 5 do
  begin
    { Cycle through the days }
   TempRect.Left := ClientRect.Left + BorderIndent+1;
   TempRect.Right := TempRect.Left + CelW;

   for nDay := 1 to 7 do
   begin
    Dt := nWeek * 7 + nDay - f_MonthIndent;
    if (Dt <= 0) or (Dt > DM) or (Dt = f_CurDay) then
     DtStr := #0
    else
    begin
     if TStDayType(nDay mod 7) in f_Weekends then
      CN.Font.ForeColor := f_WeekendColor
     else
      CN.Font.ForeColor := Font.Color;
     DtStr := IntToStr(Dt);
     CN.DrawText(l3PCharLen(DtStr), TempRect, DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE);
    end;//Dt <= 0
    TempRect.Left := TempRect.Right;
    Inc(TempRect.Right, CelW);
   end;//for nDay
   TempRect.Top := TempRect.Bottom;
   Inc(TempRect.Bottom, CelH);
  end;//for nWeek
 end;//DrawDates
//#UC END# *48C6C044025E_556709D10061_var*
begin
//#UC START# *48C6C044025E_556709D10061_impl*
 inherited;
 CN.Font.AssignFont(Font);
 DrawDaysHeader;
 DrawDates;
 DrawFocusFrame(0);
//#UC END# *48C6C044025E_556709D10061_impl*
end;//TvtCustomCalendarPanel.Paint

{$If NOT Defined(NoVCL)}
procedure TvtCustomCalendarPanel.KeyDown(var Key: Word;
 Shift: TShiftState);
//#UC START# *554CABC100AC_556709D10061_var*
//#UC END# *554CABC100AC_556709D10061_var*
begin
//#UC START# *554CABC100AC_556709D10061_impl*
 case Key {CharCode} of
  VK_LEFT: PrevDay;
  VK_RIGHT: NextDay;
  VK_UP: PrevWeek;
  VK_DOWN: NextWeek;
  VK_PRIOR: PrevMonth;
  VK_NEXT: NextMonth;
  VK_HOME: NextYear;
  VK_END: PrevYear;
 else
  Exit;
 end;
 Key := 0;
//#UC END# *554CABC100AC_556709D10061_impl*
end;//TvtCustomCalendarPanel.KeyDown
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *5562DB5D0259impl*
//#UC END# *5562DB5D0259impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomCalendarPanel);
 {* Регистрация TvtCustomCalendarPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCalendarPanel);
 {* Регистрация TvtCalendarPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
