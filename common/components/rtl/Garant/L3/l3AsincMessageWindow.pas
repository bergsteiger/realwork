unit l3AsincMessageWindow;
{* ����� ������������� ���� � ���������� � ��������� ������ }

// $Id: l3AsincMessageWindow.pas,v 1.27 2014/04/21 17:50:30 lulin Exp $

// $Log: l3AsincMessageWindow.pas,v $
// Revision 1.27  2014/04/21 17:50:30  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.26  2014/04/21 17:21:28  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.25  2012/11/01 09:42:57  lulin
// - ����� ����� � �������.
//
// Revision 1.24  2012/11/01 07:45:08  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.23  2011/11/08 17:10:45  lulin
// - ��������� �� ������� �����.
//
// Revision 1.22  2011/10/26 18:02:22  lulin
// {RequestLink:278135821}.
// - ������ ����.
//
// Revision 1.21  2011/10/20 17:24:49  lulin
// {RequestLink:294588730}.
//
// Revision 1.20  2010/03/18 14:15:46  lulin
// {RequestLink:197951943}.
//
// Revision 1.19  2009/01/13 07:29:45  oman
// - fix: ������� ������ �� ������� (�-132222829)
//
// Revision 1.18  2008/12/19 10:44:05  oman
// - fix: ����������� ����������� ������ ������ (�-132222829)
//
// Revision 1.17  2007/08/15 13:09:32  oman
// - fix: �������� �������� � ������� ��� �������� ���� (cq26332)
//
// Revision 1.16  2007/08/14 19:31:59  lulin
// - ������������ ������� ������.
//
// Revision 1.15  2007/07/23 08:22:47  oman
// - fix: �������� �������� � ����������� ������������ (cq25771)
//
// Revision 1.14  2007/03/20 12:48:01  lulin
// - bug fix: �� ����������� ������.
// - bug fix: ����������� ��������� ������� �����.
//
// Revision 1.13  2007/03/09 11:55:58  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.12  2007/02/12 16:40:36  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.11  2007/01/22 15:20:13  oman
// - new: ����������� ��������� - l3 (cq24078)
//
// Revision 1.10  2006/12/19 13:06:10  oman
// - new: ������� ��������� � ��� ������ � ������ �������� ���
//  ������.
// - new: ����� ������ �������� ����� ���������� ���� (cq23829)
//
// Revision 1.9  2006/08/23 10:42:48  oman
// - fix: ���� ��� Application.MainForm, ������ AV (cq19589)
//
// Revision 1.8  2005/05/03 12:43:32  mmorozov
// new: ����� ��� �������� ����� ��������� � �������� ���������� TCustomImageList � ImageIndex ��� ������ ������������ ����������� � �������� ������;
//
// Revision 1.7  2005/04/28 15:04:11  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.6.2.1  2005/04/28 12:05:25  mmorozov
// - warnings fix;
// - unused variables cleaunup;
// - ��������� �������� �������� ������� ������;
//
// Revision 1.6  2005/04/20 10:06:16  mmorozov
// change: �����;
//
// Revision 1.5  2005/04/20 09:45:46  mmorozov
// new: ������� ����� �� ������ ���� ��� ������ �� ��������� ������� ������;
//
// Revision 1.4  2005/04/20 09:23:18  mmorozov
// new behaviour: �������� ���������� �������� ���� ���, �� ��� ������ ���������;
//
// Revision 1.3  2005/04/20 08:49:06  mmorozov
// new: ����� ������ ���������������, �������������� � ������������� ������� Windows. ����� ������, ����� � ������� ��������;
//
// Revision 1.2  2005/04/19 06:37:00  mmorozov
// bugfix: ����� �������� ����� ������������� ������� ���� ������� �������;
//
// Revision 1.1  2005/03/30 09:16:59  demon
// - new: ������ ��� ������ ������������� ���� � ���������� � ��������� ������
//

interface

