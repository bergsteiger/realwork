unit ShedulPanel;
{ Библиотека "Scheduler Visual Object" }
{ Автор: Жучков Антон                  }
{ Модуль: ShedulPanel                  }
{ Начат: 03.12.2003                    }
{ $Id: ShedulPanel.pas,v 1.43 2014/02/17 16:25:58 lulin Exp $ }

// $Log: ShedulPanel.pas,v $
// Revision 1.43  2014/02/17 16:25:58  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.42  2014/02/14 16:27:10  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.41  2014/02/14 15:33:40  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.40  2008/02/27 15:50:48  narry
// - не компилировалось
//
// Revision 1.39  2008/02/06 09:27:40  narry
// - не компилировалось
//
// Revision 1.38  2008/02/04 12:24:53  narry
// - не компилировалось
//
// Revision 1.37  2006/12/20 14:25:01  narry
// - Не компилировалось
//
// Revision 1.36  2006/12/15 11:30:43  lulin
// - добавлена картинка со счетчиком ссылок.
//
// Revision 1.35  2004/12/23 11:28:35  lulin
// - rename unit: vtDateSt -> l3DateSt.
//
// Revision 1.34  2004/12/23 08:40:36  lulin
// - вычищен ненужный модуль.
//
// Revision 1.33  2004/06/02 16:25:00  narry
// - update: изменения в иерархии листов
//
// Revision 1.32  2004/05/26 09:14:58  narry
// - add: добавлена процедура регистрации компонента в палитре
//
// Revision 1.31  2003/12/15 13:12:55  fireton
// - update: компонент выводит хинт с кратким текстом событий
//
// Revision 1.30  2003/12/15 10:14:28  fireton
// - update: при избытке событий в день рисуются точечки, если треугольники не помещаются
//
// Revision 1.29  2003/12/11 15:06:55  fireton
// - minor visual enhancements
//
// Revision 1.28  2003/12/11 14:49:11  fireton
// - bugfix: скорректировано перемещение мыши внутри календаря при нажатой кнопке
//
// Revision 1.27  2003/12/11 13:53:31  fireton
// - bugfix: при выходе из контрола кнопка мыши считалась нажатой навсегда
//
// Revision 1.26  2003/12/11 13:19:35  fireton
// - cleanup: при создании не дергаются exceptions
//
// Revision 1.25  2003/12/11 12:44:13  fireton
// - minor visual updates
//
// Revision 1.24  2003/12/11 12:27:07  fireton
// - bugfix: нормальный ресайз
// - upd: стрелочки уменьшены
// - upd: рамочка (сегодня) добавлена на нижнюю панель
// - other minor updates
//
// Revision 1.23  2003/12/11 10:24:39  fireton
// - bugfix: числа прижаты :)
//
// Revision 1.22  2003/12/11 10:18:18  fireton
// - bugfix: мелкие проблемы отрисовки
//
// Revision 1.21  2003/12/11 10:10:20  narry
// - change: изменение порядка сортировки заданий - первым отображается самое раннее задание, а не самое позднее
//
// Revision 1.20  2003/12/11 09:31:16  fireton
// - bug fix: Next/PrevMonth теперь вызывают прорисовку после, а не перед обновлением списка
// - add: год можно выбирать из выпадающего списка
//
// Revision 1.19  2003/12/10 15:10:40  fireton
// add: можно выбирать месяц из списка
//
// Revision 1.18  2003/12/09 15:46:11  fireton
// - bugfix: TShedulerCalendar добавлено свойство Date, пропущенное ранее
//
// Revision 1.17  2003/12/09 14:06:03  fireton
// - bugfix: исправлена внесенная ошибка при переходе на след./пред. месяц
//
// Revision 1.16  2003/12/09 13:45:02  fireton
// - update: новый объект TSchedulerCalendar - расписание с навигацией
//
// Revision 1.15  2003/12/09 09:26:40  narry
// - update: задания с одним цветом могут повторяться в один день
//
// Revision 1.14  2003/12/09 07:53:54  fireton
// - bug fix: исправлено дерганье при прорисовке
//
// Revision 1.13  2003/12/08 15:04:34  fireton
// - upd: добавлен переход на предыдущий/следующий месяц при клике на дату
//
// Revision 1.12  2003/12/08 13:46:29  fireton
// - upd: отрисовка "сегодня" + дней предыдущего/следующего месяцев
//
// Revision 1.11  2003/12/05 14:25:09  narry
// - cleanup: удален тип события TDateEvent
//
// Revision 1.10  2003/12/05 14:08:27  fireton
// - bug fix: коррекция прорисовки фона -фон по умолчанию ставится в белый
//
// Revision 1.9  2003/12/05 13:28:50  fireton
// - bug fix: коррекция прорисовки фона цветом родителя
//
// Revision 1.8  2003/12/05 13:18:32  fireton
// - bug fix: коррекция прорисовки под манифестом XP
//
// Revision 1.7  2003/12/04 14:55:39  fireton
// - update: правильный ресайз, поправлена отрисовка
//
// Revision 1.6  2003/12/04 11:24:07  fireton
// - update: работает выделение даты. OnMonthChanged вызывается при начальной инициализации даты
//
// Revision 1.5  2003/12/04 11:01:39  narry
// - change: замена TComponent на TObject в обработчике события OnDblClick
//
// Revision 1.4  2003/12/04 10:00:04  fireton
// - update: текущая редакция
//
// Revision 1.3  2003/12/04 09:52:12  narry
// - update: изменение класса TDateTypeObj
//
// Revision 1.2  2003/12/03 16:43:16  narry
// - update: переопределение конструктора Create
//
// Revision 1.1  2003/12/03 16:35:32  fireton
// - new: новый визуальный объект: расписание
//

