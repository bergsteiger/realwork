{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ExtCtrls;

interface

uses
  System.Classes, System.Types, System.UITypes, System.UIConsts, System.Masks, 
  System.Rtti, FMX.Types, FMX.Objects, FMX.Ani, FMX.Layouts, FMX.Platform,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit, FMX.Menus, FMX.Pickers, FMX.Controls,
  FMX.ActnList;

{$SCOPEDENUMS ON}

type

{ TDropTarget }

  TDropTarget = class(TTextControl)
  private
    FOnDrop: TDragDropEvent;
    FFilter: string;
    FFilterIndex: Integer;
    function GetFilterIndex: Integer;
  protected
    function CurrentFilter: String;
    procedure DragOver(const Data: TDragObject; const Point: TPointF;
      var Accept: Boolean); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    function GetDefaultSize: TSizeF; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Anchors;
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property Enabled default True;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read GetFilterIndex write FFilterIndex default 1;
    property Font;
    property FontColor;
    property StyledSettings;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign default TTextAlign.taCenter;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    property OnDropped: TDragDropEvent read FOnDrop write FOnDrop;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TPlotGrid }

  TPlotGrid = class(TControl)
  private
    FMarks: Single;
    FFrequency: Single;
    FLineFill: TBrush;
    procedure SetFrequency(const Value: Single);
    procedure SetMarks(const Value: Single);
    procedure SetLineFill(const Value: TBrush);
    procedure LineFillChanged(Sender: TObject);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Frequency: Single read FFrequency write SetFrequency;
    property Locked default False;
    property Height;
//    property Hint;
    property HitTest default True;
    property LineFill: TBrush read FLineFill write SetLineFill;
    property Padding;
    property Marks: Single read FMarks write SetMarks;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnClick;
    property OnDblClick;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TImageViewer }

  TImageViewer = class(TScrollBox)
  private
    FBack: TRectangle;
    FImage: TImage;
    FScale: Single;
    FMouseScaling: Boolean;
    FShowBackground: Boolean;
    function GetBitmap: TBitmap;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetScale(const Value: Single);
    function GetBackgroundFill: TBrush;
    procedure SetBackgroundFill(const Value: TBrush);
    procedure SetShowBackground(const Value: Boolean);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function DoCalcContentBounds: TRectF; override;
    procedure DoBitmapChange(Sender: TObject);
    function GetDefaultStyleLookupName: string; override;
  public
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer;
      var Handled: Boolean); override;
    constructor Create(AOwner: TComponent); override;
    procedure BestFit;
  published
    property Align;
    property Anchors;
    property BackgroundFill: TBrush read GetBackgroundFill write SetBackgroundFill;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property BitmapScale: Single read FScale write SetScale;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
//    property Hint;
    property HitTest default True;
    property Padding;
    property MouseScaling: Boolean read FMouseScaling write FMouseScaling default True;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowBackground: Boolean read FShowBackground write SetShowBackground default False;
//    property ShowHint default False;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnClick;
    property OnDblClick;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TPopupBox }

  ///<summary>
  ///  This class implement a popup box type container.
  ///</summary>
  TPopupBox = class(TCustomButton)
  private
    FItems: TStrings;
    FItemIndex: Integer;
    FListPicker: TCustomListPicker;
    FDropDownKind: TDropDownKind;
    FPopup: TPopupMenu;
    FOnChange: TNotifyEvent;
    procedure SetItems(const Value: TStrings);
    procedure SetItemIndex(const Value: Integer);
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure Click; override;
    procedure DoChange; virtual;
    procedure DoItemsChanged(Sender: TObject); virtual;
    procedure DoItemClick(Sender: TObject);
    procedure DoValueChangedFromDropDownList(Sender: TObject; const AValueIndex: Integer);
    procedure DoPopup; virtual;
    procedure SetText(const Value: string); override;
    function GetActionLinkClass: TActionLinkClass; override;
    property DropDownKind: TDropDownKind read FDropDownKind;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Font;
    property StyledSettings;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    { triggers }
    property IsPressed default False;
    property Items: TStrings read FItems write SetItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Locked default False;
    property Padding;
    property ModalResult default mrNone;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RepeatClick default False;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StaysPressed default False;
    property StyleLookup;
    property TabOrder;
    property Text stored False;
    property TextAlign default TTextAlign.taCenter;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;
    property WordWrap default False;
    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TCalendar }

  TCalendar = class(TStyledControl)
  private
    FNeedChange: Boolean;
    FDateTime: TDateTime;
    FDays: TListBox;
    FToday, FPrev, FNext: TButton;
    FMonths: TPopupBox;
    FYears: TPopupBox;
    FWeeks: TGridLayout;
    FFirstDayOfWeek: TCalDayOfWeek;
    FFirstDayOfWeekNum: Integer;
    FWeek: TGridLayout;
    FTodayDefault: Boolean;
    FOnChange: TNotifyEvent;
    FWeekNumbers: Boolean;
    FOnDateSelected: TNotifyEvent;
    function GetDate: TDate;
    procedure SetDate(Value: TDate);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetFirstDayOfWeek(const Value: TCalDayOfWeek);
    procedure SetTodayDefault(const Value: Boolean);
    procedure SetWeekNumbers(const Value: Boolean);
  protected
    FDisableDayChange: Integer;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    { children }
    procedure DoDeleteChildren; override;
    //
    procedure DoPrevClick(Sender: TObject);
    procedure DoNextClick(Sender: TObject);
    procedure DoTodayClick(Sender: TObject);
    procedure DoDaysMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoDaysMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoDayChange(Sender: TObject);
    procedure DoMonthChange(Sender: TObject);
    procedure DoYearChange(Sender: TObject);
    procedure FillList;
    procedure DoChange; virtual;
    procedure DoDateSelected; virtual;
    procedure KeyDown(var Key: Word; var KeyChar: WideChar; Shift: TShiftState); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;
    property DateTime: TDateTime read FDateTime write SetDateTime;
  published
    property Align;
    property Anchors;
    property ClipChildren default True;
    property ClipParent default False;
    property Cursor default crDefault;
    property Date: TDate read GetDate write SetDate;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property FirstDayOfWeek: TCalDayOfWeek read FFirstDayOfWeek
      write SetFirstDayOfWeek default TCalDayOfWeek.dowLocaleDefault;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