uses
 Windows,
 Classes,
 Graphics,
 Messages,
 ImgList,

 l3Interfaces,
 l3GradientWaitbar
 ;

type
  Tl3AsincMessageWindow = class(TThread)
  {* ������������ ���� � ���������� }
   private
   // internal variables
     f_Handle          : HWND;
     f_Caption         : Il3CString;
     f_Canvas          : TCanvas;
     f_Progress        : THandle;
     f_IconSize        : TSize;
     f_IconHandle      : HICON;
     f_TextRect        : TRect;
     f_SizeExcludeText : TSize;
     f_Waitbar         : Tl3GradientWaitbar;
     f_Size            : TSize;
     f_Images          : TCustomImageList;
     f_ImageIndex      : Integer;
     f_BottomContext   : Integer;
     f_WindowOrigin: TPoint;
     f_WindowExtent: TSize;
     f_ScreenWidth: Longint;
     f_WaitTimeout: Cardinal;
     f_Attached: Boolean;
     f_InPaint: Integer;
   private
   // property methods
     procedure pm_SetCaption(const aValue : Il3CString);
       {-}
     procedure pm_SetProgress(const Value : THandle);
       {-}
   private
   // internal methods
     procedure InitDC;
       {-}
     procedure UpdateSize;
       {-}
     procedure InitFont;
       {-}
     procedure Paint;
       {-}
     function DrawTextRect : TRect;
       {-}
     procedure PaintProgress(aInitPaint : Boolean = True);
       {-}
     function ProgressRect : TRect;
       {-}
     function BottomContext : Integer;
       {-}
     procedure RegisterClass;
       {* - ������������ ����� ���� ������� ����� ���������. }
     procedure CreateWindow;
       {* - ������ ����. }
     procedure DestroyWindow;
       {* - ���������� ����. }
     procedure Show;
       {* - ����� ����. ���� ��������� �� ������ ������� Application.MainForm }
     function ContextSpace : Integer;
       {-}
     function ContextRect : TRect;
       {-}
     procedure CalcSizeExcludeText;
       {-}
     procedure CalcTextRect;
       {-}
   protected
   // protected methods
     function CalcSize : TSize;
       {* - ��������� ������ �����. }
     procedure Execute;
       override;
       {-}
   public
   // public methods
     constructor Create(const aCaption : Il3CString = nil;
                        aImages        : TCustomImageList = nil;
                        aImageIndex    : Integer = -1;
                        anAttachWnd    : THandle = 0;
                        anInitialWait  : Cardinal = 0);
       reintroduce;
       virtual;
       {-}
     destructor Destroy;
       override;
       {-}
   public
   // properties
     property Caption : Il3CString
       read f_Caption
       write pm_SetCaption;
       {-}
     property Progress : THandle
       read f_Progress
       write pm_SetProgress;
       {-}
  end;//Tl3AsincMessageWindow

procedure ActivateAllAsyncWindows(anActive: Boolean);

implementation

uses
  Controls,
  Types,
  Math,
  SysUtils,
  Forms,
  MultiMon,

  l3Base,
  l3IntegerValueMapManager,
  l3String,
  l3AsincMessageWindowRes
  ;

////////////////////////////////////////////////////////////////////////////////
const
 cClassName  = 'l3AsincMessageWindow';
   {* - ��� ��������������� ������. }
 cFrameSize = 4;
   {* - ������ �����. }
 cSpace      = 5;
   {* - ���������� ����� ����������. }
 cProgressHeight = 15;
   {* - ������ �������� ����. }
////////////////////////////////////////////////////////////////////////////////

var
 g_AllAsyncWindows: TThreadList = nil;

function WindowProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
// ������������� ���� ��� �������� �� 64 ���� - ����������� Self �������������� ����� SetWindowLong (32 ����).

 procedure lpDef;
 begin
  Result := DefWindowProc(hWnd, Msg, wParam, lParam);
 end;