interface

uses
  SysUtils, Windows, Messages,
  Classes, Graphics, Controls,
  Forms, Menus, ExtCtrls, DateUtils,
  l3Types, l3Date, l3Base, l3ObjectRefList,
  l3DateSt, StdCtrls;

type
  TDateTypeObj = class(Tl3Base)
  private
   fDate: TDateTime;
   fColor: TColor;
   fDescript: String;
  public
   constructor Create(aDate: TDateTime; aColor: Integer; aDescript: String); 
       reintroduce;
   function OCompare(anObject: Tl3Base): Integer; override;
     {-}
   procedure Assign(P: TDateTypeObj); //override;
  public
   property Day: TDateTime
    read FDate;
   property EventColor: TColor
    read fColor;
   property Descript: String
    read FDescript;
  end;

 TCustomSchedulPanel = class(TCustomPanel)
 private
    CurYear,
    CurMonth,
    CurDay       : Word;
    FOnChange: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnMonthChanged: TNotifyEvent;
    FSchedule: Tl3ObjectRefList;
    FStartOfWeek  : TStDayType;
    FWeekendColor : TColor;
    FWeekends     : TDaysOfWeek;
    lForceRedraw : Boolean;
    lMonthIndent : Byte;
    MouseDown: Boolean;
    NewDay: Integer;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure RepaintCalendar;
    procedure SetSchedule(const Value: Tl3ObjectRefList);
    function GetDayHint(Day: Integer): string;
 protected
    procedure Change;
    procedure ChangeMonth;
    function GetDayFromPoint(Pt : TPoint): Integer;
    Procedure InvalidateDayArray;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMLButtonDblClk(var Msg: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
 public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    Function    GetDate : TDateTime;
    procedure NextDay;
    procedure NextMonth;
    procedure NextWeek;
    procedure NextYear;
    procedure PrevDay;
    procedure PrevMonth;
    procedure PrevWeek;
    procedure PrevYear;
    procedure RelMoveDate(nDays : Integer);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetDate(DT : TDateTime);
    Property Date : TDateTime Read GetDate Write SetDate;
    property OnChange: TNotifyEvent
     read FOnChange
     write FOnChange;
    property OnDblClick: TNotifyEvent
     read FOnDblClick
     write FOnDblClick;
    property OnMonthChanged: TNotifyEvent
     read FOnMonthChanged
     write FOnMonthChanged;
    property Schedule: Tl3ObjectRefList read FSchedule write SetSchedule;
    Property StartOfWeek  : TStDayType
     Read FStartOfWeek
     Write FStartOfWeek;
    Property WeekendColor : TColor
     Read FWeekendColor
     Write FWeekendColor
     default clRed;
    Property Weekends     : TDaysOfWeek
     Read FWeekends
     Write FWeekends
     default [Sunday];
 end;

 TSchedulPanel = class(TCustomSchedulPanel)
  Published
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
    {property OnResize;}
    property OnChange;
  end;

  TSchedulerCalendar = class(TCustomPanel)
  private
   FBottomPanel: TPanel;
   FNavPanel: TPanel;
   FSchedul: TCustomSchedulPanel;
   FTodayLabel: TLabel;
   FOnMonthChanged: TNotifyEvent;
   FTitleLabel: TLabel;
   FMonthMenu: TPopupMenu;
   FYearMenu: TPopupMenu;
   function GetDate: TDateTime;
   function GetOnChange: TNotifyEvent;
   function GetOnDblClick: TNotifyEvent;
   function GetSchedule: Tl3ObjectRefList;
   procedure SetDate(Value: TDateTime);
   procedure SetOnChange(Value: TNotifyEvent);
   procedure SetOnDblClick(Value: TNotifyEvent);
   procedure SetSchedule(Value: Tl3ObjectRefList);
   procedure TodayLabelClick(Sender: Tobject);
   procedure PrevMonthClick(Sender: TObject);
   procedure NextMonthClick(Sender: TObject);
   procedure SchMonthChanged(Sender: TObject);
   procedure MonthMenuSelect(Sender: TObject);
   procedure MonthClick(Sender: TObject);
   procedure YearMenuSelect(Sender: TObject);
   procedure YearChooseSelect(Sender: TObject);
  protected
   procedure WMPaint(var Message: TMessage); message WM_PAINT;
  public
   constructor Create(AOwner: TComponent); override;
   procedure RefreshMonth;
   procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
   procedure Paint; override;
   property Schedule: Tl3ObjectRefList read GetSchedule write SetSchedule;
  published
   property Align;
   property Color;
   property Ctl3D;
   property Date: TDateTime read GetDate write SetDate;
   property DragCursor;
   property DragMode;
   property Enabled;
   property Font;
   property OnChange: TNotifyEvent read GetOnChange write SetOnChange;
   property OnDblClick: TNotifyEvent read GetOnDblClick write SetOnDblClick;
   property OnMonthChanged: TNotifyEvent read FOnMonthChanged write
       FOnMonthChanged;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
  end;

procedure Register;

implementation

uses 
  Math, Buttons, Dialogs,
  l3Bitmap
  ;

{$R SCHEDULER.RES}


procedure Register;
begin
 RegisterComponents('VoBa', [TSchedulerCalendar]);
end;

{CalPop}

 const
   BorderIndent = 0;

 constructor TCustomSchedulPanel.Create(AOwner: TComponent);
  begin
   Inherited Create(AOwner);
   ControlStyle := ControlStyle + [csClickEvents,csOpaque,csCaptureMouse] -
                                  [csFramed, csAcceptsControls,csSetCaption];
   //BorderStyle := bsSingle;
   BevelInner := bvNone;
   BevelOuter := bvRaised;                               
   {Caption:='';}
   DoubleBuffered := True;
   CurYear := 1900;
   CurMonth := 1;
   CurDay := 1;
   FWeekends:=[Sunday];
   FWeekendColor:=clRed;
   FSchedule := Tl3ObjectRefList.MakeSorted(l3_dupAccept);
   Width := 196;
   Height := 189;
   NewDay := 0;
   MouseDown := False;
   Color := clWhite;
   SetBounds(Left, Top, Width, Height);
  end;

destructor TCustomSchedulPanel.Destroy;
begin
 FSchedule.Free;
 inherited;
end;

 procedure TCustomSchedulPanel.Change;
  begin
   if Assigned(FOnChange) then FOnChange(Self);
 end;

procedure TCustomSchedulPanel.ChangeMonth;
begin
 if Assigned(FOnMonthChanged) then FOnMonthChanged(Self);
end;

procedure TCustomSchedulPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  MouseDown := False;
  NewDay := 0;
  Refresh;
end;

function TCustomSchedulPanel.GetDate : TDateTime;
begin
 Result:=EncodeDate(CurYear,CurMonth,CurDay);
end;

function TCustomSchedulPanel.GetDayFromPoint(Pt : TPoint): Integer;
var
 nWeekCel    : Integer;
 nDayCel     : Integer;
 CelH, CelW  : Integer;
 CelNum      : Integer;
 HSize: Integer;
 HeaderH: Integer;
begin
 Result:=-256;
 HSize := Canvas.TextHeight('B');
 HeaderH := HSize + 8;
 CelH := (Height-HeaderH - 1) div 6;
 CelW :=(Width - 1) div 7;
 with Pt do
  begin
   if (Y < HeaderH) or (Y > Height - 2) then Exit;
   nWeekCel:=(Y - HeaderH) div CelH;
   If (nWeekCel < 0) or (nWeekCel > 6) then Exit;
   nDayCel:=(X div CelW) + 1;
   if (nDayCel > 7) then Exit;
   CelNum := nWeekCel * 7 + nDayCel;
   Result:=CelNum - lMonthIndent;
  end;
end;

 Procedure TCustomSchedulPanel.InvalidateDayArray;
  begin
   Invalidate;
  end;

procedure TCustomSchedulPanel.KeyDown(var Key: Word; Shift: TShiftState);
{procedure TCustomSchedulPanel.WMKeyDown(var Message: TWMKeyDown);}
 begin
  {Inherited;}
  {With Message do}

   Case Key {CharCode} of
    VK_Left  : PrevDay;
    VK_Right : NextDay;
    VK_Up    : PrevWeek;
    VK_Down  : NextWeek;
    VK_Prior : PrevMonth;
    Vk_Next  : NextMonth;
    VK_Home  : NextYear;
    VK_End   : PrevYear;
    else Exit;
   end;
   Key := 0;
 end;

procedure TCustomSchedulPanel.NextDay;
 begin
  Date:=Date+1;
 end;

procedure TCustomSchedulPanel.NextMonth;
 begin
  lForceRedraw:=True;
  if CurMonth < 12
   then Inc(CurMonth)
   else
    begin
     CurMonth := 1;
     Inc(CurYear);
    end;
  If DaysInMonth(CurMonth, CurYear) < CurDay
   then CurDay:=DaysInMonth(CurMonth, CurYear);
  ChangeMonth;
  RepaintCalendar;
 end;

procedure TCustomSchedulPanel.NextWeek;
 begin
  Date:=Date+7;
 end;

procedure TCustomSchedulPanel.NextYear;
 begin
  lForceRedraw:=True;
  Inc(CurYear);
  If DaysInMonth(CurMonth, CurYear) < CurDay
   then CurDay:=DaysInMonth(CurMonth, CurYear);
  ChangeMonth;
  RepaintCalendar;
 end;

 procedure TCustomSchedulPanel.Paint;
  var
   TempRect: Trect;
   CelH, CelW  : Integer;
   HeaderH : Integer;
   TmpBM: TBitmap;

  procedure DrawDaysHeader;
   var
    I: Byte;
    HSize: Integer;
   begin
    TempRect := ClientRect;
    Canvas.Brush.Color := Color;
    Canvas.Brush.Style := bsSolid;
    Canvas.Rectangle(TempRect);
    Canvas.Brush.Style := bsClear;

    HSize := Canvas.TextHeight('B');
    HeaderH := HSize + 8;
    CelH :=(Height - HeaderH - 1) div 6;
    CelW :=(Width - 1) div 7;

    TempRect.Top    := 0;
    TempRect.Bottom := HeaderH;
    TempRect.Left   := 0;
    TempRect.Right  := CelW;

    { Cycle through the days }
    Canvas.Font.Style := [fsBold];
    For I:= 1 to 7 do
      begin
       If TStDayType(I mod 7) in FWeekends
        then Canvas.Font.Color := FWeekendColor
        else Canvas.Font.Color := Font.Color;

       DrawText( Canvas.Handle, @DayShortString[TStDayType(I mod 7)][1], 2, TempRect,
                ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE) );
       TempRect.Left := TempRect.Right;
       Inc(TempRect.Right,CelW);
      end;

       { Draw line below days }

    // draw grid
    with Canvas do
    begin
     Pen.Color := clGray;
     for I := 0 to 6 do
     begin
       MoveTo(ClientRect.Left + BorderIndent + CelW*I, ClientRect.Top + BorderIndent);
       LineTo(ClientRect.Left + BorderIndent + CelW*I, ClientRect.Bottom - BorderIndent);
     end;
     for I := 0 to 5 do
     begin
       MoveTo(ClientRect.Left + BorderIndent, ClientRect.Top + BorderIndent + HeaderH +  CelH*I);
       LineTo(ClientRect.Right - BorderIndent, ClientRect.Top + BorderIndent + HeaderH + CelH*I);
     end;
    end;
   end;

  procedure DrawTriangle(Point: TPoint; aColor: Integer);
  var
   Triangle: array[1..3] of TPoint;
  begin
   with TmpBM.Canvas do
   begin
    Triangle[1] := Point;
    Triangle[2] := Triangle[1];
    Triangle[3] := Triangle[1];
    Dec(Triangle[2].Y, 10);
    Dec(Triangle[3].X, 10);
    Pen.Color := clBlack;
    Brush.Color := aColor;
    Polygon(Triangle);
    Brush.Style := bsClear;
   end;
  end;

  procedure DrawDates;
  var
   CurTri: Integer;
   TextFlags: Cardinal;
   nWeek, nDay: Integer;
   DtStr  : String[3];
   DT     : Integer;
   DM     : Byte;
   NumRect: TRect; // область для цифры
   NumSize: TSize;
   I: Integer;
   TmpDate: TDateTime;
   TrCount: Integer; // счетчик треугольничков
   TmpPoint: TPoint;
   R1,R2: TRect;
   CY,CM,CD: Word;
   Col2: TColor;
   FocusDay: Integer;
   MaxTriangles: Integer;
  begin
    begin
     TempRect.Top := {ClientRect.Top +} BorderIndent + HeaderH;
     TempRect.Bottom := TempRect.Top+CelH;
     if MouseDown then
      FocusDay := NewDay
     else
      FocusDay := CurDay;
     { Cycle through the weeks }
     DM:=DaysInMonth(CurMonth, CurYear);
     DecodeDate(Now, CY, CM, CD);
     if (CY <> CurYear) or (CM <> CurMonth) then
      CD := 1000; // месяц не текущий - "сегодня" отображать не надо
     For nWeek := 0 to 5 do
      begin
       { Cycle through the days }
       TempRect.Left := ClientRect.Left + BorderIndent+1;
       TempRect.Right := TempRect.Left+CelW;
       Canvas.Font.Style := Font.Style;
       For nDay := 1 to 7 do
       begin
        Dt := nWeek*7 + nDay - lMonthIndent;

        if (Dt <= 0) or (Dt > DM) then // это клеточка с днями предыдущего или следующего месяца
        begin
         Canvas.Font.Color := clSilver;
         if Dt < 1 then
          DtStr := IntToStr(DateUtils.DaysInMonth(IncMonth(Date, -1)) + Dt)+#0;
         if Dt > DM then
          DtStr := IntToStr(Dt-DM)+#0;
        end
        else
        begin
         DtStr := IntToStr(Dt)+#0;
         if DT = FocusDay then
          Canvas.Font.Color := clHighlightText
         else
         begin
          if TStDayType(nDay mod 7) in FWeekends then
           Canvas.Font.Color := FWeekendColor
          else
           Canvas.Font.Color := Font.Color;
         end;
        end;

        if Dt = CD then // если найдено "сегодня"
        begin
         Col2 := Canvas.Pen.Color;
         R1 := TempRect;
         Dec(R1.Left);
         Inc(R1.Bottom);
         Canvas.Pen.Color := clRed;
         Canvas.Rectangle(R1);
         Canvas.Pen.Color := Col2;
        end;
        if DT = FocusDay then
        begin
         R1 := TempRect;
         InflateRect(R1, -1, -1);
         Dec(R1.Left);
         Inc(R1.Bottom);
         Canvas.Brush.Color := clHighlight;
         Canvas.FillRect(R1);
         Canvas.Brush.Style := bsClear;
        end;
        NumRect := TempRect;
        InflateRect(NumRect, -1, -1);
        NumSize := Canvas.TextExtent(DtStr);
        NumRect.Right := NumRect.Left + NumSize.cx+4;
        NumRect.Bottom := NumRect.Top + NumSize.cy+4;
        TextFlags := {DT_CENTER or DT_VCENTER or} DT_TOP or DT_SINGLELINE;
        DrawText(Canvas.Handle, @DtStr[1], Length(DtStr)-1,
               NumRect, TextFlags);
        if (Dt in [1..DM]) then // треугольнички долько для текущего месяца
        begin
         TmpDate := EncodeDate(CurYear, CurMonth, Dt);
         TrCount := 0;
         for I := 0 to Schedule.hi do
          if CompareDate(TDateTypeObj(Schedule.Items[I]).fDate, TmpDate) = 0 then
           Inc(TrCount);
         if TrCount > 0 then
         begin
          TmpBM := Tl3Bitmap.Create;
          try
           TmpBM.Height := CelH - 2;
           TmpBM.Width  := CelW - 5;
           TmpBM.Canvas.FloodFill(1,1,clBlack, fsSurface);
           TmpPoint.X := CelW - 6;
           TmpPoint.Y := CelH - 3;
           TmpPoint.X := TmpPoint.X - (TrCount-1)*4;
           R1.Left := 0;
           R1.Top := 0;
           R1.Right := TmpBM.Width;
           R1.Bottom := TmpBM.Height;
           TmpBM.Canvas.Brush.Color := clWhite;
           TmpBM.Canvas.FillRect(R1);
           MaxTriangles := (TmpBM.Width - 10) div 4 + 1;
           CurTri := 0;

           for I := 0 to Schedule.Count-1 do
            if CompareDate(TDateTypeObj(Schedule.Items[I]).fDate, TmpDate) = 0 then
            begin
             Inc(CurTri);
             if CurTri > TrCount - MaxTriangles then
              DrawTriangle(TmpPoint, TDateTypeObj(Schedule.Items[I]).fColor);
             Inc(TmpPoint.X, 4);
            end;

           if TrCount > MaxTriangles then // рисуем точечки...
            for I := 0 to 2 do
             TmpBM.Canvas.Pixels[I*2+1,TmpBM.Height-10] := clBlack;

           R2 := R1;
           OffsetRect(R2, TempRect.Left+2, TempRect.Top);
           Canvas.BrushCopy(R2, TmpBM, R1, clWhite);
          finally
           TmpBM.Free;
          end;
         end;
        end;
        TempRect.Left := TempRect.Right;
        Inc(TempRect.Right,CelW);
       end;
       TempRect.Top := TempRect.Bottom;
       Inc(TempRect.Bottom,CelH);
     end;
    end;
  end;

  begin
   Inherited Paint;
   lMonthIndent := SysUtils.DayOfWeek(EncodeDate(CurYear,CurMonth,1)-2) mod 7;
   //Canvas.Font := Font;
   DrawDaysHeader;
   DrawDates;
  end;