//    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property StyleLookup;
    property TabOrder;
    property TodayDefault: Boolean read FTodayDefault write SetTodayDefault default False;
    property Visible default True;
    property WeekNumbers: Boolean read FWeekNumbers write SetWeekNumbers default False;
    property Width;
    {events}
    property OnApplyStyleLookup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDateSelected: TNotifyEvent read FOnDateSelected write FOnDateSelected;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TCalendarEdit }

  TCustomCalendarEdit = class(TComboEditBase)
  private
    FDateTimePicker: TCustomDateTimePicker;
    FFirstDayOfWeek: TCalDayOfWeek;
    FShowWeekNumbers: Boolean;
    FTodayDefault: Boolean;
    FDate: TDateTime;
    FOnPopup: TNotifyEvent;
    FOnClosePopup: TNotifyEvent;
    FDroppedDown: Boolean;
    function GetDate: TDate;
    procedure SetDate(const Value: TDate);
  protected
    procedure DoDateChanged(Sender: TObject; const ADate: TDateTime);
    procedure DoPopupClose(Sender: TObject);
    procedure DoPopup(Sender: TObject);
    procedure DoExit; override;
    procedure SetText(const AValue: string); override;
    procedure Change; override;
    procedure SetInputSupport(const Value: Boolean); override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DropDown; override;
    property Date: TDate read GetDate write SetDate;
    property TodayDefault: Boolean read FTodayDefault write FTodayDefault default False;
    property WeekNumbers: Boolean read FShowWeekNumbers write FShowWeekNumbers default False;
    property FirstDayOfWeek: TCalDayOfWeek read FFirstDayOfWeek
      write FFirstDayOfWeek default TCalDayOfWeek.dowLocaleDefault;
    property OnClosePopup: TNotifyEvent read FOnClosePopup write FOnClosePopup;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    property DroppedDown: Boolean read FDroppedDown;
  end;

  TCalendarEdit = class (TCustomCalendarEdit)
  published
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crDefault;
    property ClipChildren default False;
    property ClipParent default False;
    property Date;
    property DesignVisible default True;
    property DisableFocusEffect;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property FirstDayOfWeek;
    property Font;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property InputSupport default False;
    property Locked default False;
    property KeyboardType default TVirtualKeyboardType.vktNumbersAndPunctuation;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property ReadOnly;
    property Scale;
    property StyleLookup;
    property StyledSettings;
    property ShowHint default False;
    property Text stored False;
    property TextAlign;
    property TodayDefault;
    property Visible default True;
    property WeekNumbers;
    property Width;
    { events }
    property OnClosePopup;
    property OnPopup;
    property OnChange;
    property OnChangeTracking;
    property OnTyping;
    property OnApplyStyleLookup;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Keyboard events }
    property OnKeyDown;
    property OnKeyUp;
    { Mouse events }
    property OnCanFocus;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TCalendarBox }

  TCalendarBox = class (TCalendarEdit)
  public
    constructor Create(AOwner: TComponent); override;
  end; //{$IFNDEF NEXTGEN_TODO} deprecated 'Duplicate of TCalendarEdit. Use TCalendarEdit instead TCalendarBox'{$ENDIF};

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Variants, System.DateUtils,
  FMX.Text;

{ TDropTarget }

constructor TDropTarget.Create(AOwner: TComponent);
begin
  inherited;
  FFilterIndex := 1;
  TextAlign := TTextAlign.taCenter;
  EnableDragHighlight := False;
  MinClipWidth := 48;
  MinClipHeight := 48;
  SetAcceptsControls(False);
end;

function TDropTarget.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(120, 120);
end;

function TDropTarget.CurrentFilter: String;
var
  S: string;
  I, Cur, Idx: Integer;
begin
  Result := '';
  if FFilter.Contains('|') then
  begin
    Cur := 1;
    Idx := 1;
    S := FFilter;
    I := S.IndexOf('|');
    while I >= 0 do
    begin
      S := S.Remove(0, I);
      I := S.IndexOf('|');
      if Odd(Cur) and (Idx = FFilterIndex) then
      begin
        if I < 0 then
          Result := S.Substring(0, I - 1)
        else
          Result := S;
        Break;
      end;
      if Odd(Cur) then
        Inc(Idx);
      Inc(Cur);
    end;
  end
  else
    Result := FFilter;
end;

procedure TDropTarget.DragDrop(const Data: TDragObject; const Point: TPointF);
begin
  inherited;
  if Assigned(FOnDrop) then
    FOnDrop(Self, Data, Point);
end;

procedure TDropTarget.DragOver(const Data: TDragObject; const Point: TPointF;
  var Accept: Boolean);
var
  Masks, M: string;
  HasFiles: Boolean;
  HasFilter: Boolean;
  HasMatchedFile: Boolean;
  I: Integer;
begin
  inherited;

  // determine if the user is dragging one or more files and
  // if there is any filter set
  HasFiles := Length(Data.Files) > 0;
  Masks := CurrentFilter;
  HasFilter := Masks <> '';

  // the Accept value is overriden by the filter only if there is at least one file
  // in the Data drag object; when a filter exists, there must be at least
  // one file that matches the filter in order for Accept to have set by the user;
  // if there is no file matching the filter, Accept is false
  if HasFiles and HasFilter then
  begin
    HasMatchedFile := False;
    M := GetToken(Masks, ';');
    while (M <> '') and (not HasMatchedFile) do
    begin
      for I := 0 to High(Data.Files) do
      begin
        HasMatchedFile := MatchesMask(Data.Files[I], M);

        // there is at least one file matching the filter
        if HasMatchedFile then
          Break;
      end;
      M := GetToken(Masks, ';');
    end;

    Accept := HasMatchedFile;
  end;
