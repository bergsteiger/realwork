unit vtImageForm;

{ $Id: vtImageForm.pas,v 1.4 2007/12/12 11:52:08 voba Exp $ }

// $Log: vtImageForm.pas,v $
// Revision 1.4  2007/12/12 11:52:08  voba
// - cc
//
// Revision 1.3  2007/12/12 11:02:03  voba
// - убрал EraseBackground
//
// Revision 1.2  2007/12/12 07:45:54  voba
// - bug fix
//
// Revision 1.1  2007/12/11 15:57:15  voba
// no message
//

interface

uses
  Consts, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TvtCustomImage = class(TGraphicControl)
  private
    FPicture: TPicture;
    FAutoSize: Boolean;
    FIncrementalDisplay: Boolean;
    FTransparent: Boolean;
    FDrawing: Boolean;
    function GetCanvas: TCanvas;
    procedure PictureChanged(Sender: TObject);
    procedure SetAutoSize(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetTransparent(Value: Boolean);
  protected
    function DoPaletteChange: Boolean;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;

    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property IncrementalDisplay: Boolean read FIncrementalDisplay write FIncrementalDisplay default False;
    property Picture: TPicture read FPicture write SetPicture;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
  end;

  TvtWndProcEvent = procedure(var Message: TMessage) of object;
  TvtBeforeWndProcEvent = procedure(var Message: TMessage; var ProcessMessage: boolean) of object;

  TvtCaptureMessageClass = class(TComponent)
  private
    FOnWndProc: TvtWndProcEvent;
    FOnBeforeWndProc: TvtBeforeWndProcEvent;
    FEnabled: Boolean;
    FWndHandle: HWnd;
    FWndHandlerPtr: Pointer;
    FOldWndHandler: Pointer;  {Restore to this when this component is destroyed }
    FWinControl: TWinControl;

    procedure SetWndHandle(Value: Hwnd);
    procedure SetWndControl(Value: TWinControl);
    procedure SetEnabled(aValue: Boolean);
    procedure StartSubClass;
    procedure EndSubClass;
  protected
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NewWndProc(var Message: TMessage);
    property WindowHandle: HWnd read FWndHandle write SetWndHandle;
    property WinControl: TWinControl read FWinControl write SetWndControl;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property OnWndProc: TvtWndProcEvent read FOnWndProc write FOnWndProc;
    property OnBeforeWndProc: TvtBeforeWndProcEvent read FOnBeforeWndProc write FOnBeforeWndProc;
  end;


  TvtCustomImageForm = class(TvtCustomImage)
  private
    fDragged             : Boolean;
    fDragTolerance       : Integer;
    fTransparentColor    : TColor;
    fRegion              : HRgn;
    fCaptionBarControl   : TControl;

    fCaptureMessageClass : TvtCaptureMessageClass;
    LastFocusRect        : TRect;

    function GetPicture: TPicture;
    procedure SetPicture(Value: TPicture);
    procedure SetCaptionBarControl(Value: TControl);
  protected
    DraggingForm: Boolean;
    procedure DestroyWnd;

    procedure Paint; override;
    function  GetTransparentColor: TColor;
    procedure DrawFocusRect(DC: HDC; FocusRect: TRect); virtual;
    procedure FormMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure SetParent(Value:TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure BeforeFormWndProc(var Message: TMessage; var ProcessMessage: Boolean);
    procedure AfterFormWndProc(var Message: TMessage); virtual;

    procedure MouseLoop(X, Y: Integer); virtual;
    procedure MouseLoop_MouseMove(X, Y: Integer;
                                  aCursorPos: TPoint;
                                  var FirstTime : Boolean;
                                  var FocusRect : TRect;
                                  OriginalRect :TRect); virtual;
    procedure MouseLoop_MouseUp(X, Y: Integer;
                                ACursorPos: TPoint;
                                OriginalRect, FocusRect: TRect); virtual;
    function GetDragFullWindows: Boolean; virtual;
  public
    constructor Create(Aowner:TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ApplyBitmapRegion; virtual;

    property CaptionBarControl: TControl
     read FCaptionBarControl
     write SetCaptionBarControl;

    property DragTolerance: Integer
     read FDragTolerance
     write FDragTolerance
     default 5;

    property Picture: TPicture
     read GetPicture
     write SetPicture;

    property TransparentColor: TColor
     read FTransparentColor
     write FTransparentColor
     default clNone;

    property Dragged : Boolean
     read fDragged
     write fDragged
     default True;
  end;

  TvtImageForm = class(TvtCustomImageForm)
  published
    property Dragged;

    property Align;
    property AutoSize;
    property Picture;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property CaptionBarControl;
    property DragTolerance;
    property TransparentColor;
  end;

implementation
uses
 StdCtrls;

function vtCreateRegionFromBitmap(aBitmap: TBitmap; TransColor: TColor): HRgn;
var
 lBitmap: TBitmap;
 Rgn1, Rgn2: HRgn;
 Col, StartCol, Row: integer;
 Line: PByteArray;
 lIsTrueColorBmp : boolean;
const
 cBool2Color : array[boolean] of TColor = (clBlack, clWhite);
 cBitMask: array[0..7] of byte = (128, 64, 32, 16, 8, 4, 2, 1);

 function ColToColor(Col: integer): TColor;
 begin
  if lIsTrueColorBmp then
   Result := Line[Col * 3] * 256 * 256 + Line[Col * 3 + 1] * 256 + Line[Col * 3 + 2]
  else
   Result := cBool2Color[(Line[Col div 8] and cBitMask[Col mod 8]) = 0];
 end;

begin
 Result := 0;
 if (aBitmap <> nil) and (aBitmap.Width = 0) or (aBitmap.Height = 0) then Exit;
 Rgn1 := 0;

 lBitmap := TBitmap.Create;
 try
  lBitmap.Assign(aBitmap);

  lIsTrueColorBmp := (lBitmap.PixelFormat = Graphics.pf24bit);

  if not lIsTrueColorBmp then
  begin
   lBitmap.Mask(TransColor);
   TransColor := clBlack;
  end;

  with lBitmap do
  begin
   for Row := 0 to Pred(lBitmap.Height) do
   begin
    Line:= ScanLine[Row];

    Col := 0;
    while Col < lBitmap.Width do
    begin
     while (Col < lBitmap.Width) and (ColToColor(Col) = TransColor) do inc(Col);
     if Col >= lBitmap.Width then Continue;

     StartCol := Col;
     while (Col < lBitmap.Width) and (ColToColor(Col) <> TransColor) do inc(Col);
     if Col >= lBitmap.Width then Col := lBitmap.Width;

     if Rgn1 = 0 then
      Rgn1 := CreateRectRgn(StartCol, Row, Col, Row + 1)
     else
     begin
      Rgn2 := CreateRectRgn(StartCol, Row, Col, Row + 1);
      if (Rgn2 <> 0) then
       CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
      Deleteobject(Rgn2);
     end;
    end;
   end;
  end;
  Result := Rgn1;
 finally
  lBitmap.Free;
 end;
end;

{TvtCustomImage}
constructor TvtCustomImage.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 ControlStyle := ControlStyle + [csReplicatable];
 FPicture := TPicture.Create;
 FPicture.OnChange := PictureChanged;
 Height := 105;
 Width := 105;
end;

destructor TvtCustomImage.Destroy;
begin
 FPicture.Free;
 inherited Destroy;
end;

function TvtCustomImage.GetPalette: HPALETTE;
begin
 if FPicture.Graphic = nil then
  Result := 0
 else
  Result := FPicture.Graphic.Palette
end;

procedure TvtCustomImage.Paint;
var
 Save: Boolean;
begin
 if csDesigning in ComponentState then
  with inherited Canvas do
  begin
   Pen.Style := psDash;
   Brush.Style := bsClear;
   Rectangle(0, 0, Width, Height);
  end;
  Save := FDrawing;
  FDrawing := True;
  try
   with inherited Canvas do
    StretchDraw(Rect(0, 0, Picture.Width, Picture.Height), Picture.Graphic);
  finally
   FDrawing := Save;
  end;
end;

function TvtCustomImage.DoPaletteChange: Boolean;
var
 lParentForm: TCustomForm;
 lGraphic : TGraphic;
begin
  Result := False;
  lGraphic := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (lGraphic <> nil) and
    (lGraphic.PaletteModified) then
  begin
   if (lGraphic.Palette = 0) then
    lGraphic.PaletteModified := False
   else
   begin
    lParentForm := GetParentForm(Self);
    if Assigned(lParentForm) and lParentForm.Active and lParentform.HandleAllocated then
    begin
     if FDrawing then
      lParentForm.Perform(wm_QueryNewPalette, 0, 0)
     else
      PostMessage(lParentForm.Handle, wm_QueryNewPalette, 0, 0);
     Result := True;
     lGraphic.PaletteModified := False;
    end;
   end;
  end;
end;

function TvtCustomImage.GetCanvas: TCanvas;
var
 lBitmap: TBitmap;
begin
 if Picture.Graphic = nil then
 begin
  lBitmap := TBitmap.Create;
  try
   lBitmap.Width := Width;
   lBitmap.Height := Height;
   Picture.Graphic := lBitmap;
  finally
   lBitmap.Free;
  end;
 end;
 if Picture.Graphic is TBitmap then
  Result := TBitmap(Picture.Graphic).Canvas
 else
  raise EInvalidOperation.Create(SImageCanvasNeedsBitmap);
end;

procedure TvtCustomImage.SetAutoSize(Value: Boolean);
begin
 FAutoSize := Value;
 PictureChanged(Self);
end;

procedure TvtCustomImage.SetPicture(Value: TPicture);
begin
 FPicture.Assign(Value);
end;

procedure TvtCustomImage.SetTransparent(Value: Boolean);
begin
 if Value <> FTransparent then
 begin
  FTransparent := Value;
  PictureChanged(Self);
 end;
end;

procedure TvtCustomImage.PictureChanged(Sender: TObject);
var
 G: TGraphic;
begin
 if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
   SetBounds(Left, Top, Picture.Width, Picture.Height);
 G := Picture.Graphic;
 if G <> nil then
 begin
  if not ((G is TMetaFile) or (G is TIcon)) then
   G.Transparent := FTransparent;
  if (not G.Transparent) and ((G.Width >= Width)
     and (G.Height >= Height)) then
   ControlStyle := ControlStyle + [csOpaque]
  else
   ControlStyle := ControlStyle - [csOpaque];
  if DoPaletteChange and FDrawing then Update;
 end
 else
  ControlStyle := ControlStyle - [csOpaque];
 if not FDrawing then Invalidate;
end;

constructor TvtCustomImageForm.Create(Aowner:TComponent);
begin
 inherited;
 FDragTolerance := 5;
 //FRegion := 0;
 Align := alClient;
 FTransparentColor := clNone;
 FCaptureMessageClass := nil;
 fDragged := True;
end;

destructor TvtCustomImageForm.Destroy;
begin
 if FRegion <> 0 then DeleteObject(FRegion);
 if FCaptureMessageClass <> nil then FCaptureMessageClass.Free;
//  FCaptureMessageClass:= nil;
 inherited Destroy;
end;

procedure TvtCustomImageForm.DestroyWnd;
begin
 if FRegion <> 0 then
 begin
  SetWindowRgn(GetParentForm(self).Handle, 0, False);
  DeleteObject(FRegion);
  FRegion := 0;
 end;
end;

// 10/26/98 - Added check to use windows setting for dragging of form when UseWindowsDrag is set.
function TvtCustomImageForm.GetDragFullWindows: Boolean;
var
 s: integer;
begin
 s:= 0;
 if fDragged then
  SystemParametersInfo(SPI_GETDRAGFULLWINDOWS, 0, Pointer(@s), 0);
 Result := s <> 0;
end;

procedure TvtCustomImageForm.BeforeFormWndProc(var Message: TMessage; var ProcessMessage: Boolean);
begin
 ProcessMessage := Message.Msg <> WM_ERASEBKGND;
end;

procedure TvtCustomImageForm.AfterFormWndProc(var Message: TMessage);
var
 lControl: TControl;
 ClickOrMouseDownAssigned:Boolean;
begin
 if not (csDesigning in componentstate) then
 case Message.Msg of
  WM_DESTROY: DestroyWnd;

  WM_LBUTTONDOWN:  //Needed to capture mouse messages from caption control
   with TWMMouse(Message) do
   begin
    lControl := Parent.ControlAtPos(Point(XPos, YPos), True);
    ClickOrMouseDownAssigned := Assigned(TButton(lControl).OnClick) or
                                Assigned(TButton(lControl).OnMouseDown);
    if ((FCaptionBarControl <> nil) and not ClickOrMouseDownAssigned) or
       ((FCaptionBarControl <> nil) and (lControl = CaptionBarControl)) or
       ((FCaptionBarControl = nil) and (lControl = self)) then
     FormMouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
   end;
 end; //case Message.Msg of ...
end;

procedure TvtCustomImageForm.FormMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 p: TPoint;
 ParentForm: TCustomForm;
begin
 if (FCaptionBarControl <> nil) then
  with FCaptionBarControl do
   if not (PtinRect(Rect(Left, Top, Width + Left, Height + Top), Point(x, y))) then
    Exit;

 if ssLeft in Shift then
 begin
  ParentForm := GetParentForm(self);
  if TForm(ParentForm).FormStyle = fsMDIChild then
  begin
   p := ClientToScreen(Point(x,y));
   p.x := p.x - ParentForm.left;
   p.y := p.y - ParentForm.Top;
  end
  else
   p := Point(x, y);
  MouseLoop(p.x, p.y)
 end
 else
  SendMessage(Parent.Handle, WM_SYSCOMMAND, SC_KEYMENU, 0);
end;

procedure TvtCustomImageForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
 inherited;
 if (Operation = opRemove) and (AComponent = FCaptionBarControl) then
  fCaptionBarControl := nil;
end;

procedure TvtCustomImageForm.MouseLoop(X, Y: Integer);
var
 ACursor : TPoint;
 Msg : TMsg;
 FirstTime : Boolean;
 OriginalRect, FocusRect: TRect;
begin
 FirstTime := True;
 with Parent do OriginalRect := Rect(Left, Top, Left + Width, Top + Height);
 FocusRect := Rect(0, 0, 0, 0);
 with GetParentForm(self) do
 begin
  SetCapture(Handle);
  try
   while GetCapture = Handle do
   begin
    GetCursorPos(ACursor);
    case Integer(GetMessage(Msg, 0, 0, 0)) of
     -1: Break;
      0: begin
          PostQuitMessage(Msg.WParam);
          Break;
         end;
    end;
    case Msg.Message of
     WM_MOUSEMOVE :
      MouseLoop_MouseMove(X, Y, ACursor, FirstTime, FocusRect, OriginalRect);
     WM_LBUTTONUP :
      begin
       MouseLoop_MouseUp(X, Y, ACursor, OriginalRect, FocusRect);
       TranslateMessage(Msg);   // So OnMouseUp fires
       DispatchMessage(Msg);

       if GetCapture = Handle then ReleaseCapture;
      end;
     else
     begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
     end;
    end;
   end;
  finally
   if GetCapture = Handle then ReleaseCapture;
  end;
 end;
end;

procedure TvtCustomImageForm.MouseLoop_MouseMove(X, Y: Integer; ACursorPos: TPoint;
                                                 var FirstTime: Boolean;
                                                 var FocusRect: TRect;
                                                 OriginalRect:TRect);
var
 DC: HDC;
 p: TPoint;
 Msg: TMsg;
 PaintFocusRect: TRect;
begin
 p := ClientToScreen(Point(x, y));
 if (Abs(ACursorPos.X - p.x) <= DragTolerance) and
    (Abs(ACursorPos.Y - p.y) <= DragTolerance) then
  Exit;

 with GetParentForm(self) do
 begin
  if not GetDragFullWindows then
  begin
   DC := GetDC(0);

   try
    if FirstTime then
     DraggingForm := True
    else
    begin
     DrawFocusRect(DC, LastFocusRect); { Hide previous focus rect }
    end;
    FocusRect := Rect(ACursorPos.x - x, ACursorPos.y - y, ACursorPos.x - x + Width, ACursorPos.y - y + Height);
    if TForm(GetParentForm(self)).FormStyle = fsMDIChild then
    begin
     PaintFocusRect:= FocusRect;
     PaintFocusRect.Left:= PaintFocusRect.Left + ClientToScreen(Point(0,0)).x - Left;
     PaintFocusRect.Top:= PaintFocusRect.Top+ ClientToScreen(Point(0,0)).y - Top;
     PaintFocusRect.Right:= PaintFocusRect.Left+ Width;
     PaintFocusRect.Bottom:= PaintFocusRect.Top + Height;
    end
    else
     PaintFocusRect:= FocusRect;
    DrawFocusRect(DC, PaintFocusRect);
    LastFocusRect:= PaintFocusRect;
    FirstTime:= False;
   finally
    ReleaseDC(0, DC);
   end;
  end
  else
  begin
   DraggingForm := True;
   sleep(10);
   while PeekMessage(Msg, Handle, WM_MOUSEMOVE, WM_MOUSEMOVE, PM_REMOVE) do;
   GetCursorPos(ACursorPos);
   SetWindowPos(Handle, 0, ACursorPos.x - x, ACursorPos.y - y, 0, 0,
                SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
  end;
 end;
end;

procedure TvtCustomImageForm.MouseLoop_MouseUp(X, Y: Integer; ACursorPos: TPoint;
                                               OriginalRect, FocusRect: TRect);
var
 DC: HDC;
begin
 if not DraggingForm then Exit;
 DraggingForm:= False;

 with GetParentForm(self) do
 begin
  if not GetDragFullWindows then
  begin
   DC := GetDC(0);
   try
    DrawFocusRect(DC, LastFocusRect);
   finally
    ReleaseDC(0, DC);
   end;

   SetWindowPos(Handle, 0, FocusRect.Left, FocusRect.top, 0, 0, SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);

   if GetCapture = Handle then ReleaseCapture;
  end;
 end;
end;

procedure TvtCustomImageForm.SetParent(Value: TWinControl);
begin
 if (Value <> nil) and not (Value is TCustomForm) then
  Value := GetParentForm(Value);

 inherited SetParent(value);

 if Parent <> nil then
  SetWindowLong(Parent.Handle, GWL_STYLE, GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);

 if Value <> Nil then TForm(Value).BorderStyle := bsNone;

 if (Value<>nil) and
    (FCaptureMessageClass = nil) and
    not (csDesigning in ComponentState) then
  begin
   fCaptureMessageClass := TvtCaptureMessageClass.Create(Owner);
   fCaptureMessageClass.WindowHandle := Value.Handle;
   fCaptureMessageClass.Enabled := True;
   fCaptureMessageClass.OnBeforeWndProc := BeforeFormWndProc;
   fCaptureMessageClass.OnWndProc := AfterFormWndProc;
  end;
end;

procedure TvtCustomImageForm.ApplyBitmapRegion;
begin
 SetWindowRgn(GetParentForm(self).Handle, 0, False);
 if FRegion <> 0 then DeleteObject(FRegion);

 FRegion := vtCreateRegionFromBitmap(Picture.Bitmap, GetTransparentColor);
 if not (csDesigning in ComponentState) then
  SetWindowRgn(GetParentForm(self).Handle, FRegion, True);
end;

function TvtCustomImageForm.GetPicture: TPicture;
begin
 Result := inherited Picture;
end;

procedure TvtCustomImageForm.Paint;
begin
 if FRegion = 0 then ApplyBitmapRegion;
 Inherited;
end;

function TvtCustomImageForm.GetTransparentColor: TColor;
begin
 Result := fTransparentColor;
 if FTransparentColor=clNone then
 begin
  if (Picture.Bitmap <> Nil) then
   Result := Picture.Bitmap.Canvas.Pixels[0,Picture.Bitmap.height-1]
 end
 else
  Result := fTransparentColor;
end;

procedure TvtCustomImageForm.SetPicture(Value: TPicture);
begin
 inherited Picture := Value;

 if (Value <> nil) and (Value.Width > 0) and (Value.height > 0) then
 begin
  (Parent as TCustomForm).ClientWidth := Value.Width;
  (Parent as TCustomForm).ClientHeight := Value.Height;
 end;

 Invalidate;
end;

procedure TvtCustomImageForm.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
 inherited;
 // Added to support autosizing of the form
 if AutoSize then
  with GetParentForm(self) do
  begin
   ClientWidth := AWidth;
   ClientHeight := AHeight;
  end;
end;

procedure TvtCustomImageForm.DrawFocusRect(DC: HDC; FocusRect: TRect);
begin
 Windows.DrawFocusRect(DC, FocusRect);
 InflateRect(FocusRect, -1, -1);
 Windows.DrawFocusRect(DC, FocusRect);
 InflateRect(FocusRect, -1, -1);
 Windows.DrawFocusRect(DC, FocusRect);
end;

procedure TvtCustomImageForm.SetCaptionBarControl(Value: TControl);
begin
 if Value <> FCaptionBarControl then
  FCaptionBarControl:= Value;
end;

{TvtCaptureMessageClass}
constructor TvtCaptureMessageClass.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 FOldWndHandler := nil;
 FWndHandlerPtr := nil;
 FWinControl := nil;
 FWndHandle := 0;
 FEnabled := false;
end;

destructor TvtCaptureMessageClass.Destroy;
begin
 Enabled := False;
 inherited Destroy;
end;

procedure TvtCaptureMessageClass.EndSubClass;
begin
 if IsWindow(FWndHandle) then
 begin
  SetWindowLong(FWndHandle, GWL_WNDPROC, LongInt(FOldWndHandler));
  FOldWndHandler := nil;
 end;
 if FWndHandlerPtr <> nil then
  FreeObjectInstance(FWndHandlerPtr);
 fEnabled := false;
end;

procedure TvtCaptureMessageClass.NewWndProc(var Message: TMessage);
begin
 WndProc(Message);
end;

procedure TvtCaptureMessageClass.SetEnabled(aValue: Boolean);
begin
 if fEnabled <> aValue then
 begin
  fEnabled := aValue;
  if fEnabled then
   StartSubClass
  else
   EndSubClass;
 end;
end;

procedure TvtCaptureMessageClass.SetWndControl(Value: TWinControl);
begin
 if Value <> FWinControl then
 if Value is TWinControl then
 begin
  FWinControl := Value;
  WindowHandle := FWinControl.Handle;
 end;
end;

procedure TvtCaptureMessageClass.SetWndHandle(Value: Hwnd);
begin
 if FWndHandle <> 0 then EndSubClass;
 FWndHandle := Value;
 if (FWndHandle <> 0) and FEnabled then StartSubClass;
end;

procedure TvtCaptureMessageClass.StartSubClass;
begin
 if IsWindow(FWndHandle) then
 begin
  FOldWndHandler := Pointer(GetWindowLong(FWndHandle,	GWL_WNDPROC));
  FWndHandlerPtr := MakeObjectInstance(NewWndProc);
  if FWndHandlerPtr = nil then
   raise EOutOfResources.Create('OutOfResources');
  SetWindowLong(FWndHandle, GWL_WNDPROC, LongInt(FWndHandlerPtr));
  FEnabled := true;
 end;
end;

procedure TvtCaptureMessageClass.WndProc(var Message: TMessage);
var
 lProcessMessage : Boolean;
begin
 if Assigned(FOnBeforeWndProc) then
 begin
  FOnBeforeWndProc(Message, lProcessMessage);
  if not lProcessMessage then exit;
 end;

 with Message do
  Result := CallWindowProc(FOldWndHandler, FWndHandle, Msg, wParam, lParam);

 if Assigned(FOnWndProc) then FOnWndProc(Message);
end;

end.
