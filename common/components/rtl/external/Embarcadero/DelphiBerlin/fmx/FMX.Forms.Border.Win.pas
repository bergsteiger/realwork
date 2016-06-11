{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Forms.Border.Win;

interface

{$SCOPEDENUMS ON}

uses
  Winapi.Messages, Winapi.Windows, System.Types, System.Classes, System.UITypes,
  System.UIConsts, System.Generics.Collections, FMX.Forms, FMX.Platform, FMX.Types,
  FMX.Forms.Border, FMX.Menus, FMX.Controls, FMX.Graphics;

type
  TWindowBorderWin = class(TStyledWindowBorder)
  private
    FCaptionBuffer: TBitmap;
    FCaptionBufferHandle: THandle;
    FCaptionBufferBitmap: THandle;
    FCaptionBufferBits: Pointer;
    FBottomBorder: TControl;
    FBottomBuffer: TBitmap;
    FBottomBufferHandle: THandle;
    FBottomBufferBitmap: THandle;
    FBottomBufferBits: Pointer;
    FLeftBorder: TControl;
    FLeftBuffer: TBitmap;
    FLeftBufferHandle: THandle;
    FLeftBufferBitmap: THandle;
    FLeftBufferBits: Pointer;
    FRightBorder: TControl;
    FRightBuffer: TBitmap;
    FRightBufferHandle: THandle;
    FRightBufferBitmap: THandle;
    FRightBufferBits: Pointer;
    FCurrentCanvas: TCanvas;
    FIcon: THandle;
    FSaveIconPos: TPointF;
    FSaveTitlePadding: TPointF;
    FNCClick: Boolean;
    FMenuBar: TMenuBar;
    FUpdating: Integer;
    FMenuMap: TDictionary<TFmxHandle, TMenuItem>;
    function GetTopOffset: Integer;
    procedure InvalidateRegion;
    procedure RecreateRegion;
    procedure Paint;
    procedure UpdateWnd;
    procedure DoPaint;
    procedure ResizeCaptionBuffer(const R: TRectF);
    procedure ResizeBottomBuffer(const R: TRectF);
    procedure ResizeLeftBuffer(const R: TRectF);
    procedure ResizeRightBuffer(const R: TRectF);
    procedure FillBitmapInfo(var BitmapInfo: TBitmapInfo; const Width, Height: Integer);
    procedure PaintCaption(const DC: HDC);
    procedure PaintBottom(const DC: HDC);
    procedure PaintLeft(const DC: HDC);
    procedure PaintRight(const DC: HDC);
    procedure UpdateButtonsState;
    function GetWndSize: TSize; inline;
    function GetWnd: HWnd; inline;
    procedure ResizeMenuBar;
  protected
    function GetFormSize: TSizeF; override;
    procedure Resize; override;
    procedure Invalidate; override;
    procedure DoAddUpdateRect(R: TRectF); override;
    function GetCanvas: TCanvas; override;
    function GetClientMargins: TRectF; override;
    procedure DoApplyStyle; override;
    procedure StyleChanged; override;
    function GetStyleLookup: string; override;
    property WndSize: TSize read GetWndSize;
    property Wnd: HWnd read GetWnd;
  public
    constructor Create(const AForm: TCommonCustomForm); override;
    destructor Destroy; override;
    procedure CreateOSMenu(const AMenu: IItemsContainer);
    function HandleExists(const Handle: TFmxHandle): Boolean;
    procedure RemoveHandle(const Handle: TFmxHandle);
    property NCClick: Boolean read FNCClick;
  end;

function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
function WMNCMessages(AForm: TCommonCustomForm; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;

implementation

uses
  System.Messaging, System.Variants, System.SysUtils, System.Math, System.StrUtils, Winapi.CommDlg, Winapi.ActiveX, 
  Winapi.ShlObj, Winapi.MMSystem, Winapi.ShellAPI, Winapi.MultiMon, Winapi.Imm, Winapi.UxTheme, FMX.Consts,
  FMX.ExtCtrls, FMX.Objects, FMX.Layouts, FMX.StdCtrls, FMX.Edit, FMX.TextLayout, FMX.Text, FMX.Helpers.Win,
  FMX.Platform.Win, FMX.Utils;

{ Window }

type
  PRgnRects = ^TRgnRects;
  TRgnRects = array [0 .. 0] of TRect;

{ Nonclient area }

type
  TOpenControl = class(TControl);
  TOpenCommonCustomForm = class(TCommonCustomForm);

constructor TWindowBorderWin.Create(const AForm: TCommonCustomForm);
begin
  inherited Create(AForm);
  FCaptionBuffer := TBitmap.Create(0, 0);
  FBottomBuffer := TBitmap.Create(0, 0);
  FLeftBuffer := TBitmap.Create(0, 0);
  FRightBuffer := TBitmap.Create(0, 0);
  FMenuMap := TDictionary<TFmxHandle, TMenuItem>.Create;
end;

destructor TWindowBorderWin.Destroy;
begin
  FreeAndNil(FCaptionBuffer);
  if FCaptionBufferHandle <> 0 then
    DeleteDC(FCaptionBufferHandle);
  if FCaptionBufferBitmap <> 0 then
    DeleteObject(FCaptionBufferBitmap);
  FCaptionBufferBits := nil;

  FreeAndNil(FBottomBuffer);
  if FBottomBufferHandle <> 0 then
    DeleteDC(FBottomBufferHandle);
  if FBottomBufferBitmap <> 0 then
    DeleteObject(FBottomBufferBitmap);
  FBottomBufferBits := nil;

  FreeAndNil(FLeftBuffer);
  if FLeftBufferHandle <> 0 then
    DeleteDC(FLeftBufferHandle);
  if FLeftBufferBitmap <> 0 then
    DeleteObject(FLeftBufferBitmap);
  FLeftBufferBits := nil;

  FreeAndNil(FRightBuffer);
  if FRightBufferHandle <> 0 then
    DeleteDC(FRightBufferHandle);
  if FRightBufferBitmap <> 0 then
    DeleteObject(FRightBufferBitmap);
  FRightBufferBits := nil;

  FreeAndNil(FMenuMap);
  inherited;
end;

procedure TWindowBorderWin.CreateOSMenu(const AMenu: IItemsContainer);
  procedure InsertItems(Parent: TFmxObject; Item: TMenuItem);
  var
    I: Integer;
    Child: IItemsContainer;
    NewItem: TMenuItem;
    Handle: TFmxHandle;
  begin
    if not Item.Visible then
      Exit;
    NewItem := TMenuItem.Create(Self);
    NewItem.BeginUpdate;
    try
      NewItem.Bitmap := Item.Bitmap;
      NewItem.Text := Item.Text;
      NewItem.ShortCut := Item.ShortCut;
      NewItem.OnClick := Item.OnClick;
      NewItem.Enabled := Item.Enabled;
      NewItem.IsChecked := Item.IsChecked;
      NewItem.Parent := Parent;
      NewItem.Action := Item.Action;
      NewItem.Tag := Item.Tag;
    finally
      NewItem.EndUpdate;
    end;
    Handle := TFmxHandle(NewItem);
    (Item as INativeControl).Handle := Handle;
    FMenuMap.Add(Handle, NewItem);
    if Supports(Item, IItemsContainer, Child) and (Child.GetItemsCount > 0) then
      for I := 0 to Child.GetItemsCount - 1 do
        if Child.GetItem(I) is TMenuItem then
          InsertItems(NewItem, TMenuItem(Child.GetItem(I)));
  end;
var
  I: Integer;
begin
  FUpdating := FUpdating + 1;
  try
    if FMenuBar = nil then
    begin
      FMenuBar := TMenuBar.Create(Self);
      FMenuBar.StyleLookup := 'mainmenustyle';  // do not localize
      FMenuBar.Parent := Self;
      FMenuBar.Align := TAlignLayout.None;
      FMenuBar.Stored := False;
      FMenuBar.Locked := True;
    end;
    ResizeMenuBar;
    for I := 0 to AMenu.GetItemsCount - 1 do
      if (AMenu.GetItem(I) is TMenuItem) and TMenuItem(AMenu.GetItem(I)).Visible then
        InsertItems(FMenuBar, TMenuItem(AMenu.GetItem(I)));
  finally
    FUpdating := FUpdating - 1;
  end;
  UpdateWnd;
end;

procedure TWindowBorderWin.ResizeMenuBar;
begin
  if FMenuBar <> nil then
    FMenuBar.SetBounds(FLeftBuffer.Width / Form.Handle.Scale, FCaptionBuffer.Height / Form.Handle.Scale - FMenuBar.Height,
      (FCaptionBuffer.Width - FRightBuffer.Width - FLeftBuffer.Width) / Form.Handle.Scale, FMenuBar.Height);
end;

function TWindowBorderWin.GetCanvas: TCanvas;
begin
  Result := FCurrentCanvas;                 
end;

function TWindowBorderWin.GetTopOffset: Integer;
var
  M: THandle;
  MonInfo: TMonitorInfo;
begin
  M := MonitorFromPoint(Point(Form.Left + Form.Width div 2, Form.Top + Form.Height div 2), MONITOR_DEFAULTTONEAREST);
  MonInfo.cbSize := SizeOf(MonInfo);
  GetMonitorInfo(M, @MonInfo);
  if Form.Top < MonInfo.rcWork.Top then
    Result := MonInfo.rcWork.Top - Form.Top
  else
    Result := 0;
end;

function TWindowBorderWin.GetWnd: HWnd;
begin
  Result := WindowHandleToPlatform(Form.Handle).Wnd;
end;

function TWindowBorderWin.GetWndSize: TSize;
begin
  Result := WindowHandleToPlatform(Form.Handle).WndBounds.Size;
end;

function TWindowBorderWin.HandleExists(const Handle: TFmxHandle): Boolean;
begin
  Result := FMenuMap.ContainsKey(Handle);
end;

procedure TWindowBorderWin.RemoveHandle(const Handle: TFmxHandle);
begin
  FUpdating := FUpdating + 1;
  try
    TFmxObject(Pointer(Handle)).Free
  finally
    FUpdating := FUpdating - 1;
    FMenuMap.Remove(Handle);
  end;
end;

procedure TWindowBorderWin.Paint;
var
  I: Integer;
  Control: TControl;
begin
  if IsSupported then
  begin
    if GetCanvas.BeginScene then
    try
      GetCanvas.Clear(0);
      for I := 0 to ChildrenCount - 1 do
        if (Children[I] is TControl) and (TControl(Children[I]).Visible or
            (not TControl(Children[I]).Visible and (csDesigning in ComponentState) and not TControl(Children[I]).Locked)) then
        begin
          Control := TControl(Children[I]);
          if Control.UpdateRect.IsEmpty then
            Continue;
          TOpenControl(Control).PaintInternal;
        end;
    finally
      GetCanvas.EndScene;
    end;
  end;
end;

procedure TWindowBorderWin.UpdateButtonsState;
begin
  if FTitleObject is TText then
    TText(FTitleObject).Text := Form.Caption;
  if Form.WindowState = TWindowState.wsMaximized then
  begin
    if FMinObject <> nil then
    begin
      if FMinObject.AbsoluteRect.Top < GetTopOffset then
      begin
        FMinObject.Margins.Top := GetTopOffset - FMinObject.AbsoluteRect.Top;
        if FMinObject.AbsoluteRect.Bottom > FCaptionBuffer.Height then
          FMinObject.Margins.Top := FMinObject.Margins.Top - (FMinObject.AbsoluteRect.Bottom - FCaptionBuffer.Height);
      end;
    end;
    if FResObject <> nil then
    begin
      FResObject.Visible := True;
      if (FMaxObject <> nil) and FMaxObject.Visible then
        FResObject.Position.X := FMaxObject.Position.X;
      if FResObject.AbsoluteRect.Top < GetTopOffset then
      begin
        FResObject.Margins.Top := GetTopOffset - FResObject.AbsoluteRect.Top;
        if FResObject.AbsoluteRect.Bottom > FCaptionBuffer.Height then
          FResObject.Margins.Top := FResObject.Margins.Top - (FResObject.AbsoluteRect.Bottom - FCaptionBuffer.Height);
      end;
    end;
    if FMaxObject <> nil then
    begin
      FMaxObject.Visible := False;
      if FMaxObject.AbsoluteRect.Top < GetTopOffset then
      begin
        FMaxObject.Margins.Top := GetTopOffset - FMaxObject.AbsoluteRect.Top;
        if FMaxObject.AbsoluteRect.Bottom > FCaptionBuffer.Height then
          FMaxObject.Margins.Top := FMaxObject.Margins.Top - (FMaxObject.AbsoluteRect.Bottom - FCaptionBuffer.Height);
      end;
    end;
    if FCloseObject <> nil then
    begin
      if FCloseObject.AbsoluteRect.Top < GetTopOffset then
      begin
        FCloseObject.Margins.Top := GetTopOffset - FCloseObject.AbsoluteRect.Top;
        if FCloseObject.AbsoluteRect.Bottom > FCaptionBuffer.Height then
          FCloseObject.Margins.Top := FCloseObject.Margins.Top - (FCloseObject.AbsoluteRect.Bottom - FCaptionBuffer.Height);
      end;
      // only on most right button
      FCloseObject.Margins.Right := FRightBuffer.Width;
    end;
    if FTitleObject <> nil then
    begin
      if FTitleObject.AbsoluteRect.Top < GetTopOffset then
      begin
        FTitleObject.Margins.Top := FSaveTitlePadding.Y + (GetTopOffset - FTitleObject.AbsoluteRect.Top);
        if FTitleObject.AbsoluteRect.Bottom > FCaptionBuffer.Height then
          FTitleObject.Margins.Top := FTitleObject.Margins.Top - (FTitleObject.AbsoluteRect.Bottom - FCaptionBuffer.Height);
      end;
      FTitleObject.Margins.Left := FSaveTitlePadding.X + FLeftBuffer.Width;
      if (FIconObject <> nil) and (FTitleObject <> nil) then
        FTitleObject.Margins.Left := FTitleObject.Margins.Left + FIconObject.Width;
    end;
    if FIconObject <> nil then
    begin
      if FIconObject.AbsoluteRect.Top < GetTopOffset then
      begin
        FIconObject.Position.Y := FSaveIconPos.Y + (GetTopOffset - FIconObject.AbsoluteRect.Top);
        if FIconObject.AbsoluteRect.Bottom > FCaptionBuffer.Height then
          FIconObject.Position.Y := FSaveIconPos.Y - (FIconObject.AbsoluteRect.Bottom - FCaptionBuffer.Height);
      end;
      FIconObject.Position.X := FSaveIconPos.X + FLeftBuffer.Width;
    end;
  end
  else
  begin
    if FMinObject <> nil then
      FMinObject.Margins.Top := 0;
    if FMaxObject <> nil then
    begin
      FMaxObject.Visible := True;
      FMaxObject.Margins.Top := 0;
      if (FResObject <> nil) and FResObject.Visible then
        FMaxObject.Position.X := FResObject.Position.X;
    end;
    if FResObject <> nil then
    begin
      FResObject.Visible := False;
      FResObject.Margins.Top := 0;
    end;
    if FCloseObject <> nil then
    begin
      FCloseObject.Margins.Top := 0;
      FCloseObject.Margins.Right := 0;
    end;
    if FTitleObject <> nil then
    begin
      FTitleObject.Margins.Top := FSaveTitlePadding.Y;
      FTitleObject.Margins.Left := FSaveTitlePadding.X;
      if (FIconObject <> nil) and (FTitleObject <> nil) then
        FTitleObject.Margins.Left := FTitleObject.Margins.Left + FIconObject.Width;
    end;
    if FIconObject <> nil then
      FIconObject.Position.Point := FSaveIconPos;
  end;
end;

procedure TWindowBorderWin.PaintCaption(const DC: HDC);
const
  IconSize = 16;
var
  I: Integer;
  Map: TBitmapData;
  IconRect: TRectF;
  IntIconRect: TRect;
  SaveLeftWidth, SaveRightWidth: Single;
begin
  FCurrentCanvas := FCaptionBuffer.Canvas;
  FResourceLink.Position.Point := TPointF.Zero;
  if FLeftBorder <> nil then
  begin
    SaveLeftWidth := FLeftBorder.Width;
    FLeftBorder.Width := FLeftBuffer.Width / Form.Handle.Scale;
  end
  else
    SaveLeftWidth := 0;
  if FRightBorder <> nil then
  begin
    SaveRightWidth := FRightBorder.Width;
    FRightBorder.Width := FRightBuffer.Width / Form.Handle.Scale;
  end
  else
    SaveRightWidth := 0;
  try
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    if FCaptionBuffer.Map(TMapAccess.Read, Map) then
    try
      if Map.Pitch <> FCaptionBuffer.Width * 4 then
      begin
        for I := 0 to FCaptionBuffer.Height - 1 do
          Move(PAlphaColorArray(Map.Data)[I * (Map.Pitch div 4)], PAlphaColorArray(FCaptionBufferBits)[I * FCaptionBuffer.Width], FCaptionBuffer.Width * 4);
      end
      else
        Move(Map.Data^, FCaptionBufferBits^, FCaptionBuffer.Width * FCaptionBuffer.Height * 4);
      // draw icon
      if FIconObject <> nil then
      begin
        if FIcon = 0 then
          FIcon := SendMessage(Wnd, WM_GETICON, ICON_SMALL, 0);
        if FIcon = 0 then
          FIcon := SendMessage(Wnd, WM_GETICON, ICON_BIG, 0);
        if FIcon = 0 then
          FIcon := LoadIcon(MainInstance, 'MAINICON');
        if FIcon = 0 then
          FIcon := LoadIcon(0, IDI_APPLICATION);
        if FIcon <> 0 then
        begin
          IconRect := TRectF.Create(0, 0, IconSize * Form.Handle.Scale, IconSize * Form.Handle.Scale);
          IconRect.Offset(FIconObject.Position.Point * Form.Handle.Scale);
          IntIconRect := IconRect.Round;

          DrawIconEx(FCaptionBufferHandle, IntIconRect.Left, IntIconRect.Top, FIcon, IntIconRect.Width,
            IntIconRect.Width, 0, 0, DI_NORMAL);
        end;
      end;
      // draw caption
      BitBlt(DC, 0, 0, FCaptionBuffer.Width, FCaptionBuffer.Height, FCaptionBufferHandle, 0, 0, SRCCOPY);
    finally
      FCaptionBuffer.Unmap(Map);
    end;
  finally
    if FLeftBorder <> nil then
      FLeftBorder.Width := SaveLeftWidth;
    if FRightBorder <> nil then
      FRightBorder.Width := SaveRightWidth;
  end;
end;

procedure TWindowBorderWin.PaintLeft(const DC: HDC);
var
  I: Integer;
  Map: TBitmapData;
  SaveWidth: Single;
begin
  FCurrentCanvas := FLeftBuffer.Canvas;
  FResourceLink.Position.Point := TPointF.Zero;
  if FLeftBorder <> nil then
  begin
    SaveWidth := FLeftBorder.Width;
    FLeftBorder.Width := FLeftBuffer.Width / Form.Handle.Scale;
  end
  else
    SaveWidth := 0;
  try
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    if FLeftBuffer.Map(TMapAccess.Read, Map) then
    try
      if Map.Pitch <> FLeftBuffer.Width * 4 then
      begin
        for I := 0 to FLeftBuffer.Height - 1 do
          Move(PAlphaColorArray(Map.Data)[I * (Map.Pitch div 4)], PAlphaColorArray(FLeftBufferBits)[I * FLeftBuffer.Width], FLeftBuffer.Width * 4);
      end
      else
        Move(Map.Data^, FLeftBufferBits^, FLeftBuffer.Width * FLeftBuffer.Height * 4);
      BitBlt(DC, 0, FCaptionBuffer.Height, FLeftBuffer.Width, FLeftBuffer.Height - FCaptionBuffer.Height, FLeftBufferHandle, 0, FCaptionBuffer.Height, SRCCOPY);
    finally
      FLeftBuffer.Unmap(Map);
    end;
  finally
    if FLeftBorder <> nil then
      FLeftBorder.Width := SaveWidth;
  end;
end;

procedure TWindowBorderWin.PaintRight(const DC: HDC);
var
  I: Integer;
  Map: TBitmapData;
  SaveWidth: Single;
begin
  FCurrentCanvas := FRightBuffer.Canvas;
  FResourceLink.Position.Point := TPointF.Create(-FormSize.Width + FRightBuffer.Width / Form.Handle.Scale, 0);
  if FRightBorder <> nil then
  begin
    SaveWidth := FRightBorder.Width;
    FRightBorder.Width := FRightBuffer.Width / Form.Handle.Scale;
  end
  else
    SaveWidth := 0;
  try
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    if FRightBuffer.Map(TMapAccess.Read, Map) then
    try
      if Map.Pitch <> FRightBuffer.Width * 4 then
      begin
        for I := 0 to FRightBuffer.Height - 1 do
          Move(PAlphaColorArray(Map.Data)[I * (Map.Pitch div 4)], PAlphaColorArray(FRightBufferBits)[I * FRightBuffer.Width], FRightBuffer.Width * 4);
      end
      else
        Move(Map.Data^, FRightBufferBits^, FRightBuffer.Width * FRightBuffer.Height * 4);
      BitBlt(DC, WndSize.Width - FRightBuffer.Width, FCaptionBuffer.Height, FRightBuffer.Width, FRightBuffer.Height - FCaptionBuffer.Height, FRightBufferHandle, 0, FCaptionBuffer.Height, SRCCOPY);
    finally
      FRightBuffer.Unmap(Map);
    end;
  finally
    if FRightBorder <> nil then
      FRightBorder.Width := SaveWidth;
  end;
end;

procedure TWindowBorderWin.PaintBottom(const DC: HDC);
var
  I: Integer;
  Map: TBitmapData;
  SaveHeight: Single;
begin
  FCurrentCanvas := FBottomBuffer.Canvas;
  FResourceLink.Position.Point := TPointF.Create(0, -FormSize.Height + FBottomBuffer.Height / Form.Handle.Scale);
  if FBottomBorder <> nil then
  begin
    SaveHeight := FBottomBorder.Height;
    FBottomBorder.Height := FBottomBuffer.Height / Form.Handle.Scale;
  end
  else
    SaveHeight := 0;
  try
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    if FBottomBuffer.Map(TMapAccess.Read, Map) then
    try
      if Map.Pitch <> FBottomBuffer.Width * 4 then
      begin
        for I := 0 to FBottomBuffer.Height - 1 do
          Move(PAlphaColorArray(Map.Data)[I * (Map.Pitch div 4)], PAlphaColorArray(FBottomBufferBits)[I * FBottomBuffer.Width], FBottomBuffer.Width * 4);
      end
      else
        Move(Map.Data^, FBottomBufferBits^, FBottomBuffer.Width * FBottomBuffer.Height * 4);
      BitBlt(DC, FLeftBuffer.Width, WndSize.Height - FBottomBuffer.Height, FBottomBuffer.Width - FLeftBuffer.Width - FRightBuffer.Width,
        FBottomBuffer.Height, FBottomBufferHandle, FLeftBuffer.Width, 0, SRCCOPY);
    finally
      FBottomBuffer.Unmap(Map);
    end;
  finally
    if FBottomBorder <> nil then
      FBottomBorder.Height := SaveHeight;
  end;
end;

procedure TWindowBorderWin.DoPaint;
var
  DC: HDC;
  SaveDisableAlign: Boolean;
begin
  if (FCaptionBufferBits = nil) or (Wnd = 0) or (FUpdating > 0) or (FResourceLink = nil) then
    Exit;

  DC := GetWindowDC(Wnd);
  FUpdating := FUpdating + 1;
  SaveDisableAlign := FDisableAlign;
  FDisableAlign := True;
  try
    UpdateButtonsState;

    ExcludeClipRect(DC, FLeftBuffer.Width, FCaptionBuffer.Height, WndSize.Width - FRightBuffer.Width,
      WndSize.Height - FBottomBuffer.Height);

    PaintCaption(DC);
    PaintLeft(DC);
    PaintRight(DC);
    PaintBottom(DC);
  finally
    FResourceLink.Position.Point := PointF(0, 0);
    FDisableAlign := SaveDisableAlign;
    FUpdating := FUpdating - 1;
    FCurrentCanvas := FCaptionBuffer.Canvas;
    ReleaseDC(Wnd, DC);
  end;
end;

procedure TWindowBorderWin.InvalidateRegion;
var
  I: Integer;
  SaveDisableAlign: Boolean;
  Control: IControl;
begin
  if FCaptionBufferBits = nil then Exit;
  if Wnd = 0 then Exit;
  if FResourceLink = nil then Exit;
  if FUpdating > 0 then Exit;

  FUpdating := FUpdating + 1;
  SaveDisableAlign := FDisableAlign;
  FDisableAlign := True;
  try
    if FMaskObject <> nil then
    begin
      for I := 0 to FResourceLink.ChildrenCount - 1 do
        if Supports(FResourceLink.Children[I], IControl, Control) then
          Control.Visible := False;
      FMaskObject.Visible := True;
      FMaskObject.SetBounds(0, 0, FResourceLink.Width, FResourceLink.Height);
    end;
    // paint caption
    FCurrentCanvas := FCaptionBuffer.Canvas;
    FResourceLink.Position.Point := TPointF.Zero;
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    // paint left
    FCurrentCanvas := FLeftBuffer.Canvas;
    FResourceLink.Position.Point := TPointF.Zero;
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    // paint right
    FCurrentCanvas := FRightBuffer.Canvas;
    FResourceLink.Position.Point := TPointF.Create(-FResourceLink.Width + (FRightBuffer.Width / Form.Handle.Scale), 0);
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
    // paint bottom
    FCurrentCanvas := FBottomBuffer.Canvas;
    FResourceLink.Position.Point := TPointF.Create(0, -FResourceLink.Height + (FBottomBuffer.Height / Form.Handle.Scale));
    TOpenControl(FResourceLink).RecalcUpdateRect;
    Paint;
  finally
    if FMaskObject <> nil then
    begin
      for I := 0 to FResourceLink.ChildrenCount - 1 do
        if Supports(FResourceLink.Children[I], IControl, Control) then
          Control.Visible := True;
      FMaskObject.Visible := False;
    end;
    FResourceLink.Position.Point := PointF(0, 0);
    FDisableAlign := SaveDisableAlign;
    FUpdating := FUpdating - 1;
    FCurrentCanvas := FCaptionBuffer.Canvas;
  end;
end;

var
  Rts: array [0..5000] of TRect;

function CreateRegionDataFromBitmap(const Bitmap: TBitmap; var RgnData: PRgnData; Left, Top: integer): HRgn;
var
  J, I, I1: integer;
  C: TAlphaColorRec;
  Count: integer;
  Map: TBitmapData;
begin
  Result := 0;
  if Bitmap.IsEmpty then Exit;

  Count := 0;
  if Bitmap.Map(TMapAccess.Read, Map) then
  try
    for J := 0 to Bitmap.Height - 1 do
    begin
      I := -1;
      while I < Bitmap.Width do
      begin
        repeat
          Inc(I);
          if I >= Bitmap.Width then Break;
          C := TAlphaColorRec(Map.GetPixel(I, J));
        until not (C.A = 0);

        if I >= Bitmap.Width then Break;

        I1 := I;
        repeat
          Inc(I1);
          if (I1 >= Bitmap.Width) Then Break;
          C := TAlphaColorRec(Map.GetPixel(I1, J));
        until (C.A = 0);

        if I <> I1 then
        begin
          Rts[Count] := Rect(Left + I, Top + J, Left + I1, Top + J + 1);
          Inc(Count);
        end;
        I := I1;
      end;
    end;
  finally
    Bitmap.Unmap(Map);
  end;
  { Make Region data }
  Result := Count * SizeOf(TRect);
  GetMem(Rgndata, SizeOf(TRgnDataHeader) + Result);
  RgnData^.rdh.dwSize := SizeOf(TRgnDataHeader);
  RgnData^.rdh.iType := RDH_RECTANGLES;
  RgnData^.rdh.nCount := Count;
  RgnData^.rdh.nRgnSize := 0;
  RgnData^.rdh.rcBound := Rect(0, 0, Bitmap.Width, Bitmap.Height);
  { Update New Region }
  Move(Rts, RgnData^.Buffer, Result);
  Result := SizeOf(TRgnDataHeader) + Count * SizeOf(TRect);
end;

function CreateRegionFromBitmap(const Bitmap: TBitmap; Left, Top: integer): HRgn;
var
  RgnData: PRgnData;
  Size: integer;
begin
  RgnData := nil;
  Size := CreateRegionDataFromBitmap(Bitmap, RgnData, Left, Top);
  Result := ExtCreateRegion(nil, Size, RgnData^);
  if RgnData <> nil then FreeMem(RgnData, Size);
end;

procedure TWindowBorderWin.RecreateRegion;
var
  R: TRectF;
  WindowBorder: TWindowBorderWin;
  R1, Region: HRgn;
begin
  if (csDesigning in Form.ComponentState) then
    Exit;
  if not (Form.Border.WindowBorder is TWindowBorderWin) then
    Exit;
  WindowBorder := TWindowBorderWin(Form.Border.WindowBorder);
  if (WindowBorder = nil) or not WindowBorder.IsSupported then
    Exit;
  // paint to FM FBuffer
  WindowBorder.InvalidateRegion;
  // create region
  R := WindowBorder.ClientMargins;
  Region := CreateRectRgn(Trunc(R.Left * Form.Handle.Scale), Trunc(R.Top * Form.Handle.Scale),
    Ceil((FResourceLink.Width - R.Right) * Form.Handle.Scale), Ceil((FResourceLink.Height - R.Bottom) * Form.Handle.Scale));
  R1 := CreateRegionFromBitmap(WindowBorder.FCaptionBuffer, 0, 0);
  CombineRgn(Region, Region, R1, RGN_OR);
  DeleteObject(R1);
  R1 := CreateRegionFromBitmap(WindowBorder.FBottomBuffer, 0, Ceil((FResourceLink.Height - R.Bottom) * Form.Handle.Scale));
  CombineRgn(Region, Region, R1, RGN_OR);
  DeleteObject(R1);
  R1 := CreateRegionFromBitmap(WindowBorder.FLeftBuffer, 0, 0);
  CombineRgn(Region, Region, R1, RGN_OR);
  DeleteObject(R1);
  R1 := CreateRegionFromBitmap(WindowBorder.FRightBuffer, Ceil((FResourceLink.Width - R.Right) * Form.Handle.Scale), 0);
  CombineRgn(Region, Region, R1, RGN_OR);
  DeleteObject(R1);
  // set region
  SetWindowRgn(Wnd, Region, False);

  WindowBorder.DoPaint;
end;

procedure TWindowBorderWin.FillBitmapInfo(var BitmapInfo: TBitmapInfo; const Width, Height: Integer);
begin
  FillChar(BitmapInfo, SizeOf(BitmapInfo), 0);
  BitmapInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  BitmapInfo.bmiHeader.biPlanes := 1;
  BitmapInfo.bmiHeader.biBitCount := 32;
  BitmapInfo.bmiHeader.biCompression := BI_RGB;
  BitmapInfo.bmiHeader.biWidth := Width;
  if BitmapInfo.bmiHeader.biWidth <= 0 then
    BitmapInfo.bmiHeader.biWidth := 1;
  BitmapInfo.bmiHeader.biHeight := -Height;
  if BitmapInfo.bmiHeader.biHeight >= 0 then
    BitmapInfo.bmiHeader.biHeight := -1;
end;

procedure TWindowBorderWin.ResizeCaptionBuffer(const R: TRectF);
var
  BitmapInfo: TBitmapInfo;
begin
  if FCaptionBufferHandle <> 0 then
    DeleteDC(FCaptionBufferHandle);
  if FCaptionBufferBitmap <> 0 then
    DeleteObject(FCaptionBufferBitmap);
  FCaptionBufferBits := nil;

  FCaptionBuffer.BitmapScale := Form.Handle.Scale;
  FCaptionBuffer.SetSize(WndSize.Width, Ceil(R.Top * FCaptionBuffer.BitmapScale));
  FillBitmapInfo(BitmapInfo, FCaptionBuffer.Width, FCaptionBuffer.Height);
  try
    FCaptionBufferBitmap := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, FCaptionBufferBits, 0, 0);
    FCaptionBufferHandle := CreateCompatibleDC(0);
  except
    raise;
  end;
  if FCaptionBufferHandle = 0 then
    RaiseLastOSError;
  if SelectObject(FCaptionBufferHandle, FCaptionBufferBitmap) = 0 then
    RaiseLastOSError;
  FCurrentCanvas := FCaptionBuffer.Canvas;
end;

procedure TWindowBorderWin.ResizeLeftBuffer(const R: TRectF);
var
  BitmapInfo: TBitmapInfo;
begin
  if FLeftBufferHandle <> 0 then
    DeleteDC(FLeftBufferHandle);
  if FLeftBufferBitmap <> 0 then
    DeleteObject(FLeftBufferBitmap);
  FLeftBufferBits := nil;

  FLeftBuffer.BitmapScale := Form.Handle.Scale;
  FLeftBuffer.SetSize(Ceil(R.Left * FLeftBuffer.BitmapScale), WndSize.Height);
  FillBitmapInfo(BitmapInfo, FLeftBuffer.Width, FLeftBuffer.Height);
  try
    FLeftBufferBitmap := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, FLeftBufferBits, 0, 0);
    FLeftBufferHandle := CreateCompatibleDC(0);
  except
    raise;
  end;
  if FLeftBufferHandle = 0 then
    RaiseLastOSError;
  if SelectObject(FLeftBufferHandle, FLeftBufferBitmap) = 0 then
    RaiseLastOSError;
