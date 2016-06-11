{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ExtCtrls;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Types, System.UITypes, System.Rtti, FMX.Types, FMX.Objects, FMX.Layouts, FMX.Graphics,
  FMX.StdCtrls, FMX.Menus, FMX.Controls, FMX.ActnList, FMX.Pickers;

type

{ TDropTarget }

  TDropTarget = class(TTextControl)
  private
    FOnDrop: TDragDropEvent;
    FFilter: string;
    FFilterIndex: Integer;
  protected
    function CurrentFilter: String;
    procedure DragOver(const Data: TDragObject; const Point: TPointF;
      var Operation: TDragOperation); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    function GetDefaultSize: TSizeF; override;
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Font;
    property FontColor;
    property TextAlign;
  published
    property Anchors;
    property Align;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property Enabled;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: Integer read FFilterIndex write FFilterIndex default 1;
    property TextSettings;
    property StyledSettings;
    property Locked;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property Text;
    property TouchTargetExpansion;
    property Visible;
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
    FLineFill: TStrokeBrush;
    procedure SetFrequency(const Value: Single);
    procedure SetMarks(const Value: Single);
    procedure SetLineFill(const Value: TStrokeBrush);
    procedure LineFillChanged(Sender: TObject);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property Anchors;
    property ClipChildren;
    property ClipParent;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Frequency: Single read FFrequency write SetFrequency;
    property Locked;
    property Height;
    property HitTest;
    property LineFill: TStrokeBrush read FLineFill write SetLineFill;
    property Padding;
    property Marks: Single read FMarks write SetMarks;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property TouchTargetExpansion;
    property Visible;
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

  TImageViewer = class(TCustomScrollBox)
  private
    FBack: TRectangle;
    FImage: TImage;
    FBitmapScale: Single;
    FMouseScaling: Boolean;
    FShowBackground: Boolean;
    function GetBitmap: TBitmap;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetBitmapScale(const Value: Single);
    function GetBackgroundFill: TBrush;
    procedure SetBackgroundFill(const Value: TBrush);
    procedure SetShowBackground(const Value: Boolean);
    function BitmapScaleStored: Boolean;
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function DoCalcContentBounds: TRectF; override;
    procedure DoBitmapChange(Sender: TObject);
    function GetDefaultStyleLookupName: string; override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure BestFit;
  published
    property Align;
    property Anchors;
    property AutoHide;
    property BackgroundFill: TBrush read GetBackgroundFill write SetBackgroundFill;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property BitmapScale: Single read FBitmapScale write SetBitmapScale stored BitmapScaleStored nodefault;
    property ClipChildren;
    property ClipParent;
    property Cursor default crHandPoint;
    property DisableMouseWheel;
    property DragMode;
    property Enabled;
    property EnableDragHighlight;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    property Locked;
    property Margins;
    property MouseScaling: Boolean read FMouseScaling write FMouseScaling default True;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowBackground: Boolean read FShowBackground write SetShowBackground default False;
    property ShowScrollBars;
    property ShowSizeGrip;
    property Size;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property TouchTargetExpansion;
    property Visible;
    property Width;
    { Events }
    property OnApplyStyleLookup;
    property OnPainting;
    property OnPaint;
    property OnResize;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Mouse events }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    { ScrollBox events }
    property OnViewportPositionChange;
    property OnHScrollChange;
    property OnVScrollChange;
    property OnCalcContentBounds;
  end;

{ TPopupBox }

  { This class implement a popup box type container. }
  TPopupBox = class(TCustomButton)
  private
    FItems: TStrings;
    FItemIndex: Integer;
    FListPicker: TCustomListPicker;
    FDropDownKind: TDropDownKind;
    FPopup: TPopupMenu;
    FOnChange: TNotifyEvent;
    FChanged: Boolean;
    procedure SetItems(const Value: TStrings);
    procedure SetItemIndex(const Value: Integer);
    procedure Change;
  protected
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure Click; override;
    procedure DoChange; virtual;
    procedure DoItemsChanged(Sender: TObject); virtual;
    procedure DoItemClick(Sender: TObject);
    procedure DoValueChangedFromDropDownList(Sender: TObject; const AValueIndex: Integer);
    procedure DoPopup; virtual;
    procedure DoExit; override;
    procedure DoEndUpdate; override;
    procedure SetText(const Value: string); override;
    procedure Loaded; override;
    function GetActionLinkClass: TActionLinkClass; override;
    property DropDownKind: TDropDownKind read FDropDownKind;
    function GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    property Font;
    property TextAlign;
    property WordWrap;
  published
    property Action;
    property Align;
    property Anchors;
    property AutoTranslate default True;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren;
    property ClipParent;
    property ControlType;
    property Cursor;
    property DisableFocusEffect;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property StyledSettings;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest;
    { triggers }
    property IsPressed default False;
    property Items: TStrings read FItems write SetItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Locked;
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
    property Size;
    property StaysPressed default False;
    property StyleLookup;
    property TabOrder;
    property TabStop;
    property Text stored False;
    property TouchTargetExpansion;
    property Visible;
    property Width;
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