procedure TCustomSchedulPanel.PrevDay;
 begin
  Date:=Date-1;
 end;

procedure TCustomSchedulPanel.PrevMonth;
 begin
  lForceRedraw:=True;
  if CurMonth > 1
   then Dec(CurMonth)
   else
    begin
     CurMonth := 12;
     Dec(CurYear);
    end;
  If DaysInMonth(CurMonth, CurYear) < CurDay
   then CurDay:=DaysInMonth(CurMonth,CurYear);
  ChangeMonth;
  RepaintCalendar;
 end;

procedure TCustomSchedulPanel.PrevWeek;
 begin
  Date:=Date-7;
 end;

procedure TCustomSchedulPanel.PrevYear;
 begin
  lForceRedraw:=True;
  Dec(CurYear);
  If DaysInMonth(CurMonth, CurYear) < CurDay
   then CurDay:=DaysInMonth(CurMonth, CurYear);
  ChangeMonth;
  RepaintCalendar;
 end;

procedure TCustomSchedulPanel.RelMoveDate(nDays : Integer);
 begin
  Date:=Date+nDays;
 end;

procedure TCustomSchedulPanel.RepaintCalendar;
begin
 Refresh;
end;

procedure TCustomSchedulPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
 lWidth, lHeight, CalPart : Integer;
 HeaderH : Integer;
 SaveFont: HFONT;
 Metrics: TTextMetric;
 DC: HDC;