var
 l_Window: Tl3AsincMessageWindow;

begin
 case Msg of
  WM_PAINT:
  begin
   l_Window := Tl3AsincMessageWindow(GetWindowLong(hWnd, GWL_USERDATA));
   if Assigned(l_Window) then
    l_Window.Paint;
   Result := 0;
  end;
  WM_DESTROY:
   begin
    PostQuitMessage(0);
    Result := 0;
   end;
  WM_CLOSE:
    SetWindowPos(hWnd, 0, 0, 0, 0, 0, SWP_HIDEWINDOW);
  else
   lpDef;
 end;
end;

// Class Tl3AsincMessageWindow

procedure Tl3AsincMessageWindow.InitFont;
begin
 Assert(f_Canvas <> nil);
 with f_Canvas.Font do
 begin
  Size := 10;
  Charset := RUSSIAN_CHARSET;
 end;//with f_Canvas.Font
end;

constructor Tl3AsincMessageWindow.Create(const aCaption : Il3CString = nil;
                                         aImages        : TCustomImageList = nil;
                                         aImageIndex    : Integer = -1;
                                         anAttachWnd    : THandle = 0;
                                         anInitialWait  : Cardinal = 0);
var
 l_Rect: TRect;
 l_Form: TCustomForm;
 l_FormHandle: THandle;
 l_MonInfo: TMonitorInfo;
begin
 inherited Create(True);
 Assert(Suspended);
 f_InPaint := 0;
 f_WaitTimeout := anInitialWait;
 f_Attached := (anAttachWnd <> 0);
 if f_Attached then
 begin
  l_FormHandle := anAttachWnd;
  if not GetWindowRect(l_FormHandle,l_Rect) then
  begin
   f_Attached := False;
  end//not GetWindowRect(l_FormHandle,l_Rect)
  else
  with l_Rect do
  begin
   f_WindowOrigin := Point(Left, Bottom);
   f_ScreenWidth := Right - Left;
   f_WindowExtent.cx := 0;
   f_WindowExtent.cy := 0;
  end;//with l_Rect
 end;//f_Attached
 if not f_Attached then
 begin
  l_Form := Application.MainForm;
  if Assigned(l_Form) then
  begin
   l_FormHandle := l_Form.Handle;
   if not GetWindowRect(l_FormHandle,l_Rect) then
   begin
    l_FormHandle := 0;
    GetWindowRect(Application.Handle,l_Rect);
   end;//not GetWindowRect(l_FormHandle,l_Rect)
  end//Assigned(l_Form)
  else
  begin
   l_FormHandle := 0;
   GetWindowRect(Application.Handle,l_Rect);
  end;//Assigned(l_Form)
  f_WindowOrigin := l_Rect.TopLeft;
  l_MonInfo.cbSize := SizeOf(l_MonInfo);
  GetMonitorInfo(MonitorFromPoint(f_WindowOrigin,MONITOR_DEFAULTTONEAREST), @l_MonInfo);
  with l_MonInfo.rcWork do
   f_ScreenWidth := Right - Left;
  if (l_FormHandle = 0) then
  begin
   f_WindowOrigin := l_MonInfo.rcWork.TopLeft;
   f_WindowExtent.cx := f_ScreenWidth;
   with l_MonInfo.rcWork do
    f_WindowExtent.cy := Bottom - Top;
  end//l_FormHandle = 0
  else
   with l_Rect do
   begin
    f_WindowExtent.cx := Right - Left;
    f_WindowExtent.cy := Bottom - Top;
   end;//with l_Rect
 end;//not f_Attached

 f_Canvas := TCanvas.Create;
 // Waitbar
 f_Waitbar := Tl3GradientWaitbar.Create;
 if not f_Attached then
 begin
  // ������� ������
  if Assigned(aImages) and (aImageIndex <> -1) and ((aImageIndex >= 0) and
   (aImageIndex < aImages.Count)) then
  begin
   f_Images      := aImages;
   f_ImageIndex  := aImageIndex;
   f_IconSize.cx := aImages.Width;
   f_IconSize.cy := aImages.Height;
  end//Assigned(aImages)..
  else
  begin
   f_IconSize.cx := GetSystemMetrics(SM_CXICON);
   f_IconSize.cy := GetSystemMetrics(SM_CYICON);
   f_IconHandle := LoadIcon(0, IDI_EXCLAMATION);
  end;//Assigned(aImages)..
 end;//not f_Attached
 // ������� ��� ������
 CalcSizeExcludeText;
 // Caption
 if aCaption <> nil then
  Caption := aCaption
 else
  Caption := str_l3mmLongOperation.AsCStr;
 // ������
 f_Size := CalcSize;
 // �������������� ������ ���������
 f_BottomContext := -1;
 f_Handle := 0;
 Resume;