end;

function TDropTarget.GetFilterIndex: Integer;
begin
  Result := FFilterIndex;
end;

{ Graph objects }

{ TPlotGrid }

constructor TPlotGrid.Create(AOwner: TComponent);
begin
  inherited;
  FLineFill := TBrush.Create(TBrushKind.bkSolid, $FF505050);
  FLineFill.OnChanged := LineFillChanged;
  FMarks := 25;
  FFrequency := 5;
  SetAcceptsControls(False);
end;

destructor TPlotGrid.Destroy;
begin
  FreeAndNil(FLineFill);
  inherited;
end;

procedure TPlotGrid.LineFillChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TPlotGrid.Paint;
var
  X, Y: Single;
begin
  X := 0;
  Y := 0;
  Canvas.Stroke.Assign(FLineFill);
  while X < Width / 2 do
  begin
    if (X = 0) then
    begin
      Canvas.Stroke.Thickness := 2;
      Canvas.Stroke.Color := FLineFill.Color
    end
    else
    begin
      if (frac(X) = 0) and (frac(X / Frequency / Marks) = 0) then
        Canvas.Stroke.Color := FLineFill.Color
      else
        Canvas.Stroke.Color := MakeColor(FLineFill.Color, 0.4);
      Canvas.Stroke.Thickness := 1;
    end;

    Canvas.DrawLine(PointF(round(Width / 2) + X + (Canvas.Stroke.Thickness / 2), 0),
      PointF(round(Width / 2) + X + (Canvas.Stroke.Thickness / 2), Height), AbsoluteOpacity, Canvas.Stroke);
    if X <> 0 then
      Canvas.DrawLine(PointF(round(Width / 2) - X + (Canvas.Stroke.Thickness / 2),
        0), PointF(round(Width / 2) - X + (Canvas.Stroke.Thickness / 2), Height),
        AbsoluteOpacity, Canvas.Stroke);
    X := X + FFrequency;
  end;
  while Y < Height / 2 do
  begin
    if (Y = 0) then
    begin
      Canvas.Stroke.Thickness := 2;
      Canvas.Stroke.Color := FLineFill.Color
    end
    else
    begin
      if (frac(Y) = 0) and (frac(Y / Frequency / Marks) = 0) then
        Canvas.Stroke.Color := FLineFill.Color
      else
        Canvas.Stroke.Color := MakeColor(FLineFill.Color, 0.4);
      Canvas.Stroke.Thickness := 1;
    end;

    Canvas.DrawLine(PointF(0, round(Height / 2) + Y + (Canvas.Stroke.Thickness /
      2)), PointF(Width, round(Height / 2) + Y + (Canvas.Stroke.Thickness / 2)),
      AbsoluteOpacity, Canvas.Stroke);
    if Y <> 0 then
      Canvas.DrawLine(PointF(0, round(Height / 2) - Y + (Canvas.Stroke.Thickness /
        2)), PointF(Width, round(Height / 2) - Y + (Canvas.Stroke.Thickness / 2)),
        AbsoluteOpacity, Canvas.Stroke);
    Y := Y + FFrequency;
  end;
end;

procedure TPlotGrid.SetFrequency(const Value: Single);
begin
  if FFrequency <> Value then
  begin
    FFrequency := Value;
    if FFrequency < 0.05 then
      FFrequency := 0.05;
    Repaint;
  end;
end;

procedure TPlotGrid.SetLineFill(const Value: TBrush);
begin
  FLineFill.Assign(Value);
end;

procedure TPlotGrid.SetMarks(const Value: Single);
begin
  if FMarks <> Value then
  begin
    FMarks := Value;
    if FMarks < FFrequency then
      FMarks := FFrequency;
    if FMarks < 0.05 then
      FMarks := 0.05;
    Repaint;
  end;
end;

{ TImageViewer }

constructor TImageViewer.Create(AOwner: TComponent);
begin
  inherited;
  MouseScaling := True;
  Cursor := crHandPoint;
  FScale := 1;
  FBack := TRectangle.Create(Self);
  FBack.HitTest := False;
  FBack.Parent := Self;
  FBack.Locked := True;
  FBack.Stroke.Kind := TBrushKind.bkNone;
  FBack.Stored := False;
  FBack.Visible := False;
  FImage := TImage.Create(Self);
  FImage.HitTest := False;
  FImage.Parent := Self;
  FImage.Locked := True;
  FImage.Stored := False;
  FImage.WrapMode := TImageWrapMode.iwStretch;
  FImage.Bitmap.OnChange := DoBitmapChange;
  SetAcceptsControls(False);
end;

function TImageViewer.GetData: TValue;
begin
  Result := Bitmap;
end;

procedure TImageViewer.SetData(const Value: TValue);
begin
  if Value.IsEmpty then
    Bitmap.SetSize(0, 0)
  else 
  if Value.IsObject and (Value.AsObject is TPersistent) then
      Bitmap.Assign(TPersistent(Value.AsObject))
  else
    Bitmap.LoadFromFile(Value.ToString)
end;

function TImageViewer.GetBitmap: FMX.Types.TBitmap;
begin
  Result := FImage.Bitmap;
end;

function TImageViewer.DoCalcContentBounds: TRectF;
begin
  FImage.BoundsRect := RectF(0, 0, Bitmap.Width * BitmapScale,
    Bitmap.Height * BitmapScale);

  if (Content <> nil) and (ContentLayout <> nil) then
  begin
    if FImage.Width < ContentLayout.Width then
      FImage.Position.X := round((ContentLayout.Width - FImage.Width) / 2);
    if FImage.Height < ContentLayout.Height then
      FImage.Position.Y := round((ContentLayout.Height - FImage.Height) / 2);
  end;
  FBack.SetBounds(FImage.Position.X, FImage.Position.Y, FImage.Width,
    FImage.Height);