begin
 try
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  lWidth := (AWidth div 7)*7+1;
  HeaderH := Metrics.tmHeight + 8;
  CalPart := AHeight - HEaderH;
  lHeight:= (CalPart div 6) * 6 + HeaderH+1;
  inherited SetBounds(ALeft, ATop, lWidth, lHeight);
 except
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
 end; 
end;

procedure TCustomSchedulPanel.SetDate(DT : TDateTime);
 var
  SaveYear,
  SaveMonth,
  SaveDay     : Word;

 begin
  if DT = Date then Exit;

  SaveYear  := CurYear;
  SaveMonth := CurMonth;
  SaveDay   := CurDay;

  DecodeDate(DT,CurYear,CurMonth,CurDay);
  lMonthIndent := SysUtils.DayOfWeek(EncodeDate(CurYear,CurMonth,1)-2) mod 7;
  Change;
  if (CurMonth <> SaveMonth) or (CurYear <> SaveYear) then ChangeMonth;
  Refresh;
 end;

procedure TCustomSchedulPanel.SetParent(AParent: TWinControl);
begin
 inherited;
 if AParent <> nil then
  SetBounds(Left, Top, Width, Height);
end;

procedure TCustomSchedulPanel.SetSchedule(const Value: Tl3ObjectRefList);
begin
 FSchedule.Assign(Value);
 Refresh;