end;

destructor Tl3AsincMessageWindow.Destroy;
// override;
{-}
begin
 while (f_InPaint <> 0) do
  Sleep(0);
 l3Free(f_Canvas);
 l3Free(f_Waitbar);
 f_Caption := nil;
 inherited;
end;

procedure Tl3AsincMessageWindow.CalcTextRect;
begin
 SetRectEmpty(f_TextRect);
 if not f_Attached then
 begin
  // ������������ ������ ������
  f_TextRect.Right := f_ScreenWidth div 2 - f_SizeExcludeText.cx;
  Assert(f_Canvas <> nil);
  // ������ ������
  DrawText(f_Canvas.Handle, PAnsiChar(l3Str(f_Caption)), -1, f_TextRect, DT_WORDBREAK or
   DT_CALCRECT);
 end;//not f_Attached
end;

procedure Tl3AsincMessageWindow.UpdateSize;
begin
 if f_Handle <> 0 then
 begin
  CalcTextRect;
  f_Size := CalcSize;
 end;
end;

procedure Tl3AsincMessageWindow.pm_SetCaption(const aValue : Il3CString);
{-}
begin
 if not l3Same(aValue, f_Caption) then
 begin
  f_Caption := aValue;
  UpdateSize;
 end;//not l3Same(aValue, f_Caption)
end;

procedure Tl3AsincMessageWindow.Show;
{* - ����� ����. ���� ��������� �� ������ ������� Application.MainForm }
var
 lTop  : Integer;
 lLeft : Integer;
begin
 // Waitbar
 Inc(f_InPaint);
 try
  with ProgressRect do
  begin
   Assert(f_Waitbar <> nil);
   f_Waitbar.SetBounds(0, 0, Right - Left, Bottom - Top);
  end;//ProgressRect
  f_Waitbar.Speed := 1;
 finally
  Dec(f_InPaint);
 end;//try..finally 
 // ���������
 if f_Attached then
 begin
  lTop := f_WindowOrigin.y;
  lLeft := f_WindowOrigin.x;
 end//f_Attached
 else
 begin
  lTop := f_WindowOrigin.y + ((f_WindowExtent.cy div 2) -
   (f_Size.cy div 2));
  lLeft := f_WindowOrigin.x + ((f_WindowExtent.cx div 2) -
   (f_Size.cx div 2));
 end;//f_Attached
 SetWindowPos(f_Handle, 0, lLeft, lTop, f_Size.cx, f_Size.cy, SWP_SHOWWINDOW or
  SWP_NOACTIVATE);
end;

function Tl3AsincMessageWindow.ContextRect : TRect;
begin
 if f_Attached then
  SetRectEmpty(Result)
 else
 begin
  GetClientRect(f_Handle, Result);
  OffsetRect(Result, -Result.Left, -Result.Top);
  InflateRect(Result, -ContextSpace, -ContextSpace);
 end;
end;

function Tl3AsincMessageWindow.ContextSpace : Integer;
begin
 Result := cFrameSize + cSpace;