{$IFNDEF FPC}
  Result := System.Types.UnionRect(RectF(0, 0, 0, 0), FImage.ParentedRect);
{$ELSE}
  Result := UnionRect(RectF(0, 0, 0, 0), FImage.ParentedRect);
{$ENDIF}
end;

procedure TImageViewer.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  if MouseScaling then
  begin
    BitmapScale := BitmapScale + (WheelDelta / 120) * 0.04;
    Handled := True;
  end;
  inherited;
end;

procedure TImageViewer.BestFit;
var
  R: TRectF;
  s: Single;
  NeedRealign: Boolean;
begin
  if (Content <> nil) and (ContentLayout <> nil) then
  begin
    NeedRealign := False;
    if (VScrollBar <> nil) and (VScrollBar.Enabled) then
      NeedRealign := True;
    if (VScrollBar <> nil) and (VScrollBar.Enabled) then
      NeedRealign := True;
    R := RectF(0, 0, Bitmap.Width, Bitmap.Height);
    s := R.Fit(ContentLayout.LocalRect);
    if s >= 1 then
      BitmapScale := 1 / s
    else
      BitmapScale := 1;
    if NeedRealign then
    begin
      R := RectF(0, 0, Bitmap.Width, Bitmap.Height);
      s := R.Fit(ContentLayout.LocalRect);
      if s >= 1 then
        BitmapScale := 1 / s
      else
        BitmapScale := 1;
    end;
  end
end;

procedure TImageViewer.SetBitmap(const Value: FMX.Types.TBitmap);
begin
  FImage.Bitmap := Value;
end;

procedure TImageViewer.SetScale(const Value: Single);
begin
  if FScale <> Value then
  begin
    FScale := Value;
    if FScale < 0.01 then
      FScale := 0.01;
    if FScale > 10 then
      FScale := 10;
    Realign;
    Center;
  end;
end;

function TImageViewer.GetBackgroundFill: TBrush;
begin
  Result := FBack.Fill;
end;

procedure TImageViewer.SetBackgroundFill(const Value: TBrush);
begin
  FBack.Fill := Value;
end;

procedure TImageViewer.DoBitmapChange(Sender: TObject);
begin
  Realign;
end;

procedure TImageViewer.SetShowBackground(const Value: Boolean);
begin
  if FShowBackground <> Value then
  begin
    FShowBackground := Value;
    FBack.Visible := FShowBackground;
  end;
end;

function TImageViewer.GetDefaultStyleLookupName: string;
begin
  Result := 'framedscrollboxstyle';
end;

{ TPopupBox }

constructor TPopupBox.Create(AOwner: TComponent);
var
  PickerService: IFMXPickerService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, IInterface(PickerService)) then
    FListPicker := PickerService.CreateListPicker;
{$IFDEF IOS}
  FDropDownKind := TDropDownKind.ddkNative;
{$ELSE}
  FDropDownKind := TDropDownKind.ddkCustom;
{$ENDIF}
  CanFocus := True;
  Height := 22;
  FItems := TStringList.Create;;
  TStringList(FItems).OnChange := DoItemsChanged;
  FPopup := TPopupMenu.Create(nil);
  FPopup.Stored := False;
  FPopup.Parent := Self;
  FItemIndex := -1;
  MinClipWidth := 14;
  MinClipHeight := 14;
  Text := '';
end;

destructor TPopupBox.Destroy;
begin
  FreeAndNil(FListPicker);
  FreeAndNil(FPopup);
  FreeAndNil(FItems);
  inherited;
end;

procedure TPopupBox.Clear;
begin
  FPopup.Clear;
end;

procedure TPopupBox.Click;
begin
  inherited;
  DoPopup;
end;

procedure TPopupBox.DoPopup;

  procedure ShowPicker;
  begin
    if not FListPicker.IsShown then
    begin
      FListPicker.Parent := Self;
      FListPicker.Values := Items;
      FListPicker.ItemIndex := ItemIndex;
      FListPicker.CountVisibleItems := 8;
      FListPicker.OnValueChanged := DoValueChangedFromDropDownList;
      FListPicker.Show;
    end;
  end;

  procedure ShowPopupMenu;
  var
    Item: TMenuItem;
    VP: TPointF;
    i: Integer;
  begin
    FPopup.Clear;
    for i := 0 to FItems.Count - 1 do
    begin
      Item := TMenuItem.Create(Self);
      Item.Parent := FPopup;
      Item.Text := FItems[i];
      Item.RadioItem := True;
      Item.AutoCheck := True;
      Item.IsChecked := i = FItemIndex;
      Item.OnClick := DoItemClick;
      Item.Tag := i;
    end;
    //if not item no blank popup will appear
    if Assigned(Scene) and (FItems.Count > 0) then
    begin
      //checking if the size of the popup is bigger than distance between popup box and up/down form border
      //if so the position of the popup must be changed in order not lose from visual sight popup items
      if (Self.Position.Y = 0) or (Self.Position.Y < abs(trunc((Height / 2) - ((FItems.Count * 20) div 2)))) then
        VP := LocalToAbsolute(PointF(0, trunc(- Height/2)))
      else
        if (Self.Position.Y + (trunc((Height / 2) + ((FItems.Count * 20) div 2)))> Scene.GetCanvas.Height ) then
          VP := LocalToAbsolute(PointF(0, (- trunc((Height) + (FItems.Count * 20)))))
        else
          VP := LocalToAbsolute(PointF(0, trunc((Height / 2) - ((FItems.Count * 20) div 2))));
      VP := Scene.LocalToScreen(VP);
      FPopup.Popup(Round(VP.X), Round(VP.Y));
    end;
  end;