end;

procedure TCustomSchedulPanel.WMEraseBkgnd(var Msg: TMessage);
begin
  // do nothing
end;

 procedure TCustomSchedulPanel.WMGetDlgCode(var Msg : TWMGetDlgCode);
  begin
   inherited;
   Msg.Result := Msg.Result {or DLGC_WANTCHARS} or DLGC_WANTARROWS;
  end;

procedure TCustomSchedulPanel.WMLButtonDblClk(var Msg: TWMMouse);
var
 lDay : Integer;
begin
 if Assigned(FOnDblClick) then
 begin
  lDay := GetDayFromPoint(SmallPointToPoint(Msg.Pos));
  if lDay > -256 then
   FOnDblClick(Self);
 end;
end;

procedure TCustomSchedulPanel.WMLButtonDown(var Msg: TWMMouse);
begin
  NewDay := GetDayFromPoint(SmallPointToPoint(Msg.Pos));
  if NewDay > -256 then
  begin
   MouseDown := True;
   Refresh;
  end; 
end;

procedure TCustomSchedulPanel.WMLButtonUp(var Msg: TWMMouse);
begin
 if MouseDown and (CurDay <> NewDay) then
 begin
  if NewDay in [1..DaysInMonth(CurMonth, CurYear)] then
  begin
   CurDay := NewDay;
   Change;
  end
  else
  begin
   if NewDay < 1 then
   begin
    CurDay := DateUtils.DaysInMonth(IncMonth(Date,-1))+NewDay;
    Dec(CurMonth);
    if CurMonth = 0 then
    begin
     CurMonth := 12;
     Dec(CurYear)
    end;
    Date := Date; // refresh painting variables
   end
   else
   begin
    CurDay := NewDay - DaysInMonth(CurMonth, CurYear);
    Inc(CurMonth);
    if CurMonth = 13 then
    begin
     CurMonth := 1;
     Inc(CurYear)
    end;
   end;
   Change;
   ChangeMonth;
   RepaintCalendar;
  end;
  MouseDown := False;
  Refresh;
 end;