end;

procedure Tl3AsincMessageWindow.CalcSizeExcludeText;
begin
 if not f_Attached then
 begin
  // �� �����, �� ���������
  Inc(f_SizeExcludeText.cx, ContextSpace * 2);
  Inc(f_SizeExcludeText.cy, ContextSpace * 2);
  // ������
  Inc(f_SizeExcludeText.cx, f_IconSize.cx);
  Inc(f_SizeExcludeText.cy, f_IconSize.cy);
  // ���������� �� ������
  Inc(f_SizeExcludeText.cx, cSpace);
 end
 else
 begin
  f_SizeExcludeText.cx := f_ScreenWidth;
  f_SizeExcludeText.cy := cFrameSize;
 end;
end;

function Tl3AsincMessageWindow.CalcSize : TSize;
begin
 Result := f_SizeExcludeText;
 // ��������
 // �����
 Inc(Result.cy, cFrameSize);
 // ��������
 Inc(Result.cy, cProgressHeight);
 // Caption ������
 Inc(Result.cx, f_TextRect.Right);
 // Caption ������
 if f_TextRect.Bottom > f_IconSize.cy then
 begin
  Dec(Result.cy, f_IconSize.cy);
  Inc(Result.cy, f_TextRect.Bottom);
 end;
end;

function Tl3AsincMessageWindow.BottomContext : Integer;
begin
 // ��������� ���� ���
 if f_BottomContext = -1 then
 begin
  if f_Attached then
   f_BottomContext := 0
  else
   f_BottomContext := ContextSpace + Max(f_IconSize.cy, f_TextRect.Bottom) +
    cSpace;
 end;
 //
 Result := f_BottomContext;
end;

function Tl3AsincMessageWindow.ProgressRect : TRect;
begin
 Result := Rect(0, 0, f_Size.cx, f_Size.cy);
 InflateRect(Result, -cFrameSize, -cFrameSize);
 if not f_Attached then
  Result.Top := Result.Bottom - cProgressHeight;
 InflateRect(Result, -2, -2);
end;

procedure Tl3AsincMessageWindow.PaintProgress(aInitPaint : Boolean = True);
var
 lPStruct : TPaintStruct;
begin
 Inc(f_InPaint);
 try
  if (f_Waitbar = nil) or (f_Canvas = nil) then
   Exit;
  Assert(f_Waitbar <> nil);
  f_Waitbar.BackBuf.Canvas.Lock;
  try
   f_Waitbar.ManualProgress(1);
   Assert(f_Waitbar <> nil);
   if aInitPaint then
    BeginPaint(f_Handle, lPStruct);
   try
    Assert(f_Canvas <> nil);
    with ProgressRect do
     BitBlt(f_Canvas.Handle, Left, Top, Right - Left, Bottom - Top,
      f_Waitbar.BackBuf.Canvas.Handle, 0, 0, cmSrcCopy);
   finally
    if aInitPaint then
     EndPaint(f_Handle, lPStruct);
   end;//try..finally
  finally
   Assert(f_Waitbar <> nil);
   f_Waitbar.BackBuf.Canvas.Unlock;
  end;//try..finally
 finally
  Dec(f_InPaint);
 end;//try..finally
end;

function Tl3AsincMessageWindow.DrawTextRect : TRect;
begin
 Result.Right  := f_Size.cx - ContextSpace;
 Result.Left   := Result.Right - f_TextRect.Right;
 Result.Top    := ContextSpace;
 Result.Bottom := BottomContext - cSpace;
end;

procedure Tl3AsincMessageWindow.Paint;
{-}
var
 lRect    : TRect;
 lPStruct : TPaintStruct;
 lUpdate  : Boolean;
 lFlags   : Integer;
 lY       : Integer;