end;

procedure TWindowBorderWin.ResizeRightBuffer(const R: TRectF);
var
  BitmapInfo: TBitmapInfo;
begin
  if FRightBufferHandle <> 0 then
    DeleteDC(FRightBufferHandle);
  if FRightBufferBitmap <> 0 then
    DeleteObject(FRightBufferBitmap);
  FRightBufferBits := nil;

  FRightBuffer.BitmapScale := Form.Handle.Scale;
  FRightBuffer.SetSize(Ceil(R.Right * FLeftBuffer.BitmapScale), WndSize.Height);
  FillBitmapInfo(BitmapInfo, FRightBuffer.Width, FRightBuffer.Height);
  try
    FRightBufferBitmap := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, FRightBufferBits, 0, 0);
    FRightBufferHandle := CreateCompatibleDC(0);
  except
    raise;
  end;
  if FRightBufferHandle = 0 then
    RaiseLastOSError;
  if SelectObject(FRightBufferHandle, FRightBufferBitmap) = 0 then
    RaiseLastOSError;
end;

procedure TWindowBorderWin.ResizeBottomBuffer(const R: TRectF);
var
  BitmapInfo: TBitmapInfo;
begin
  if FBottomBufferHandle <> 0 then
    DeleteDC(FBottomBufferHandle);
  if FBottomBufferBitmap <> 0 then
    DeleteObject(FBottomBufferBitmap);
  FBottomBufferBits := nil;

  FBottomBuffer.BitmapScale := Form.Handle.Scale;
  FBottomBuffer.SetSize(WndSize.Width, Ceil(R.Bottom * Form.Handle.Scale));
  FillBitmapInfo(BitmapInfo, FBottomBuffer.Width, FBottomBuffer.Height);
  try
    FBottomBufferBitmap := CreateDIBSection(0, BitmapInfo, DIB_RGB_COLORS, FBottomBufferBits, 0, 0);
    FBottomBufferHandle := CreateCompatibleDC(0);
  except
    raise;
  end;
  if FBottomBufferHandle = 0 then
    RaiseLastOSError;
  if SelectObject(FBottomBufferHandle, FBottomBufferBitmap) = 0 then
    RaiseLastOSError;