implementation

uses
  System.UIConsts, System.Masks, FMX.Platform, System.SysUtils, System.Math, System.Math.Vectors, FMX.Consts, FMX.Forms,
  FMX.Utils;

{ TDropTarget }

constructor TDropTarget.Create(AOwner: TComponent);
begin
  inherited;
  FFilterIndex := 1;
  EnableDragHighlight := False;
  MinClipWidth := 48;
  MinClipHeight := 48;
  SetAcceptsControls(False);
end;

type
  TDropTargeSettings = class (TTextSettingsInfo.TCustomTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property HorzAlign default TTextAlign.Center;
  end;

constructor TDropTargeSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  HorzAlign := TTextAlign.Center;
  WordWrap := True;
end;

function TDropTarget.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TDropTargeSettings;
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
  if FFilter.Contains('|') and (FFilterIndex > 0) then
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
  var Operation: TDragOperation);
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

    if HasMatchedFile then
      Operation := TDragOperation.Move;
  end;
end;

{ Graph objects }

{ TPlotGrid }

constructor TPlotGrid.Create(AOwner: TComponent);
begin
  inherited;
  FLineFill := TStrokeBrush.Create(TBrushKind.Solid, $FF505050);
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

procedure TPlotGrid.SetLineFill(const Value: TStrokeBrush);
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
  FBitmapScale := 1;
  FBack := TRectangle.Create(Self);
  FBack.HitTest := False;
  FBack.Parent := Self;
  FBack.Locked := True;
  FBack.Stroke.Kind := TBrushKind.None;
  FBack.Stored := False;
  FBack.Visible := False;
  FImage := TImage.Create(Self);
  FImage.HitTest := False;
  FImage.Parent := Self;
  FImage.Locked := True;
  FImage.Stored := False;
  FImage.WrapMode := TImageWrapMode.Stretch;
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

function TImageViewer.GetBitmap: FMX.Graphics.TBitmap;
begin
  Result := FImage.Bitmap;
end;

function TImageViewer.DoCalcContentBounds: TRectF;
var
  BackgroundRect: TRectF;
begin
  FImage.BoundsRect := RectF(0, 0, Bitmap.Width * BitmapScale,
    Bitmap.Height * BitmapScale);        

  if (Content <> nil) and (ContentLayout <> nil) then
  begin
    if FImage.Width < ContentLayout.Width then
      FImage.Position.X := Round((ContentLayout.Width - FImage.Width) / 2);
    if FImage.Height < ContentLayout.Height then
      FImage.Position.Y := Round((ContentLayout.Height - FImage.Height) / 2);
  end;             

  Result := System.Types.UnionRect(RectF(0, 0, 0, 0), FImage.BoundsRect);
  if ContentLayout <> nil then
    BackgroundRect := System.Types.UnionRect(Result, ContentLayout.ClipRect)
  else
    BackgroundRect := Result;
  FBack.BoundsRect := BackgroundRect;
  if Result.IsEmpty then
    Result := BackgroundRect;
end;

procedure TImageViewer.MouseWheel(Shift: TShiftState; WheelDelta: Integer;
  var Handled: Boolean);
begin
  if MouseScaling and not (DisableMouseWheel or Handled) then
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

procedure TImageViewer.SetBitmap(const Value: FMX.Graphics.TBitmap);
begin
  FImage.Bitmap := Value;
  RealignContent;
end;

procedure TImageViewer.SetBitmapScale(const Value: Single);
const
  MinAllowedScale = 0.01;
  MaxAllowedScale = 10.0;
var
  NewValue: Single;
begin
  NewValue := Min(Max(Value, MinAllowedScale), MaxAllowedScale);
  if not SameValue(FBitmapScale, NewValue, TEpsilon.Scale) then
  begin
    FBitmapScale := NewValue;
    Content.BeginUpdate;
    try
      RealignContent;
      Center;
    finally
      Content.EndUpdate;
    end;
  end;
end;

function TImageViewer.BitmapScaleStored: Boolean;
begin
  Result := not SameValue(FBitmapScale, 1, TEpsilon.Scale);
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
  RealignContent;
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
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
    FListPicker := PickerService.CreateListPicker;
{$IF Defined(IOS) OR Defined(ANDROID)}
  FDropDownKind := TDropDownKind.Native;
{$ELSE}
  FDropDownKind := TDropDownKind.Custom;
{$ENDIF}
  CanFocus := True;
  Height := 22;
  FItems := TStringList.Create;
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

type
  TPopupBoxSettings = class (TTextSettingsInfo.TCustomTextSettings)
  public
    constructor Create(const AOwner: TPersistent); override;
  published
    property Font;
    property FontColor;
    property HorzAlign default TTextAlign.Center;
    property WordWrap default False;
  end;