end;

procedure TCustomSchedulPanel.WMMouseMove(var Msg: TWMMouse);
var
 lDay: Integer;
 lPoint: TPoint;
 SHint : String;
begin
 lPoint := SmallPointToPoint(Msg.Pos);
 lDay := GetDayFromPoint(lPoint);
 SHint := GetDayHint(lDay);
 if SHint <> '' then
 begin
  Hint := SHint;
  ShowHint := True;
  if (lDay <> NewDay) then
  begin
   Application.HideHint;
   Application.ActivateHint(Mouse.CursorPos);
  end;
 end
 else
 begin
  Hint := '';
  ShowHint := False;
 end;
 if MouseDown then
 begin
  if (lDay = -256) then
  begin
   MouseDown := False;
   Refresh
  end;
  if (lDay <> NewDay) then
   Refresh;
 end;
 NewDay := lDay;
end;

procedure TCustomSchedulPanel.WMShowWindow(var Message: TWMShowWindow);
begin
 MouseDown := False;
end;

function TCustomSchedulPanel.GetDayHint(Day: Integer): string;
const
 MaxEventDisp = 4;
var
 TmpDate: TDateTime;
 I, NFound: Integer;
 ExtraEv: Integer;

 function Ending(N: Integer): string;
 begin
  case (N mod 10) of
   1: Result := 'е';
   2,3,4: Result := 'я';
  else
   Result := 'й';
  end;
 end;
 
begin
 Result := '';
 if not (Day in [1..DaysInMonth(CurMonth, CurYear)]) then Exit;
 TmpDate := EncodeDate(CurYear, CurMonth, Day);
 NFound := 0;
 for I := 0 to Schedule.Count-1 do
  if CompareDate(TDateTypeObj(Schedule.Items[I]).fDate, TmpDate) = 0 then
  begin
   Inc(NFound);
   if NFound <= MaxEventDisp then
   begin
    if Result <> '' then
     Result := Result + #13#10;
    Result := Result + TDateTypeObj(Schedule.Items[I]).fDescript;
   end;
  end;
 ExtraEv := NFound-MaxEventDisp;
 if ExtraEv > 0 then
  Result := Result + #13#10 + '...и еще '+IntToStr(ExtraEv)+' событи'+Ending(ExtraEv);
end;

{ TDateTypeObj }

procedure TDateTypeObj.Assign(P: TDateTypeObj);
begin
  if P is TDateTypeObj then
  begin
   TDateTypeObj(P).fDate := fDate;
   TDateTypeObj(P).fColor := fColor;
  end;
  inherited;
end;

function TDateTypeObj.OCompare(anObject: Tl3Base): Integer;
  //override;
  {-}
begin
  if (anObject Is TDateTypeObj) then
  begin
   Result := -CompareDateTime(fDate, TDateTypeObj(anObject).fDate);
   if Result = 0 then
    Result := CompareValue(fColor, TDateTypeObj(anObject).fColor);
  end
  else
   Result := inherited OCompare(anObject);
end;

constructor TDateTypeObj.Create(aDate: TDateTime; aColor: Integer; aDescript: String);
begin
 inherited Create;
 fDate:= aDate;
 fColor:= aColor;
 FDescript:= aDescript;
end;


constructor TSchedulerCalendar.Create(AOwner: TComponent);
var
 MItem: TMenuItem;
 I: Integer;
 TmpDate: TDateTime;