begin
  if (TDropDownKind.ddkNative = FDropDownKind) and Assigned(FListPicker) then
    ShowPicker
  else
    ShowPopupMenu;
end;

function TPopupBox.GetActionLinkClass: TActionLinkClass;
begin
  Result := nil;
end;

procedure TPopupBox.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TPopupBox.DoItemClick(Sender: TObject);
begin
  ItemIndex := TMenuItem(Sender).Tag;
end;

procedure TPopupBox.DoItemsChanged(Sender: TObject);
begin
  Repaint;
end;

procedure TPopupBox.DoValueChangedFromDropDownList(Sender: TObject; const AValueIndex: Integer);
begin
  ItemIndex := AValueIndex;
end;

function TPopupBox.GetData: TValue;
begin
  Result := ItemIndex;
end;

procedure TPopupBox.SetData(const Value: TValue);
begin
  if Value.IsType<TNotifyEvent> then
    OnChange := Value.AsType<TNotifyEvent>()
  else if Value.IsOrdinal then
    ItemIndex := Value.AsOrdinal
  else
    ItemIndex := Items.IndexOf(Value.ToString);
end;

procedure TPopupBox.SetItemIndex(const Value: Integer);
begin
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    if (FItemIndex >= 0) and (Items.Count > 0) then
      Text := Items[FItemIndex]
    else
    begin
      Text := '';
      FItemIndex := -1;
    end;
    DoChange;
  end;
end;

procedure TPopupBox.SetText(const Value: string);
begin
  if FItems.Count > 0 then
  begin
    FItemIndex := Items.IndexOf(Value);
    if FItemIndex >= 0 then
      inherited SetText(Value)
    else
      inherited SetText('')
  end
  else
  begin
    FItemIndex := -1;
    inherited SetText('')
  end;
end;

procedure TPopupBox.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

{ TCalendar }

procedure TCalendar.ApplyStyle;
var
  StyledControl: TFmxObject;
  i: Integer;
  AYear, AMonth, ADay: Word;
  LLabel: TLabel;
  LItem: TListBoxItem;
begin
  inherited;
  BeginUpdate;
  try
    DecodeDate(FDateTime, AYear, AMonth, ADay);
    //FPrev
    StyledControl := FindStyleResource('prev');
    FPrev := nil;
    if Assigned(StyledControl) and (StyledControl is TButton) then
    begin
      FPrev := TButton(StyledControl);
      FPrev.CanParentFocus := True;
      FPrev.OnClick := DoPrevClick;
    end;
    //FToday
    StyledControl := FindStyleResource('today');
    FToday := nil;
    if Assigned(StyledControl) and (StyledControl is TButton) then
    begin
      FToday := TButton(StyledControl);
      FToday.CanParentFocus := True;
      FToday.OnClick := DoTodayClick;
    end;
    //FNext
    StyledControl := FindStyleResource('next');
    FNext := nil;
    if Assigned(StyledControl) and (StyledControl is TButton) then
    begin
      FNext := TButton(StyledControl);
      FNext.CanParentFocus := True;
      FNext.OnClick := DoNextClick;
    end;
    //FMonths
    StyledControl := FindStyleResource('months');
    FMonths := nil;
    if Assigned(StyledControl) and (StyledControl is TPopupBox) then
    begin
      FMonths := TPopupBox(StyledControl);
      FMonths.CanParentFocus := True;
      for i := 1 to 12 do
        FMonths.Items.Add(FormatSettings.LongMonthNames[i]);
      FMonths.ItemIndex := AMonth - 1;
      FMonths.OnChange := DoMonthChange;
    end;
    //FYears
    StyledControl := FindStyleResource('years');
    FYears := nil;
    if Assigned(StyledControl) and (StyledControl is TPopupBox) then
    begin
      FYears := TPopupBox(StyledControl);
      FYears.CanParentFocus := True;
      for i := 1 to 10 do
        FYears.Items.Add(IntToStr(AYear - i));
      FYears.Items.Add(IntToStr(AYear));
      for i := 1 to 10 do
        FYears.Items.Add(IntToStr(AYear + i));
      FYears.ItemIndex := 10;
      FYears.OnChange := DoYearChange;
    end;
    //FWeek
    StyledControl := FindStyleResource('week');
    FWeek := nil;
    if Assigned(StyledControl) and (StyledControl is TGridLayout) then
    begin
      FWeek := TGridLayout(StyledControl);
      FWeek.CanParentFocus := True;
      for i := 0 to 6 do
      begin
        LLabel := TLabel.Create(Self);
        LLabel.Parent := FWeek;
        LLabel.Locked := True;
        LLabel.Stored := False;
        LLabel.TextAlign := TTextAlign.taCenter;
        LLabel.WordWrap := False;
        LLabel.StyleLookup := 'calendarlabelstyle';
      end;
      FWeek.ItemWidth := FWeek.Width / 7 - 0.1;
    end;
    //FWeeks
    StyledControl := FindStyleResource('weeks');
    FWeeks := nil;
    if Assigned(StyledControl) and (StyledControl is TGridLayout) then
    begin
      FWeeks := TGridLayout(StyledControl);
      FWeeks.CanParentFocus := True;
      FWeeks.Visible := WeekNumbers;
      FWeeks.ItemWidth := FWeeks.Width;
      for i := 0 to 5 do
      begin
        LLabel := TLabel.Create(Self);
        LLabel.Parent := FWeeks;
        LLabel.Locked := True;
        LLabel.Stored := False;
        LLabel.TextAlign := TTextAlign.taCenter;
        LLabel.WordWrap := False;
      end;
    end;
    //FDays
    StyledControl := FindStyleResource('days');
    FDays := nil;
    if Assigned(StyledControl) and (StyledControl is TListBox) then
    begin
      FDays := TListBox(StyledControl);
      FDays.CanParentFocus := True;
      FDays.OnMouseDown := DoDaysMouseDown;
      FDays.OnMouseUp := DoDaysMouseUp;
      FDays.OnChange := DoDayChange;
      for i := 1 to 6 * 7 do
      begin
        LItem := TListBoxItem.Create(Self);
        LItem.Parent := FDays;
        LItem.Locked := True;
        LItem.Stored := False;
        LItem.TextAlign := TTextAlign.taTrailing;
        LItem.WordWrap := False;
      end;
    end;
    FillList;
    if FWeek <> nil then
      FWeek.ItemWidth := FWeek.Width / 7 - 0.1;

  finally
    EndUpdate;
  end;