end;

procedure TWindowBorderWin.Resize;
var
  R: TRectF;
begin
  if IsSupported then
  begin
    Realign;
    R := ClientMargins;

    ResizeCaptionBuffer(R);
    ResizeBottomBuffer(R);
    ResizeLeftBuffer(R);
    ResizeRightBuffer(R);
    ResizeMenuBar;

    RecreateRegion;
  end;
end;

function TWindowBorderWin.GetClientMargins: TRectF;
begin
  Result := inherited;
  if FMenuBar <> nil then
    Result.Top := Result.Top + FMenuBar.Height;
end;

function TWindowBorderWin.GetFormSize: TSizeF;
begin
  Result := WindowHandleToPlatform(Form.Handle).BoundsF.Size;
end;

function TWindowBorderWin.GetStyleLookup: string;
begin
  case Form.BorderStyle of
    TFmxFormBorderStyle.ToolWindow, TFmxFormBorderStyle.SizeToolWin: Result := 'toolwindowstyle';
  else
    Result := 'windowborderstyle';
  end;
end;

procedure TWindowBorderWin.UpdateWnd;
var
  R: TRect;
begin
  if InitThemeLibrary and not UseThemes then
    SetWindowLong(Wnd, GWL_STYLE, GetWindowLong(Wnd, GWL_STYLE) and not WS_CAPTION);
  GetWindowRect(Wnd, R);
  SetWindowPos(Wnd, 0, R.Left, R.Top, R.Width, R.Height, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or
    SWP_NOSENDCHANGING or SWP_FRAMECHANGED);