begin
 inherited;
 BorderStyle := bsNone;
 BevelInner := bvNone;
 BevelOuter := bvNone;
 Width := 196;
 Height := 230;
 FNavPanel := TPanel.Create(Self);
 with FNavPanel do
 begin
  Parent := Self;
  Height := 20;
  Align := alTop;
  BevelInner := bvNone;
  BevelOuter := bvNone;
 end;

 
 with TSpeedButton.Create(Self) do
 begin
  Parent := FNavPanel;
  SetBounds(2,2,15,15);
  Glyph.Handle := LoadBitmap(HInstance, 'SCARRLEFT');
  Flat := True;
  OnClick := PrevMonthClick;
 end;

 with TSpeedButton.Create(Self) do
 begin
  Parent := FNavPanel;
  SetBounds(FNavPanel.Width-2-15,2,15,15);
  Glyph.Handle := LoadBitmap(HInstance, 'SCARRRIGHT');
  Flat := True;
  Anchors := [akRight, akTop];
  OnClick := NextMonthClick;
 end;

 FTitleLabel := TLabel.Create(Self);
 with FTitleLabel do
 begin
  Parent := FNavPanel;
  AutoSize := False;
  SetBounds(25, 3, FNavPanel.Width-50, 14);
  Font.Style := [fsBold];
  Anchors := [akTop, akLeft, akRight];
  Alignment := taCenter;
  OnClick := MonthClick;
 end;

 FBottomPanel := TPanel.Create(Self);
 with FBottomPanel do
 begin
  Parent := Self;
  Height := 20;
  Align := alBottom;
  BevelInner := bvNone;
  BevelOuter := bvNone;
 end;

 with TShape.Create(Self) do
 begin
  Parent := FBottomPanel;
  Left := 3;
  Top := 2;
  Width := FBottomPanel.Height-5;
  Height := FBottomPanel.Height-5;
  Brush.Style := bsClear;
  Pen.Color := clRed;
 end;

 FTodayLabel := TLabel.Create(Self);
 with FTodayLabel do
 begin
  Parent := FBottomPanel;
  Left := FBottomPanel.Height+3;
  Top := 2;
  Font.Style := [fsBold];
  Caption := 'Сегодня '+FormatDateTime('dd.mm.yyyy', Now);
  ShowHint := True;
  Hint := 'Нажмите для установки сегодняшней даты';
  OnClick := TodayLabelClick;
 end;
 

 FSchedul := TCustomSchedulPanel.Create(Self);
 with FSchedul do
 begin
  Parent := Self;
  Align := alClient;
  OnMonthChanged := SchMonthChanged;
 end;

 FMonthMenu := TPopupMenu.Create(Self);
 with FMonthMenu do
 begin
  TmpDate := EncodeDate(1999,1,1);
  for I := 1 to 12 do
  begin
   TmpDate := RecodeMonth(TmpDate, I);
   MItem := TMenuItem.Create(Self);
   MItem.Caption := FormatDateTime('MMMM', TmpDate);
   MItem.OnClick := MonthMenuSelect;
   MItem.RadioItem := True;
   Items.Add(MItem);
  end;
 end;
 FYearMenu := TPopupMenu.Create(Self);
 SchMonthChanged(nil);
end;

function TSchedulerCalendar.GetDate: TDateTime;
begin
 Result := FSchedul.Date;
end;

function TSchedulerCalendar.GetOnChange: TNotifyEvent;
begin
 Result := FSchedul.FOnChange;
end;

function TSchedulerCalendar.GetOnDblClick: TNotifyEvent;
begin
 Result := FSchedul.FOnDblClick;
end;

function TSchedulerCalendar.GetSchedule: Tl3ObjectRefList;
begin
 Result := FSchedul.FSchedule;
end;

procedure TSchedulerCalendar.RefreshMonth;
begin
 FSchedul.ChangeMonth;
 FSchedul.Refresh;
end;

procedure TSchedulerCalendar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
 lWidth, lHeight, CalPart : Integer;
 HSize: TSize;
 HeaderH : Integer;
begin
 if Assigned(FNavPanel) and Assigned(FSchedul) and Assigned(FBottomPanel) then
 begin
  FSchedul.Align := alNone;
  FSchedul.Height := AHeight - FNavPanel.Height - FBottomPanel.Height;
  FSchedul.Width  := AWidth;
  lHeight := FNavPanel.Height + FSchedul.Height + FBottomPanel.Height;
  lWidth := FSchedul.Width;
  FSchedul.Align := alClient;
 end
 else
 begin
  lWidth := AWidth;
  lHeight := AHeight;
 end;
 inherited SetBounds(ALeft, ATop, lWidth, lHeight);
end;

procedure TSchedulerCalendar.SetDate(Value: TDateTime);
begin
 FSchedul.Date := Value;
end;

procedure TSchedulerCalendar.SetOnChange(Value: TNotifyEvent);
begin
 FSchedul.FOnChange := Value;
end;

procedure TSchedulerCalendar.SetOnDblClick(Value: TNotifyEvent);
begin
 FSchedul.FOnDblClick := Value;
end;

procedure TSchedulerCalendar.SetSchedule(Value: Tl3ObjectRefList);
begin
 FSchedul.Schedule:= Value;
end;

procedure TSchedulerCalendar.TodayLabelClick(Sender: Tobject);
begin
 FSchedul.Date := SysUtils.Date;
end;

procedure TSchedulerCalendar.PrevMonthClick(Sender: TObject);
begin
 FSchedul.PrevMonth;
end;

procedure TSchedulerCalendar.NextMonthClick(Sender: TObject);
begin
 FSchedul.NextMonth;
end;

procedure TSchedulerCalendar.SchMonthChanged(Sender: TObject);
begin
 FTitleLabel.Caption := FormatDateTime('MMMM YYYY', Date);
 if Assigned(FOnMonthChanged) then
  FOnMonthChanged(Self);