end;

constructor TCalendar.Create(AOwner: TComponent);
begin
  inherited;
  SetAcceptsControls(False);
  Width := 180;
  Height := 160;
  FDateTime := Now;
  FFirstDayOfWeek := TCalDayOfWeek.dowLocaleDefault;
  CanFocus := True;
  DisableFocusEffect := False;
end;

function TCalendar.GetData: TValue;
begin
  Result := TValue.From<TDateTime>(DateTime);
end;

procedure TCalendar.SetData(const Value: TValue);
var
  D: TDateTime;
begin
  if Value.IsType<TDateTime> then
    Date := Value.AsType<TDateTime>
  else if TryStrToDateTime(Value.ToString, D) then
    Date := D;
end;

function WeekOfYear(aDate: TDateTime): byte;
var
  t, m, year: Word;
  newyear: TDateTime;
  KW: Word;
  wtag_ny: Word;
begin
  DecodeDate(aDate, year, m, t); // calc year
  newyear := EncodeDate(year, 1, 1); // calc 1.1.year
  wtag_ny := ord(DayofWeek(newyear)); // DOW of 1.1.year
  KW := Trunc(((aDate - newyear + ((wtag_ny + 1) Mod 7) - 3) / 7) + 1);
  if (KW = 0) then
  begin
    KW := 0;
  end;
  Result := KW;
end;

procedure TCalendar.FillList;
var
  i: Integer;
  AYear, PreMonth, AMonth, ADay: Word;
  Date: TDate;
  First: Integer;
  A: string;
  Item: TListBoxItem;
  LocaleService: IFMXLocaleService;
begin
  if not Assigned(FMonths) or not Assigned(FYears) or not Assigned(FWeek) or
     (FWeekNumbers and not Assigned(FWeeks)) or not Assigned(FDays) then
    Exit;
  FDisableDayChange := FDisableDayChange + 1;
  try
    { first day }
    if FFirstDayOfWeek = TCalDayOfWeek.dowLocaleDefault then
    begin
      if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(LocaleService)) then
        A := LocaleService.GetLocaleFirstDayOfWeek
      else
        A := '6';
      FFirstDayOfWeekNum := ord(A.Chars[0]) - ord('0');
      {$IFDEF MACOS}
      FFirstDayOfWeekNum:= ord(A.Chars[0]) + ord('0');
      {$ENDIF}
    end
    else
      FFirstDayOfWeekNum := ord(FFirstDayOfWeek);
    FFirstDayOfWeekNum := (8 + FFirstDayOfWeekNum) mod 7;
    { week days }
    for i := 0 to 6 do
      TLabel(FWeek.Children[i]).Text := FormatSettings.ShortDayNames
        [1 + ((7 + i + FFirstDayOfWeekNum) mod 7)];
    { days }
    DecodeDate(FDateTime, AYear, AMonth, ADay);
    PreMonth := AMonth - 1;
    if PreMonth < 1 then
      PreMonth := 12;
    Date := EncodeDate(AYear, AMonth, 1);
    First := DayofWeek(Date);
    if First - FFirstDayOfWeekNum < 3 then
      First := First + 7;
    if FDays.Count - (First + MonthDays[IsLeapYear(AYear), AMonth] -
      FFirstDayOfWeekNum) < 3 then
      First := First - 7;
    FDays.Tag := First; // store first
    for i := 1 to First do
    begin
      Item := FDays.ListItems[i - 1];
      if Item = nil then
        Continue;
      Item.Opacity := 0.3;
      Item.Text := IntToStr(MonthDays[IsLeapYear(AYear), PreMonth] - First + i +
        1 + FFirstDayOfWeekNum);
    end;
    for i := 1 to MonthDays[IsLeapYear(AYear), AMonth] do
    begin
      Item := FDays.ListItems[First + i - 2 - FFirstDayOfWeekNum];
      if Item = nil then
        Continue;
      Item.Opacity := 1;
      Item.Text := IntToStr(i);
    end;
    for i := First + MonthDays[IsLeapYear(AYear), AMonth] to FDays.Count +
      FFirstDayOfWeekNum do
    begin
      Item := FDays.ListItems[i - 1 - FFirstDayOfWeekNum];
      if Item = nil then
        Continue;
      Item.Opacity := 0.3;
      Item.Text := IntToStr(i - First - MonthDays[IsLeapYear(AYear),
        AMonth] + 1);
    end;
    { weeks number }
    if FWeekNumbers then
    begin
      FWeeks.Visible := True;
      DecodeDate(FDateTime, AYear, AMonth, ADay);
      Date := EncodeDate(AYear, AMonth, 1);
      for i := 0 to 5 do
        if WeekOfYear(Date) + i = 0 then
          TLabel(FWeeks.Children[i]).Text := IntToStr(52)
        else if WeekOfYear(Date) = 0 then
          TLabel(FWeeks.Children[i]).Text := IntToStr(i)
        else if WeekOfYear(Date) + i > 52 then
          TLabel(FWeeks.Children[i]).Text := IntToStr(WeekOfYear(Date) + i - 52)
        else
          TLabel(FWeeks.Children[i]).Text := IntToStr(WeekOfYear(Date) + i);
    end
    else
      FWeeks.Visible := False;
    { selection }
    FDays.ItemIndex := First + ADay - 2 - FFirstDayOfWeekNum;
    { month }
    FMonths.ItemIndex := AMonth - 1;
    { years }
    FYears.Items.Clear;
    for i := 10 downto 1 do
      FYears.Items.Add(IntToStr(AYear - i));
    FYears.Items.Add(IntToStr(AYear));
    for i := 1 to 10 do
      FYears.Items.Add(IntToStr(AYear + i));
    FYears.Text := IntToStr(AYear);
  finally
    FDisableDayChange := FDisableDayChange - 1;
  end;