{ TDropTargeSettings }

constructor TPopupBoxSettings.Create(const AOwner: TPersistent);
begin
  inherited;
  HorzAlign := TTextAlign.Center;
  WordWrap := False;
end;


function TPopupBox.GetTextSettingsClass: TTextSettingsInfo.TCustomTextSettingsClass;
begin
  Result := TPopupBoxSettings;
end;

procedure TPopupBox.Clear;
begin
  ItemIndex := -1;
  FPopup.Clear;
  Items.Clear;
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
    Display: TDisplay;
  begin
    FPopup.Clear;
    for i := 0 to FItems.Count - 1 do
    begin
      Item := TMenuItem.Create(Self);
      Item.Parent := FPopup;
      Item.Text := FItems[i];
      Item.RadioItem := True;
      Item.AutoCheck := True;
      Item.IsChecked := i = ItemIndex;
      Item.OnClick := DoItemClick;
      Item.Tag := i;
    end;
    //if not item no blank popup will appear
    if (Scene <> nil) and (FItems.Count > 0) then
    begin
      VP := LocalToAbsolute(TPointF.Create(Width / 2, Height / 2));
      if Root is TCommonCustomForm then
      begin
        if Pressed or DoubleClick then
          VP := TCommonCustomForm(Root).ScreenToClient(Screen.MousePos);
        Display := Screen.DisplayFromForm(TCommonCustomForm(Root), VP);
      end
      else
      begin
        VP := Scene.LocalToScreen(VP);
        Display := Screen.DisplayFromPoint(VP);
      end;
      if (Self.Position.Y = 0) or (Self.Position.Y < abs(trunc((Height / 2) - ((FItems.Count * 20) div 2)))) then
        VP := LocalToAbsolute(PointF(0, trunc(- Height/2)))
      else
        if (Self.Position.Y + (trunc((Height / 2) + ((FItems.Count * 20) div 2)))> Scene.GetCanvas.Height ) then
          VP := LocalToAbsolute(PointF(0, (- trunc((Height) + (FItems.Count * 20)))))
        else
          VP := LocalToAbsolute(PointF(0, trunc((Height / 2) - ((FItems.Count * 20) div 2))));
      VP := Scene.LocalToScreen(VP);
      VP.X := EnsureRange(VP.X, Display.BoundsRect.Left, Display.BoundsRect.Right - 1);
      VP.Y := EnsureRange(VP.Y, Display.BoundsRect.Top, Display.BoundsRect.Bottom - 1);
      FPopup.Popup(Round(VP.X), Round(VP.Y));
    end;
  end;

begin
  if (TDropDownKind.Native = FDropDownKind) and (FListPicker <> nil) then
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

procedure TPopupBox.DoExit;
begin
  inherited DoExit;
  if (FListPicker <> nil) and (TDropDownKind.Native = DropDownKind) and FListPicker.IsShown then
    FListPicker.Hide;
end;

procedure TPopupBox.DoItemClick(Sender: TObject);
begin
  ItemIndex := TMenuItem(Sender).Tag;
end;

procedure TPopupBox.DoItemsChanged(Sender: TObject);
begin
  if not InRange(FItemIndex, 0, Items.Count - 1) then
    FItemIndex := -1;
  if FUpdating = 0 then
    SetText(inherited Text);
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

procedure TPopupBox.DoEndUpdate;
begin
  inherited;
  SetText(inherited Text);
  if FChanged then
    Change;
end;

procedure TPopupBox.Loaded;
begin
  inherited;
  if FChanged then
    Change;
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

procedure TPopupBox.Change;
begin
  if ([csLoading, csDesigning] * ComponentState = []) and not Released and (FUpdating = 0) then
    try
      DoChange
    finally
      FChanged := False;
    end
  else
    FChanged := True;
end;

procedure TPopupBox.SetItemIndex(const Value: Integer);
begin
  if FItemIndex <> Value then
  begin
    BeginUpdate;
    try
      if (Value >= 0) and (Value < Items.Count) then
      begin
        inherited Text := Items[Value];
        FItemIndex := Value;
      end
      else
      begin
        inherited Text := '';
        FItemIndex := -1;
      end;
      Change;
    finally
      EndUpdate;
    end;
    DoChanged;
  end;
end;

procedure TPopupBox.SetText(const Value: string);
var
  OldIndex: Integer;
begin
  OldIndex := FItemIndex;
  try
    if not ((ItemIndex >= 0) and (ItemIndex < FItems.Count) and (Items[ItemIndex] = Value)) then
      FItemIndex := Items.IndexOf(Value);
    if FItemIndex >= 0 then
      inherited SetText(Value)
    else
      inherited SetText('');
  finally
    if OldIndex <> FItemIndex then
    begin
      DoChanged;
      Change;
    end;
  end;
end;

procedure TPopupBox.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

initialization
  RegisterFmxClasses([TDropTarget, TImageViewer, TPlotGrid, TPopupBox]);
end.