end;

procedure TSchedulerCalendar.MonthMenuSelect(Sender: TObject);
var
 lMonth: Integer;
 Y,M,D: Word;
 TmpDate: TDateTime;
begin
 lMonth := FMonthMenu.Items.IndexOf(TMenuItem(Sender))+1;
 DecodeDate(GetDate, Y, M, D);
 if not IsValidDate(Y, lMonth, D) then
  TmpDate := EndOfTheMonth(EncodeDate(Y,lMonth, 1))
 else
  TmpDate := EncodeDate(Y,lMonth, D);
 Date := TmpDate;
end;

procedure TSchedulerCalendar.MonthClick(Sender: TObject);
var
 MItem: TMenuItem;
 lPos: TPoint;
 MonthPos, YearPos: Integer;
 BothWidth, MonthWidth, YearWidth: Integer;
 I: Integer;
begin
 with FTitleLabel do
 begin
  BothWidth := Canvas.TextWidth(Caption);
  MonthWidth := Canvas.TextWidth(FormatDateTime('MMMM', Date));
  YearWidth := Canvas.TextWidth(FormatDateTime('YYYY', Date));
  MonthPos := (Width - BothWidth) div 2;
  YearPos := MonthPos + MonthWidth + Canvas.TextWidth(' ');
 end;
 lPos := FTitleLabel.ScreenToClient(Mouse.CursorPos);

 if lPos.X in [MonthPos..MonthPos+MonthWidth] then
 begin
  lPos.X := MonthPos - (MonthWidth div 2);
  lPos.Y := FTitleLabel.Height;
  lPos := FTitleLabel.ClientToScreen(lPos);
  FMonthMenu.Items[MonthOf(GetDate)-1].Checked := True;
  FMonthMenu.Popup(lPos.X, lPos.Y);
 end;

 if lPos.X in [YearPos..YearPos+YearWidth] then
 begin
  FYearMenu.Items.Clear;
  FYearMenu.AutoHotkeys := maManual;
  for I := FSchedul.CurYear-3 to FSchedul.CurYear+3 do
  begin
   MItem := TMenuItem.Create(Self);
   with MItem do
   begin
    MItem.AutoHotkeys := maManual;
    Caption := IntToStr(I);
    RadioItem := True;
    if I = FSchedul.CurYear then
     Checked := True;
    OnClick := YearMenuSelect;
   end;
   FYearMenu.Items.Add(MItem);
  end;
  MItem := TMenuItem.Create(Self);
  MItem.Caption := '-';
  FYearMenu.Items.Add(MItem);
  MItem := TMenuItem.Create(Self);
  MItem.Caption := 'Выбрать год...';
  MItem.OnClick := YearChooseSelect;
  FYearMenu.Items.Add(MItem);
  lPos.X := YearPos - (YearWidth div 2);
  lPos.Y := FTitleLabel.Height;
  lPos := FTitleLabel.ClientToScreen(lPos);
  FYearMenu.Popup(lPos.X, lPos.Y);
 end;
end;

procedure TSchedulerCalendar.YearMenuSelect(Sender: TObject);
var
 lIndex: Integer;
 YearS: String;
 lYear : Integer;
 NewDay : Integer;
begin
 lIndex := FYearMenu.Items.IndexOf(TMenuItem(Sender));
 lYear := StrToInt(FYearMenu.Items[lIndex].Caption);
 NewDay := FSchedul.CurDay;
 try
  Date := RecodeYear(GetDate, lYear);
 except
  NewDay := DaysInMonth(FSchedul.CurMonth, lYear);
  Date := EncodeDate(lYear, FSchedul.CurMonth, NewDay);
 end;
end;

procedure TSchedulerCalendar.YearChooseSelect(Sender: TObject);
var
 YearS: string;
 lYear : Integer;
 NewDate: TDateTime;
 NewDay: Integer;
begin
 YearS := IntToStr(FSchedul.CurYear);
 if InputQuery('Введите год', 'Введите год', YearS) then
 begin
  try
   lYear := StrToInt(YearS);
  except
   MessageDlg('Введено нечисловое значение!', mtError, [mbOK], 0);
   Exit;
  end;
  NewDay := FSchedul.CurDay;
  if not IsValidDate(lYear, FSchedul.CurMonth, FSchedul.CurDay) then
  begin
   if FSchedul.CurMonth <> 2 then
   begin
    MessageDlg('Некорректный год!', mtError, [mbOK], 0);
    Exit;
   end;
   try
    NewDay := DaysInMonth(FSchedul.CurMonth, lYear);
   except
    MessageDlg('Некорректный год!', mtError, [mbOK], 0);
    Exit;
   end;
  end;
  Date := EncodeDate(lYear, FSchedul.CurMonth, NewDay);
 end;
end;

procedure TSchedulerCalendar.Paint;
begin
 inherited;
 with Canvas do
 begin
  Brush.Style := bsClear;
  Pen.Color := clGray;
  Rectangle(GetClientRect);
 end;
end;

procedure TSchedulerCalendar.WMPaint(var Message: TMessage);
begin
 FTodayLabel.Font := Font;
 FTodayLabel.Font.Style := [fsBold];
 FTitleLabel.Font := Font;
 FTitleLabel.Font.Style := [fsBold];
 inherited;
end;

end.