end;

procedure TWindowBorderWin.Invalidate;
begin
  DoAddUpdateRect(TRectF.Create(0, 0, Form.Width, Form.Height));
end;

procedure TWindowBorderWin.DoAddUpdateRect(R: TRectF);
var
  Msg: TMsg;
begin
  if FUpdating > 0 then Exit;
  if Form.Handle = nil then Exit;

  if not PeekMessage(Msg, Wnd, WM_NCADDUPDATERECT, WM_NCADDUPDATERECT, PM_NOREMOVE) then
    PostMessage(Wnd, WM_NCADDUPDATERECT, 0, 0);
end;

procedure TWindowBorderWin.DoApplyStyle;
begin
  inherited;
  if FIconObject <> nil then
    FSaveIconPos := FIconObject.Position.Point;
  if FTitleObject <> nil then
    FSaveTitlePadding := FTitleObject.Margins.Rect.TopLeft;
  FLeftBorder := TControl(FResourceLink.FindStyleResource('left'));
  FRightBorder := TControl(FResourceLink.FindStyleResource('right'));
  FBottomBorder := TControl(FResourceLink.FindStyleResource('bottom'));

  Resize;
  UpdateWnd;
end;

procedure TWindowBorderWin.StyleChanged;
begin
  inherited;
  if (Form.Border.WindowBorder <> nil) and Form.Border.WindowBorder.IsSupported then
    TOpenCommonCustomForm(Form).ResizeHandle
  else if (Form <> nil) and (Form.Handle <> nil) then
    SetWindowRgn(Wnd, 0, True);