begin
 Inc(f_InPaint);
 try
  if (f_Canvas = nil) then
   Exit;
  lUpdate := GetUpdateRect(f_Handle, lRect, False);
  if EqualRect(lRect, ProgressRect) then
  begin
   PaintProgress;
   Exit;
  end;//EqualRect(lRect, ProgressRect)
  // ������� ����������� ������
  GetClientRect(f_Handle, lRect);
  // �������
  if lUpdate then
   BeginPaint(f_Handle, lPStruct);
  try
   // ������
   Assert(f_Canvas <> nil);
   with f_Canvas do
   begin
    Brush.Color := clBtnFace;
    FillRect(lRect);
   end;//with f_Canvas
   // ������� �����
   Assert(f_Canvas <> nil);
   DrawEdge(f_Canvas.Handle, lRect, BDR_RAISEDINNER, BF_RECT);
   if not f_Attached then
   begin
    // ����� ���������
    InflateRect(lRect, -cFrameSize, -cFrameSize);
    lRect.Bottom := BottomContext;
    Assert(f_Canvas <> nil);
    DrawEdge(f_Canvas.Handle, lRect, BDR_SUNKENINNER, BF_RECT);
   end//not f_Attached
   else
    InflateRect(lRect, -cFrameSize, 0);
   // ����� �������� ����
   lRect.Top := BottomContext + cFrameSize;
   lRect.Bottom := lRect.Top + cProgressHeight;
   Assert(f_Canvas <> nil);
   DrawEdge(f_Canvas.Handle, lRect, BDR_SUNKENINNER, BF_RECT);
   if not f_Attached then
   begin
    // ������� ������
    lRect := ContextRect;
    // ������
    lY := ((lRect.Bottom - lRect.Top) - f_IconSize.cy) div 2;
    Assert(f_Canvas <> nil);
    if Assigned(f_Images) then
     f_Images.Draw(f_Canvas, ContextSpace, lY, f_ImageIndex)
    else
     Windows.DrawIcon(f_Canvas.Handle, ContextSpace, lY, f_IconHandle);
   end;//not f_Attached
   // ��������
   PaintProgress(False);
   if not f_Attached then
   begin
    // Caption
    if not l3IsNil(f_Caption) then
    begin
     lRect := DrawTextRect;
     if f_IconSize.cy > f_TextRect.Bottom then
     begin
      lFlags := DT_SINGLELINE or DT_VCENTER;
     end
     else
      lFlags := DT_WORDBREAK;
     Assert(f_Canvas <> nil); 
     Windows.DrawText(f_Canvas.Handle,
                      PAnsiChar(l3Str(f_Caption)),
                      -1,
                      lRect,
                      lFlags);
    end;//if not l3IsNil(f_Caption) then
   end;
  finally
   if lUpdate then
    EndPaint(f_Handle, lPStruct);
  end;//try..finally
 finally
  Dec(f_InPaint);
 end;//try..finally
end;

procedure Tl3AsincMessageWindow.RegisterClass;
{* - ������������ ����� ���� ������� ����� ���������. }
var
 l_Class: TWndClass;
begin
 if not GetClassInfo(hInstance, cClassName, l_Class) then
 begin
  l3FillChar(l_Class, SizeOf(l_Class), 0);
  l_Class.style         := CS_OWNDC or CS_NOCLOSE or CS_HREDRAW or CS_VREDRAW;
  l_Class.lpfnWndProc   := @WindowProc;
  l_Class.lpszClassName := cClassName;
  l_Class.hInstance     := hInstance;
  Windows.RegisterClass(l_Class);
 end;
end;

procedure Tl3AsincMessageWindow.InitDC;
begin
 Assert(f_Canvas <> nil);
 f_Canvas.Handle := GetDC(f_Handle);
 InitFont;
 UpdateSize;
end;

