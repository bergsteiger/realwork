{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.Taskbar;

interface

uses
  System.Classes, System.SysUtils, Winapi.Windows, Winapi.ShlObj, Generics.Collections;

type
  TWinTaskbar = class
  private
    TaskbarList: ITaskbarList;
    TaskbarList2: ITaskbarList2;
    TaskbarList3: ITaskbarList3;
    TaskbarList4: ITaskBarList4;
    FLastError: HResult;
    FMainWindow: HWND;
    procedure CheckITB;
    procedure CheckITB2;
    procedure CheckITB3;
    procedure CheckITB4;
    function ReadMainWindow: HWND;
  protected
    procedure InitTaskbarSupport;
    function HrInit: Boolean;
  public
    constructor Create;

    // ITaskbarList
    function ActivateTab(AHwnd: HWND): Boolean;
    function AddTab(AHwnd: HWND): Boolean;
    function DeleteTab(AHwnd: HWND): Boolean;
    function SetActiveAlt(AHwnd: HWND): Boolean;

    //ITaskBarList2
    function MarkFullscreenWindow(AHwnd: HWND; AFullscreen: BOOL): Boolean;

    //ITaskBarList3
    function RegisterTab(ATabHandle: HWND): boolean;
    function SetOverlayIcon(AIcon: HICON; ADescription: String): Boolean;
    function SetProgressState(AState: Integer): Boolean; overload;
    function SetProgressValue(ACompleted, ATotal: UInt64): Boolean; overload;
    function SetProgressState(AHwndTab: HWND; AState: Integer): Boolean; overload;
    function SetProgressValue(AHwndTab: HWND; ACompleted, ATotal: UInt64): Boolean; overload;
    function SetTabActive(AHwndTab: HWND): Boolean;
    function SetTabOrder(AHwndTab: HWND; AHwndInsertBefore: HWND = 0): Boolean;
    function SetThumbnailClip(AClipRect: TRect): Boolean; overload;
    function SetThumbnailClip(AWindow:HWND; AClipRect: TRect): Boolean; overload;
    function ClearThumbnailClip: Boolean; overload;
    function ClearThumbnailClip(AWindow:HWND): Boolean; overload;
    function SetThumbnailTooltip(ATip: string): Boolean; overload;
    function SetThumbnailTooltip(AWindow:HWND; ATip: string): Boolean; overload;
    function ClearThumbnailTooltip: Boolean;
    function ThumbBarAddButtons(AButtonList: array of THUMBBUTTON; ATabHandle: HWND = 0): Boolean;
    function ThumbBarSetImageList(AHwnd: HWND; AImageList: THandle): Boolean;
    function ThumbBarUpdateButtons(AButtonList: array of THUMBBUTTON; ATabHandle: HWND = 0): Boolean;
    function UnregisterTab(AHwndTab: HWND): Boolean;

    //ITaskBarList4
    function SetTabProperties(AHwndTab: HWND; AStpFlags: STPFLAG): boolean;

    property LastError: HResult read FLastError;
    property MainWindow: HWND read ReadMainWindow write FMainWindow;
  end;

  ETaskbarException = class(Exception);

implementation

uses
  System.Win.ComObj, Winapi.DwmApi, Winapi.Messages, System.RTLConsts, Winapi.Activex;

function TWinTaskbar.ActivateTab(AHwnd: HWND): Boolean;
begin
  CheckITB;
  FLastError := TaskbarList.ActivateTab(aHwnd);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.AddTab(AHwnd: HWND): Boolean;
begin
  CheckITB;
  FLastError := TaskbarList.AddTab(aHwnd);
  Result := Succeeded(FLastError);
end;

procedure TWinTaskbar.CheckITB;
begin
  if TaskbarList = nil then
    raise ETaskbarException.CreateFmt(SItaskbarInterfaceException,['ITaskbarList']); // Do not localize
end;

procedure TWinTaskbar.CheckITB2;
begin
  if TaskbarList2 = nil then
    raise ETaskbarException.CreateFmt(SItaskbarInterfaceException,['ITaskbarList2']); // Do not localize
end;

procedure TWinTaskbar.CheckITB3;
begin
  if TaskbarList3 = nil then
    raise ETaskbarException.CreateFmt(SItaskbarInterfaceException,['ITaskbarList3']); // Do not localize
end;

procedure TWinTaskbar.CheckITB4;
begin
  if TaskbarList4 = nil then
    raise ETaskbarException.CreateFmt(SItaskbarInterfaceException,['ITaskbarList4']); // Do not localize
end;

function TWinTaskbar.ClearThumbnailClip: Boolean;
begin
  Result := ClearThumbnailClip(MainWindow);
end;

function TWinTaskbar.ClearThumbnailClip(AWindow: HWND): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetThumbnailClip(AWindow, nil);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.ClearThumbnailTooltip: Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetThumbnailTooltip(MainWindow, nil);
  Result := Succeeded(FLastError);
end;

constructor TWinTaskbar.Create;
begin
  InitTaskbarSupport;
  if not HrInit then
    raise ETaskbarException.CreateFmt(sInitializeException, [LastError]);
end;

function TWinTaskbar.DeleteTab(AHwnd: HWND): Boolean;
begin
  CheckITB;
  FLastError := TaskbarList.DeleteTab(AHwnd);
  Result := FLastError = S_OK;
end;

function TWinTaskbar.HrInit: Boolean;
begin
  CheckITB;
  FLastError := TaskbarList.HrInit;
  Result := Succeeded(FLastError);
end;

procedure TWinTaskbar.InitTaskbarSupport;
begin
  TaskbarList := CreateComObject(CLSID_TaskbarList) as ITaskbarList;
  Supports(TaskbarList, IID_ITaskbarList2, TaskbarList2);
  Supports(TaskbarList, IID_ITaskbarList3, TaskbarList3);
  Supports(TaskbarList, IID_ITaskbarList4, TaskbarList4);
end;

function TWinTaskbar.MarkFullscreenWindow(AHwnd: HWND; AFullscreen: BOOL): Boolean;
begin
  CheckITB2;
  FLastError := TaskbarList2.MarkFullscreenWindow(AHwnd, AFullscreen);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.ReadMainWindow: HWND;
begin
  if FMainWindow = 0 then
  begin
    FMainWindow := GetActiveWindow;
    if GetWindow(FMainWindow, GW_OWNER) <> 0 then
      FMainWindow := GetWindow(FMainWindow, GW_OWNER);
  end;
  Result := FMainWindow;
end;

function TWinTaskbar.RegisterTab(ATabHandle: HWND): boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.RegisterTab(ATabHandle, MainWindow);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetActiveAlt(AHwnd: HWND): Boolean;
begin
  CheckITB;
  FLastError := TaskbarList.SetActiveAlt(AHwnd);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetOverlayIcon(AIcon: HICON; ADescription: String): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetOverlayIcon(MainWindow, AIcon, PWideChar(ADescription));
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetProgressState(AState: Integer): Boolean;
begin
  Result := SetProgressState(MainWindow, AState);
end;

function TWinTaskbar.SetProgressValue(ACompleted, ATotal: UInt64): Boolean;
begin
  Result := SetProgressValue(MainWindow, ACompleted, ATotal);
end;

function TWinTaskbar.SetProgressState(AHwndTab: HWND; AState: Integer): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetProgressState(MainWindow, AState);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetProgressValue(AHwndTab: HWND; ACompleted, ATotal: UInt64): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetProgressValue(MainWindow, ACompleted, ATotal);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetTabActive(AHwndTab: HWND): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetTabActive(AHwndTab, MainWindow, 0);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetTabOrder(AHwndTab, AHwndInsertBefore: HWND): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetTabOrder(AHwndTab, AHwndInsertBefore);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetTabProperties(AHwndTab: HWND;
  AStpFlags: STPFLAG): boolean;
begin
  CheckITB4;
  FLastError := TaskbarList4.SetTabProperties(AHwndTab, AStpFlags);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetThumbnailClip(AClipRect: TRect): Boolean;
begin
  Result := SetThumbnailClip(MainWindow, AClipRect);
end;

function TWinTaskbar.SetThumbnailClip(AWindow:HWND; AClipRect: TRect): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetThumbnailClip(AWindow, @AClipRect);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetThumbnailTooltip(AWindow: HWND; ATip: string): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.SetThumbnailTooltip(AWindow, PWideChar(ATip));
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.SetThumbnailTooltip(ATip: string): Boolean;
begin
  Result := SetThumbnailTooltip(MainWindow, ATip);
end;

function TWinTaskbar.ThumbBarAddButtons(AButtonList: array of THUMBBUTTON; ATabHandle: HWND = 0): Boolean;
begin
  CheckITB3;
  if ATabHandle = 0 then
    ATabHandle := MainWindow;
  FLastError := TaskbarList3.ThumbBarAddButtons(ATabHandle, Length(AButtonList), @AButtonList);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.ThumbBarSetImageList(AHwnd: HWND; AImageList: THandle): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.ThumbBarSetImageList(AHwnd, AImageList);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.ThumbBarUpdateButtons(AButtonList: array of THUMBBUTTON; ATabHandle: HWND = 0): Boolean;
begin
  CheckITB3;
  if ATabHandle = 0 then
    FLastError := TaskbarList3.ThumbBarUpdateButtons(MainWindow, Length(AButtonList), @AButtonList)
  else
    FLastError := TaskbarList3.ThumbBarUpdateButtons(ATabHandle, Length(AButtonList), @AButtonList);
  Result := Succeeded(FLastError);
end;

function TWinTaskbar.UnregisterTab(AHwndTab: HWND): Boolean;
begin
  CheckITB3;
  FLastError := TaskbarList3.UnregisterTab(AHwndTab);
  Result := Succeeded(FLastError);
end;

end.