end;

function SystemHitTest(wParam: WPARAM): Boolean;
begin
  Result := (wParam = HTCAPTION) or (wParam = HTTOP) or (wParam = HTBOTTOM) or (wParam = HTLEFT) or (wParam = HTRIGHT) or
    (wParam = HTCLIENT) or (wParam = HTTOPLEFT) or (wParam = HTTOPRIGHT) or (wParam = HTBOTTOMLEFT) or (wParam = HTBOTTOMRIGHT) or
    (wParam = HTSYSMENU);
end;

function WMNCMessages(AForm: TCommonCustomForm; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  WindowBorder: TWindowBorderWin;

  procedure ProcessNCUpdateMessages;
  var
    Msg: TMsg;
  begin
    while PeekMessage(Msg, WindowHandleToPlatform(AForm.Handle).Wnd, WM_NCADDUPDATERECT, WM_NCADDUPDATERECT, PM_REMOVE) do
    begin
      if Msg.Message = WM_QUIT then
      begin
        { Repost WM_QUIT messages }
        PostQuitMessage(Msg.wParam);
        break;
      end;
    end;
  end;
var
  NCCalcSizeParams: PNCCalcSizeParams;
  HitObject: IControl;
  P: TPoint;
  R: TRect;
  TopLeftRect,  TopRightRect,
  BottomLeftRect, BottomRightRect,
  TopRect, LeftRect, RightRect, BottomRect: TRectF;
begin
  Result := 0;
  if AForm.Handle = nil then
    Exit;
  if AForm.BorderStyle = TFmxFormBorderStyle.None then
    Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));
  if (csDesigning in AForm.ComponentState) then
    Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));
  if not (AForm.Border.WindowBorder is TWindowBorderWin) then
    Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));
  WindowBorder := TWindowBorderWin(AForm.Border.WindowBorder);
  if (WindowBorder = nil) or not WindowBorder.IsSupported or not AForm.Border.IsSupported then
    Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));

  case uMsg of
    WM_NCACTIVATE:
      begin
        Result := 1;
      end;
    WM_NCHITTEST:
      begin
        GetCursorPos(P);
        R := WindowBorder.ClientMargins.Round;
        HitObject := WindowBorder.ObjectAtPoint(PointF(P.X, P.Y));
        if HitObject <> nil then
        begin
          if SameText(HitObject.GetObject.StyleName, 'client') then
            Result := HTCLIENT
          else if SameText(HitObject.GetObject.StyleName, 'icon') then
            Result := HTSYSMENU
          else if SameText(HitObject.GetObject.StyleName, 'left') and (AForm.BorderStyle in [TFmxFormBorderStyle.Sizeable, TFmxFormBorderStyle.SizeToolWin]) then
            Result := HTLEFT
          else if SameText(HitObject.GetObject.StyleName, 'right') and (AForm.BorderStyle in [TFmxFormBorderStyle.Sizeable, TFmxFormBorderStyle.SizeToolWin]) then
            Result := HTRIGHT
          else if SameText(HitObject.GetObject.StyleName, 'top') and (AForm.BorderStyle in [TFmxFormBorderStyle.Sizeable, TFmxFormBorderStyle.SizeToolWin]) then
            Result := HTTOP
          else if SameText(HitObject.GetObject.StyleName, 'bottom') and (AForm.BorderStyle in [TFmxFormBorderStyle.Sizeable, TFmxFormBorderStyle.SizeToolWin]) then
            Result := HTBOTTOM
          else if SameText(HitObject.GetObject.StyleName, 'caption') then
            Result := HTCAPTION
          else
            Result := HTBORDER;
        end
        else
        begin
          TopLeftRect := TRectF.Create(0, 0, R.Left, R.Top);
          TopRightRect := TRectF.Create(AForm.Width - R.Right, 0, AForm.Width, R.Top);
          BottomLeftRect := TRectF.Create(0, AForm.Height - R.Bottom, R.Left, AForm.Height);
          BottomRightRect := TRectF.Create(AForm.Width - R.Right, AForm.Height - R.Bottom, AForm.Width, AForm.Height);
          TopRect := TRectF.Create(TopLeftRect.Right, 0, TopRightRect.Left, R.Top);
          LeftRect := TRectF.Create(0, TopLeftRect.Bottom, R.Left, BottomLeftRect.Top);
          RightRect := TRectF.Create(AForm.Width - R.Right, TopRightRect.Bottom, AForm.Width, BottomRightRect.Top);
          BottomRect := TRectF.Create(BottomLeftRect.Right, AForm.Height - R.Bottom, BottomRightRect.Left, AForm.Height);
          if (AForm.BorderStyle in [TFmxFormBorderStyle.Sizeable, TFmxFormBorderStyle.SizeToolWin])  then
          begin
            if TopLeftRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTTOPLEFT
            else if TopRightRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTTOPRIGHT
            else if BottomLeftRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTBOTTOMLEFT
            else if BottomRightRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTBOTTOMRIGHT
            else if LeftRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTLEFT
            else if RightRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTRIGHT
            else if BottomRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTBOTTOM
            else if TopRect.Contains((WindowBorder as IScene).ScreenToLocal(PointF(P.X, P.Y))) then
              Result := HTTOP
          end else
            Result := HTCLIENT;
        end;
      end;
    WM_NCMOUSEMOVE:
      begin
        GetCursorPos(P);
        if SystemHitTest(wParam) then
        begin
          WindowBorder.MouseLeave;
          Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));
        end;
        WindowBorder.MouseMove(KeysToShiftState(wParam), P.X, P.Y);
      end;
    WM_MOUSEMOVE:
      begin
        GetCursorPos(P);
        WindowBorder.MouseMove(KeysToShiftState(wParam), P.X, P.Y);
      end;
    WM_NCLBUTTONDOWN:
      begin
        if SystemHitTest(wParam) then
          Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));
        GetCursorPos(P);
        WindowBorder.FNCClick := True;
        WindowBorder.MouseDown(TMouseButton.mbLeft, KeysToShiftState(wParam), P.X, P.Y);
      end;
    WM_NCLBUTTONUP:
      begin
        WindowBorder.FNCClick := False;
        if SystemHitTest(wParam) then
          Exit(DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam));
        GetCursorPos(P);
        WindowBorder.MouseUp(TMouseButton.mbLeft, KeysToShiftState(wParam), P.X, P.Y);
      end;
    WM_LBUTTONUP:
      begin
        GetCursorPos(P);
        WindowBorder.FNCClick := False;
        WindowBorder.MouseUp(TMouseButton.mbLeft, KeysToShiftState(wParam), P.X, P.Y);
      end;
    WM_MOUSELEAVE:
      begin
        WindowBorder.MouseLeave;
      end;
    WM_NCCALCSIZE:
      begin
        if wParam > 0 then
        begin
          NCCalcSizeParams := PNCCalcSizeParams(lParam);
          Inc(NCCalcSizeParams.rgrc[0].Left, WindowBorder.FLeftBuffer.Width);
          Inc(NCCalcSizeParams.rgrc[0].Top, WindowBorder.FCaptionBuffer.Height);
          Dec(NCCalcSizeParams.rgrc[0].Right, WindowBorder.FRightBuffer.Width);
          Dec(NCCalcSizeParams.rgrc[0].Bottom, WindowBorder.FBottomBuffer.Height);
          Result := 0;
        end
        else
          Result := DefWindowProc(WindowHandleToPlatform(AForm.Handle).Wnd, uMsg, wParam, lParam);
      end;
    WM_NCADDUPDATERECT:
      begin
        ProcessNCUpdateMessages;
        WindowBorder.DoPaint;
      end;
    WM_NCPAINT:
      begin
        WindowBorder.DoPaint;
      end;
  else
    Result := 0;
  end
end;

function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
begin
  Result := TWindowBorderWin.Create(AForm);
end;

end.