procedure Tl3AsincMessageWindow.CreateWindow;
begin
 // �������������� �����
 RegisterClass;
 // �������� ����
 f_Handle := Windows.CreateWindow(cClassName, '', WS_POPUP,
  Integer(CW_USEDEFAULT), 0, Integer(CW_USEDEFAULT), 0, 0, 0, hInstance, nil);
 SetWindowLong(f_Handle, GWL_USERDATA, Integer(Self));

 if not f_Attached then
 begin
  SetWindowPos(f_Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
    SWP_NOSIZE or SWP_NOACTIVATE);
  g_AllAsyncWindows.Add(Pointer(f_Handle));
 end;//not f_Attached

 if (f_Canvas = nil) then
  Exit;
 // DC
 InitDC;
 // ������� ����
 Show;
end;

procedure Tl3AsincMessageWindow.DestroyWindow;
begin
 if f_Handle = 0 then Exit;
 if not f_Attached then
  g_AllAsyncWindows.Remove(Pointer(f_Handle));
 SetWindowLong(f_Handle, GWL_USERDATA, 0);
 SendMessage(f_Handle, WM_PAINT, 0, 0);
 Windows.DestroyWindow(f_Handle);
end;

procedure Tl3AsincMessageWindow.Execute;
var
 l_Message : TMsg;
 l_Rect    : TRect;
 l_Time    : Cardinal;

 procedure lpProgress;
 const
  cDelay = 1;
 begin
  if (GetTickCount - cDelay >= l_Time) then
  begin
   l_Rect := ProgressRect;
   Inc(f_InPaint);
   try
    Windows.RedrawWindow(f_Handle, @l_Rect, 0, RDW_INVALIDATE);
   finally
    Dec(f_InPaint);
   end;//try..finally
   l_Time := GetTickCount;
  end;//GetTickCount - cDelay >= l_Time
 end;

begin
 while not Terminated and (f_WaitTimeout > 0) do
 begin
  Sleep(100);
  if Terminated then
   exit;
  if f_WaitTimeout > 100 then
   Dec(f_WaitTimeout, 100)
  else
  begin
   Sleep(f_WaitTimeout);
   Break;
  end;
 end;
 if Terminated then
  exit;
 if (f_Canvas = nil) then
  exit;
 CreateWindow;
 try
  if (f_Canvas = nil) then
   exit;
  l_Time := GetTickCount;
  repeat
   if Terminated then
    DestroyWindow;
   if PeekMessage(l_Message, 0, 0, 0, PM_REMOVE) then
   begin
    if (l_Message.Message = WM_QUIT) or
       ((l_Message.Message = WM_CLOSE) and
         (l_Message.hWnd = f_Handle)) then
    begin
     f_Handle := 0;
     Break;
    end;
    TranslateMessage(l_Message);
    DispatchMessage(l_Message);
   end;
   if not Terminated then
    lpProgress;
  until False;
 finally
  DestroyWindow;
 end;//try..finally
end;

procedure Tl3AsincMessageWindow.pm_SetProgress(const Value: THandle);
begin
 f_Progress := Value;
end;

procedure FinalizeAllAsyncWindows;
begin
 l3Free(g_AllAsyncWindows);
end;

procedure ActivateAllAsyncWindows(anActive: Boolean);
var
 l_IDX: Integer;
const
 cInsertAfter: array [Boolean] of HWND = (HWND_NOTOPMOST, HWND_TOPMOST);
begin
 with g_AllAsyncWindows.LockList do
 try
  for l_IDX := Count-1 downto 0 do
   SetWindowPos(THandle(Items[l_IDX]), cInsertAfter[anActive], 0, 0, 0, 0, SWP_NOMOVE or
     SWP_NOSIZE or SWP_NOACTIVATE);
 finally
  g_AllAsyncWindows.UnlockList;
 end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\L3\l3AsincMessageWindow.pas initialization enter'); {$EndIf}
 g_AllAsyncWindows := TThreadList.Create;
 l3System.AddExitProc(FinalizeAllAsyncWindows);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\L3\l3AsincMessageWindow.pas initialization leave'); {$EndIf}
end.