end;

procedure TCalendar.FreeStyle;
begin
  inherited;
  FPrev := nil;
  FToday := nil;
  FNext := nil;
  FMonths := nil;
  FYears := nil;
  FWeek := nil;
  FWeeks := nil;
  FDays := nil;
end;

procedure TCalendar.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCalendar.DoDateSelected;
begin
  if Assigned(FOnDateSelected) then
    FOnDateSelected(Self);
end;

procedure TCalendar.DoDayChange(Sender: TObject);
var
  AYear, AMonth, ADay: Word;
  DaysToAdd: Integer;
begin
  if not Assigned(FDays) then
    Exit;
  DecodeDate(FDateTime, AYear, AMonth, ADay);
  if FDays.ItemIndex - FDays.Tag + 2 + FFirstDayOfWeekNum < 1 then
  begin
    DaysToAdd := FDays.ItemIndex - FDays.Tag + 1 + FFirstDayOfWeekNum;
    Date := IncDay(EncodeDate(AYear, AMonth, 1), DaysToAdd);
  end
  else if FDays.ItemIndex - FDays.Tag + 2 + FFirstDayOfWeekNum >
    MonthDays[IsLeapYear(AYear), AMonth] then
  begin
    DaysToAdd := (FDays.ItemIndex - FDays.Tag + 2 + FFirstDayOfWeekNum) -
      MonthDays[IsLeapYear(AYear), AMonth];
    Date := IncDay(EncodeDate(AYear, AMonth, MonthDays[IsLeapYear(AYear), AMonth]), DaysToAdd);
  end
  else
    Date := EncodeDate(AYear, AMonth, FDays.ItemIndex - FDays.Tag + 2 +
      FFirstDayOfWeekNum);
  if FDisableDayChange = 0 then
    DoDateSelected;
end;

procedure TCalendar.DoDaysMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FDisableDayChange = 0 then
    Inc(FDisableDayChange);
end;

procedure TCalendar.DoDaysMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FDisableDayChange > 0 then
  begin
    Dec(FDisableDayChange);
    if (FDisableDayChange = 0) and FNeedChange then
    begin
      FNeedChange := False;
      DoChange;
      DoDateSelected;
    end;
  end;
end;

procedure TCalendar.DoDeleteChildren;
begin
  inherited;
  FPrev := nil;
  FToday := nil;
  FNext := nil;
  FMonths := nil;
  FYears := nil;
  FWeek := nil;
  FWeeks := nil;
  FDays := nil;
end;

procedure TCalendar.DoTodayClick(Sender: TObject);
begin
  Date := Now;
  DoChange;
  if FDisableDayChange = 0 then
    DoDateSelected;
end;

procedure TCalendar.DoNextClick(Sender: TObject);
begin
  Date := IncMonth(Date, 1);
  DoChange;
end;

procedure TCalendar.DoPrevClick(Sender: TObject);
begin
  Date := IncMonth(Date, -1);
  DoChange;
end;

procedure TCalendar.DoMonthChange(Sender: TObject);
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDateTime, AYear, AMonth, ADay);
  Date := EncodeDate(AYear, FMonths.ItemIndex + 1, ADay);
end;

procedure TCalendar.DoYearChange(Sender: TObject);
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDateTime, AYear, AMonth, ADay);
  Date := EncodeDate(StrToInt(FYears.Text), AMonth, ADay);
end;

procedure TCalendar.DoRealign;
begin
  inherited;
  if FWeek <> nil then
    FWeek.ItemWidth := FWeek.Width / 7 - 0.1;
end;

function TCalendar.GetDate: TDate;
begin
  Result := Trunc(FDateTime);
end;

procedure TCalendar.KeyDown(var Key: Word; var KeyChar: WideChar;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    vkLeft:
      begin
        if ([ssCtrl, ssCommand] * Shift) <> [] then
          Date := IncMonth(Date, -1)
        else
          Date := IncDay(Date, -1);
        DoChange;
        Key := 0;
        KeyChar := #0;
      end;
    vkRight:
      begin
        if ([ssCtrl, ssCommand] * Shift) <> [] then
          Date := IncMonth(Date, -1)
        else
          Date := IncDay(Date, 1);
        DoChange;
        Key := 0;
        KeyChar := #0;
      end;
    vkUp:
      if ([ssCtrl, ssCommand] * Shift) = [] then
      begin
        Date := IncDay(Date, -7);
        DoChange;
        Key := 0;
        KeyChar := #0;
      end;
    vkDown:
      if ([ssCtrl, ssCommand] * Shift) = [] then
      begin
        Date := IncDay(Date, 7);
        DoChange;
        Key := 0;
        KeyChar := #0;
      end;
  end;
end;

procedure TCalendar.SetDate(Value: TDate);
begin
  FDisableDayChange := FDisableDayChange + 1;
  ReplaceTime(TDateTime(Value), FDateTime);
  try
    SetDateTime(Value);
  except
    SetDateTime(FDateTime);
    raise;
  end;
  FDisableDayChange := FDisableDayChange - 1;
end;

procedure TCalendar.SetDateTime(const Value: TDateTime);
begin
  if FDateTime <> Value then
  begin
    FDateTime := Value;
    FillList;
    if FDisableDayChange = 0 then
      DoChange
    else
      FNeedChange := True;
  end;
end;

procedure TCalendar.SetFirstDayOfWeek(const Value: TCalDayOfWeek);
begin
  if FFirstDayOfWeek <> Value then
  begin
    FFirstDayOfWeek := Value;
    FillList;
  end;
end;

procedure TCalendar.SetTodayDefault(const Value: Boolean);
begin
  FTodayDefault := Value;
  if FTodayDefault then
    Date := Now;
end;

procedure TCalendar.SetWeekNumbers(const Value: Boolean);
begin
  if FWeekNumbers <> Value then
  begin
    FWeekNumbers := Value;
    FillList;
    Realign;
  end;
end;

procedure TCalendar.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  inherited;
  if not Handled then
  begin
    if WheelDelta > 0 then
      Date := IncMonth(Date, -1)
    else
      Date := IncMonth(Date, 1);
    Handled := True;
  end;
end;

{ TCalendarEdit }

procedure TCustomCalendarEdit.Change;
var
  TempDate: TDateTime;
begin
  inherited Change;
  if TryStrToDateTime(Text, TempDate, FormatSettings) then
    FDate := Trunc(StrToDateTime(Text))
  else
    Text := DateTimeToStr(FDate);
  RepaintEdit;
end;

constructor TCustomCalendarEdit.Create(AOwner: TComponent);
var
  PickerService: IFMXPickerService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, IInterface(PickerService)) then
  begin
    FDateTimePicker := PickerService.CreateDateTimePicker;
    FDateTimePicker.Parent := Self;
    FDateTimePicker.OnHide := DoPopupClose;
    FDateTimePicker.OnShow := DoPopup;
    FDateTimePicker.OnDateChanged := DoDateChanged;
  end;
  FFirstDayOfWeek := TCalDayOfWeek.dowLocaleDefault;
  Date := Trunc(Now);
  FFilterChar := '0123456789./';
  FDroppedDown := False;
  KeyboardType := TVirtualKeyboardType.vktNumbersAndPunctuation;
  InputSupport := False;
end;

destructor TCustomCalendarEdit.Destroy;
begin
  if Assigned(FDateTimePicker) and FDateTimePicker.IsShown then
    FDateTimePicker.Hide;
  FreeAndNil(FDateTimePicker);
  inherited;
end;

procedure TCustomCalendarEdit.DoDateChanged(Sender: TObject; const ADate: TDateTime);
var
  OldText: string;
begin
  if ReadOnly then
    Exit;
  FDate := DateOf(ADate);
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
    begin
      DropDown;
      Exit;
    end;

  OldText := Text;
  SetTextInternal(DateToStr(FDate));
  CaretPosition := Text.Length;
  inherited Change;

  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if (OldText <> Text) and TLinkObservers.EditLinkIsEditing(Observers) then
    begin
      TLinkObservers.EditLinkModified(Observers);
      TLinkObservers.EditLinkTrackUpdate(Observers);
    end;
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    if (OldText <> Text) then
    begin
      TLinkObservers.ControlValueModified(Observers);
      TLinkObservers.ControlValueTrackUpdate(Observers);
    end;
end;

procedure TCustomCalendarEdit.DoExit;
begin
  inherited DoExit;
  if InputSupport then
    Caret.Visible := True;
  if Assigned(FDateTimePicker) then
  begin
    FDroppedDown := False;
    FDateTimePicker.Hide;
  end;
end;

procedure TCustomCalendarEdit.DoPopup(Sender: TObject);
begin
  if Assigned(FOnPopup) then
    FOnPopup(Self);
end;

procedure TCustomCalendarEdit.DoPopupClose(Sender: TObject);
var
  TextService: TTextService;
begin
  if not (csDestroying in ComponentState) then
  begin
    FDroppedDown := False;
    TextService := GetTextService;
    if InputSupport and Assigned(TextService) then
    begin
      SelStart := TextService.CombinedText.Length;
      SelLength := 0;
      Caret.Visible := True;
    end;
    if Assigned(FOnClosePopup) then
      FOnClosePopup(Self);
  end;
end;

procedure TCustomCalendarEdit.DropDown;
begin
  if Assigned(FDateTimePicker) then
  begin
    if FDateTimePicker.IsShown then
    begin
      FDroppedDown := False;
      FDateTimePicker.Hide;
    end
    else
    begin
      SelLength := 0;
      if InputSupport then
        Caret.Visible := False;
      FDroppedDown := True;
      FDateTimePicker.Date := Date;
      FDateTimePicker.FirstDayOfWeek := FFirstDayOfWeek;
      FDateTimePicker.ShowWeekNumbers := FShowWeekNumbers;
      FDateTimePicker.TodayDefault := FTodayDefault;
      FDateTimePicker.Show;
    end;
  end;
end;

function TCustomCalendarEdit.GetDate: TDate;
begin
  Result := FDate;
end;

function TCustomCalendarEdit.GetDefaultStyleLookupName: string;
begin
  if InputSupport then
    Result := 'comboeditstyle'
  else
    Result := 'comboboxstyle';
end;

procedure TCustomCalendarEdit.SetDate(const Value: TDate);
begin
  if FDate <> Value then
  begin
    FDate := Value;
    Text := DateTimeToStr(Value);
  end;
end;

procedure TCustomCalendarEdit.SetInputSupport(const Value: Boolean);
var
  OldValue: Boolean;
begin
  OldValue := InputSupport;
  inherited SetInputSupport(Value);
  // Default, for same kind of input support we must use other kind of style
  // comboeditstyle and comboboxstyle
  if OldValue <> Value then
    DoStyleChanged;
end;

procedure TCustomCalendarEdit.SetText(const AValue: string);
var
  TempDate: TDateTime;
begin
  inherited;
  if TryStrToDateTime(AValue, TempDate, FormatSettings) then
    if StrToDateTime(AValue) <> FDate then
      Change;
end;

{ TCalendarBox }

constructor TCalendarBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InputSupport := False;
end;

initialization
  RegisterFmxClasses([TCalendar, TDropTarget, TImageViewer, TPlotGrid,
    TCalendarEdit, TPopupBox]);
end.
