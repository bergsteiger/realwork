{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

05/29/2003

  Added OnAnimationStopped event which is fired when AnimateOnce is true.

02/25/2003

  Added IconID property. It is used by Windows XP to provide possibility to show/hide icons

12/08/2002

  Added TrayInfo as an advanced hint

07/31/2002

  ExtendedHintInteractive on WinXP caused the hint window to stay when cursor goes out

06/10/2002

  Fixed compiler bug in BCB with StaticIconIndex -- reimplemented with getter function

05/26/2002

  Fixed use of UseStaticIcons property in runtime

05/15/2002

  Added StaticIcons pool for handling of static icon.

06/25/2001

  Fixed the bug with extended hint window and popup menu, that happened in
  second tray icon (i.e. when extended hint and popup menu are shown by the
  second tray icon)

  Fixed extended hint window position for taskbar layouts on the left and
  on the right sides

03/13/2001

  Fixed popup menu appearance when extended hint is visible

02/13/2001

  Click tracking improved

12/16/2000

  Now ElTrayIcon uses ElTimerPool component to reduce handles usage.

  Now if a double-click event handler is assigned, double-click on the icon
  causes ONLY OnDblClick event. No OnClick event happens in this case.

11/19/2000

  Fixed the problem, when extended hint can cause AV when invoked from or after
  CloseQuery of the main window.

09/30/2000

  ExtendedHint and related properties added.

*)

unit ElTray;

{cool tray icon}

interface

uses
  Windows,
  SysUtils,
  Messages,
  Graphics,
  Classes,
  Controls,
  Menus,
  Forms,
  ElBaseComp,
  ExtCtrls,
{$IFDEF VCL_4_USED}
  ImgList,
{$ENDIF}
  ElVCLUtils,
  ElTools,
  ElTimers,
  ElTrayInfo,
  StdCtrls,
  ElStrUtils,
  {$ifdef USE_DBUGINTF}
  dbugintf,
  {$endif}
  HTMLRender,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  ShellApi;

type
  TElTrayExtHintShowEvent = procedure(Sender : TObject; var DoShow : boolean) of object;
  TElTrayExtHintCreateEvent = procedure(Sender : TObject; FormClass : String; var Form : TForm) of object;
  TQueryEndSessionEvent   = procedure(Sender : TObject; Action : Integer; var CanClose : boolean) of object;

  TClickInfo = record
    Button : TMouseButton;
    Shift  : TShiftState;
    X, Y : Integer;
  end;

  TElTrayIcon = class;

  TElTrayInfoSettings = class(TPersistent)
  protected
    FOwner: TElTrayIcon;
    FEnabled: Boolean;
    procedure SetColor(Value: TColor);
    procedure SetInfoType(newValue: TElTrayInfoType); virtual;
    {$ifdef HAS_HTML_RENDER}
    procedure SetIsHTML(newValue: Boolean); virtual;
    function GetIsHTML: Boolean;
    {$endif}
    procedure SetMessage(newValue: TElFString); virtual;
    function GetColor: TColor;
    function GetInfoType: TElTrayInfoType;

    function GetMessage: TElFString;
    procedure SetEnabled(Value: Boolean);
    function GetFont: TFont;
    procedure SetFont(Value: TFont);
  public
    constructor Create(AOwner: TPersistent);
    procedure Assign(Source : TPersistent); override;
  published
    property Color: TColor read GetColor write SetColor default clInfoBk;
    property InfoType: TElTrayInfoType read GetInfoType write SetInfoType;
    {$ifdef HAS_HTML_RENDER}
    property IsHTML: Boolean read GetIsHTML write SetIsHTML default false;
    {$endif}
    property Message: TElFString read GetMessage write SetMessage;
    property Enabled: Boolean read FEnabled write SetEnabled default false;
    property Font: TFont read GetFont write SetFont;
  end;

  TElTrayIcon = class(TElBaseComponent)
  private
    FExtHintWndStyle : Cardinal;
    FExtHintWndExStyle : Cardinal;
    FOnBeforeExtendedHintShow : TElTrayExtHintShowEvent;
    FOnExtHintFormCreate : TElTrayExtHintCreateEvent;
    FHideTaskBarIcon : Boolean;
    FExtendedHintDelay : Cardinal;
    FOnQueryEndSession : TQueryEndSessionEvent;
    FPopupWhenModal : Boolean;
    FHint : string;
    FStaticIcon : TIcon;
    FAnimated : Boolean;
    FIcon : TIcon;
    FIcons : TImageList;
    FInterval : Integer;
    FPopupMenu : TPopupMenu;
    FClickInfo : TClickInfo;
    FClickTimer,
    FHintTimer,
    FTimer : TElTimerPoolItem;
    FTimerPool: TElTimerPool;
    FImgIdx : integer;
    FOnClick : TMouseEvent;
    FOnDblClick : TNotifyEvent;
    FOnMouseDown : TMouseEvent;
    FOnMouseUp : TMouseEvent;
    FOnMouseMove : TMouseMoveEvent;
    FOnAnimationStopped : TNotifyEvent;
    StaticChangeLink,
    MyChangeLink : TChangeLink;
    FInWndProc : boolean;
    FSet : Boolean;
    FIconData : TNotifyIconData;
    FIconID   : Cardinal; // UINT
    FLClick   : boolean;
    FMClick   : boolean;
    FRClick   : boolean;
    FExtForm  : TForm;
    FExtFormName: string;
    FExtFormPt  : TPoint;
    FHideForm   : boolean;
    FExtFormInt : boolean;
    FNoShow     : boolean;
    FOnDblClickEx: TMouseEvent;
    FStaticIcons: TImageList;
    FAnimateOnce: Boolean;
    FUseStaticIcons: Boolean;
    FStaticIconIndex: Integer;
    TrayInfoVisible : boolean;
    {$IFDEF VCL_5_USED}
    NewMenuProc,
    OldMenuProc : Pointer;
    {$ENDIF}

    procedure SetExtForm(newValue : String);
    procedure SetAnimated(newValue : Boolean);
    procedure SetDesignActive(newValue : Boolean);
    procedure SetIcons(newValue : TImageList);
    procedure SetInterval(newValue : Integer);
    procedure SetPopupMenu(newValue : TPopupMenu);
    procedure SetStaticIcon(newValue : TIcon);
    procedure OnClickTimer(Sender : TObject);
    procedure OnTimer(Sender : TObject);
    procedure OnHintTimer(Sender : TObject);
    procedure OnImagesChange(Sender : TObject);
    procedure SetHint(newValue : string);
    function  DoPopupMenu(X, Y : integer) : boolean;
    function  DoDblClick(Perform : boolean) : boolean;
    procedure SetStaticIcons(Value: TImageList);
    procedure OnStaticIconsChange(Sender : TObject);
  protected
    FTrayInfo: TElTrayInfo;
    FTrayInfoSettings: TElTrayInfoSettings;
    FOnTrayInfoImageNeeded: TElHTMLImageNeededEvent;
    FOnTrayInfoLinkClick: TElHTMLLinkClickEvent;
    procedure TriggerClickEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); virtual;
    procedure TriggerDblClickEvent; virtual;
    procedure TriggerMouseDownEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); virtual;
    procedure TriggerMouseUpEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); virtual;
    procedure TriggerMouseMoveEvent(Shift : TShiftState; X, Y : Integer); virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    {$IFDEF VCL_5_USED}
    procedure PopupMenuProc(var Message : TMessage);
    {$ENDIF}
    function HookWndProc(var Message : TMessage): Boolean;
    procedure WndProc(var Message : TMessage); override;
    procedure DoSetEnabled(AEnabled : boolean); override;
    procedure UpdateIconData(remove : boolean); virtual;
    procedure Loaded; override;
    procedure TriggerQueryEndSessionEvent(Action : Integer; var CanClose : boolean); virtual;
    procedure SetExtendedHintDelay(newValue : Cardinal); virtual;
    procedure SetHideTaskBarIcon(newValue : Boolean); virtual;
    procedure DoHideTaskBarIcon;
    procedure DoShowTaskBarIcon;
    procedure TriggerBeforeExtendedHintShowEvent(var DoShow : boolean); virtual;
    function  FindExtForm(Name : string) : TComponentClass;
    procedure TriggerDblClickExEvent(Button : TMouseButton; Shift : TShiftState; X,
        Y : Integer); virtual;
    procedure SetUseStaticIcons(Value: Boolean);
    function GetStaticIconIndex : integer;
    procedure SetStaticIconIndex(Value: Integer);
    procedure UpdateStaticIcon;
    procedure TrayInfoShowHandler(Sender : TObject);
    procedure TrayInfoHideHandler(Sender : TObject);
    procedure SetTrayInfoSettings(Value: TElTrayInfoSettings);
    function AdjustY(Y : integer): Integer;
    {$ifdef HAS_HTML_RENDER}
    procedure LinkClickTransfer(Sender: TObject; HRef: TElFString); virtual;
    procedure ImageNeededTransfer(Sender: TObject; Src: TElFString; var Image: TBitmap); virtual;
    {$endif}
    procedure TriggerAnimationStopped; virtual;
    procedure PerformIconHiding;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ShowExtForm(X, Y : Integer);
    property Handle;
    property ExtendedHintForm : TForm read FExtForm;
    property ExtHintWndStyle  : Cardinal read FExtHintWndStyle write FExtHintWndStyle;  { Public }
    property ExtHintWndExStyle: Cardinal read FExtHintWndExStyle write FExtHintWndExStyle;  { Public }
  published
    property Icons : TImageList read FIcons write SetIcons;
    property Animated : Boolean read FAnimated write SetAnimated default false;
    property DesignActive : Boolean read FDesignActive write SetDesignActive default false;
    property Interval : Integer read FInterval write SetInterval default 200;
    property PopupMenu : TPopupMenu read FPopupMenu write SetPopupMenu;
    property OnClick : TMouseEvent read FOnClick write FOnClick;
    property OnDblClick : TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseDown : TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp : TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseMove : TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property StaticIcon : TIcon read FStaticIcon write SetStaticIcon;
    property Hint : string read FHint write SetHint;
    property Enabled;
    property ExtendedHint : String read FExtFormName write SetExtForm;
    property ExtendedHintInteractive : boolean read FExtFormInt write FExtFormInt default false;
    property PopupWhenModal : Boolean read FPopupWhenModal write FPopupWhenModal
      default False;
    property OnQueryEndSession : TQueryEndSessionEvent read FOnQueryEndSession write FOnQueryEndSession;
    property ExtendedHintDelay : Cardinal read FExtendedHintDelay write SetExtendedHintDelay;
    property HideTaskBarIcon : Boolean read FHideTaskBarIcon write SetHideTaskBarIcon default False;
    property OnBeforeExtendedHintShow : TElTrayExtHintShowEvent read FOnBeforeExtendedHintShow write FOnBeforeExtendedHintShow;
    property OnExtHintFormCreate : TElTrayExtHintCreateEvent read FOnExtHintFormCreate write FOnExtHintFormCreate;
    property OnDblClickEx: TMouseEvent read FOnDblClickEx write FOnDblClickEx;
    property AnimateOnce: Boolean read FAnimateOnce write FAnimateOnce default
        false;
    property StaticIcons: TImageList read FStaticIcons write SetStaticIcons;
    property UseStaticIcons: Boolean read FUseStaticIcons write SetUseStaticIcons
        default false;
    property StaticIconIndex: Integer read GetStaticIconIndex write
        SetStaticIconIndex default -1;
    property TrayInfoSettings: TElTrayInfoSettings read FTrayInfoSettings write
        SetTrayInfoSettings;
    property IconID : Cardinal read FIconID write FIconID;
    {$ifdef HAS_HTML_RENDER}
    property OnTrayInfoImageNeeded: TElHTMLImageNeededEvent read
        FOnTrayInfoImageNeeded write FOnTrayInfoImageNeeded;
    property OnTrayInfoLinkClick: TElHTMLLinkClickEvent read FOnTrayInfoLinkClick
        write FOnTrayInfoLinkClick;
    {$endif}
    property OnAnimationStopped : TNotifyEvent read FOnAnimationStopped write FOnAnimationStopped; 
  end;

const
  TrackInterval : integer = 100;
  HideInterval  : integer = 400;

  FInMenu       : boolean = false;

implementation

const
  EL_NOTIFYICON = WM_USER + 1368;
  EL_HIDEICON   = WM_USER + 1369;

type
  {$ifndef D_2}
  TFormHack = TCustomForm;
  {$else}
  TFormHack = TForm;
  {$endif}
  TFormClass = class of TForm;

var
  WM_TaskbarRestart: UINT;

{$ifndef USE_DBUGINTF}
procedure SendDebug(const S : string);
begin
end;
{$endif}

procedure TElTrayIcon.SetAnimated(newValue : Boolean);
begin
  if (FAnimated <> newValue) then
  begin
    if csLoading in ComponentState then
      FAnimated := newValue
    else
    begin
      if (newValue and (FIcons <> nil) and (FIcons.Count > 0)) or (not NewValue) then
      begin
        if newValue then
        begin
          FImgIdx := 0;
          FIcons.GetIcon(0, FIcon);
          SendDebug('SetAnimated');
          UpdateIconData(false);
        end;
        FAnimated := newValue;
        if not FAnimated then
          FTimer.Enabled := false;
      end;
      if not FAnimated then
        UpdateStaticIcon;
      SendDebug('SetAnimated');
      UpdateIconData(false);
      if FAnimated and FSet then
      begin
        FTimer.Interval := FInterval;
        FTimer.Enabled := true;
      end;
    end;
  end; {if}
end;

procedure TElTrayIcon.SetDesignActive(newValue : Boolean);
begin
  if (FDesignActive <> newValue) then
  begin
    FDesignActive := newValue;
    if (csDesigning in ComponentState) then
    begin
      if FAnimated then
      begin
        FAnimated := false;
        Animated := true;
      end;
      SendDebug('SetDesignActive');
      UpdateIconData(not FDesignActive);
    end;
  end; {if}
end;

procedure TElTrayIcon.SetIcons(newValue : TImageList);
begin
  if (FIcons <> newValue) then
  begin
    if FIcons <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FIcons.ComponentState) then
        FIcons.RemoveFreeNotification(Self);
      {$endif}
      FIcons.UnRegisterChanges(MyChangeLink);
    end;
    FIcons := newValue;
    if NewValue <> nil then
    begin
      NewValue.FreeNotification(Self);
      NewValue.RegisterChanges(MyChangeLink);
      if Animated then
      begin
        FAnimated := false;
        Animated := true;
      end;
    end
    else
    begin
      Animated := false;
    end;
  end; {if}
end;

function TElTrayIcon.FindExtForm(Name : string) : TComponentClass;
var PersClass : TPersistentClass;
begin
  PersClass := GetClass(Name);
  if PersClass = nil then
  begin
    PersClass := GetClass('T' + Name);
    if PersClass = nil then
       raise EClassNotFound.CreateFmt('When you set ElTrayIcon.ExtendedHint to %s, be sure' +
             ' to call RegisterClass(%s) in the Initialization section ' +
             'of the unit, that contains the form.', ['T' + Name, 'T' + Name]);
  end;
  if PersClass.InheritsFrom(TForm) then
     result := TComponentClass(PersClass)
  else
     raise EInvalidCast.Create('Invalid typecast');
end;

procedure TElTrayIcon.SetExtForm(newValue : string);
begin
  if FExtFormName <> newValue then
  begin
    if (not (csDestroying in ComponentState)) and (FExtForm <> nil) and FExtForm.Visible then
      FExtForm.Hide;
    if (FExtForm <> nil) {and (newValue = '')} then
      FExtForm := nil
    else
    if (newValue <> '') then
    begin
      if (not (csDesigning in ComponentState)) and (not (csLoading in ComponentState)) then
      begin
        TrayInfoSettings.Enabled := false;
        if Assigned(OnExtHintFormCreate) then OnExtHintFormCreate(Self, newValue, FExtForm);
        if FExtForm = nil then
          FExtForm := TForm(FindExtForm(newValue).Create(Application));
      end;
    end;
    {$ifdef VCL_5_USED}
    if Assigned(FExtForm) then
      if not (csDestroying in FExtForm.ComponentState) then
        FExtForm.RemoveFreeNotification(Self);
    {$endif}
    FExtFormName := newValue;
    if Assigned(FExtForm) then
      FExtForm.FreeNotification(Self);
    if Handle <> 0 then
  	begin
      SendDebug('SetExtForm');
      UpdateIconData(false);
    end;
  end;
end;

procedure TElTrayIcon.SetInterval(newValue : Integer);
begin
  if (FInterval <> newValue) then
  begin
    FInterval := newValue;
    if FAnimated then
    begin
      FAnimated := false;
      Animated := true;
    end;
  end; {if}
end;

procedure TElTrayIcon.SetPopupMenu(newValue : TPopupMenu);
begin
  if (FPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FPopupMenu <> nil then
      if not (csDestroying in FPopupMenu.ComponentState) then
        FPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    if NewValue <> nil then
    begin
      NewValue.FreeNotification(Self);
      {$IFDEF VCL_5_USED}
      OldMenuProc := Pointer(GetWindowLong(PopupList.Window, GWL_WNDPROC));
      if NewMenuProc <> OldMenuProc then
      begin
{$warnings off}
        NewMenuProc := MakeObjectInstance(PopupMenuProc);
{$warnings on}
        SetWindowLong(PopupList.Window, GWL_WNDPROC, LongInt(NewMenuProc));
      end;
      {$ENDIF}
    end else
    begin
      {$IFDEF VCL_5_USED}
      if Assigned(OldMenuProc) and Assigned(PopupList) then
        SetWindowLong(PopupList.Window, GWL_WNDPROC, LongInt(OldMenuProc));
      if Assigned(NewMenuProc) then
{$warnings off}
        FreeObjectInstance(NewMenuProc);
{$warnings on}
      {$ENDIF}
    end;
    FPopupMenu := newValue;
  end; {if}
end;

procedure TElTrayIcon.Notification(AComponent : TComponent; Operation :
  TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = FExtForm then
    begin
      FHintTimer.Enabled := false;

      FExtForm := nil;
      FExtFormName := '';
    end;
    if AComponent = FPopupMenu then PopupMenu := nil;
    if AComponent = FIcons then
    begin
      FIcons.UnRegisterChanges(MyChangeLink);
      Icons := nil;
    end;
    if AComponent = FStaticIcons then
    begin
      FStaticIcons.UnRegisterChanges(StaticChangeLink);
      StaticIcons := nil;
    end;
  end;
end;

procedure TElTrayIcon.WndProc(var Message : TMessage);
var
  P : TPoint;
  R : TRect;
  i : DWORD;
  CanClose : boolean;
begin
  if Message.Msg = EL_NOTIFYICON then
  begin
    FInWndProc := true;
    i := GetMessagePos();
    P.X := LOWORD(i);
    P.Y := HIWORD(i);
    R := GetSysTrayRect;
    if not PtInRect(R, P) then
      GetCursorPos(P);
    case Message.LParam of //
      WM_LBUTTONDOWN :
        begin
          if FRClick then
          begin
            FRClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;
          if FMClick then
          begin
            FMClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;

          FClickTimer.Enabled := false;

          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          FLClick := true;
          TriggerMouseDownEvent(mbLeft, GetShiftState + [ssLeft], P.X, P.Y);
        end;
      WM_LBUTTONUP :
        begin
          FClickTimer.Enabled := false;

          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          if FLClick then
          begin
            FLClick := false;
            if Assigned(FOnDblClick) or DoDblClick(false) then
            begin
              FClickTimer.Interval := GetDoubleClickTime;

              FClickInfo.Button := mbLeft;
              FClickInfo.Shift := GetShiftState + [ssLeft];
              FClickInfo.X := P.X;
              FClickInfo.Y := P.Y;

              FClickTimer.Enabled := true;
            end else
              TriggerClickEvent(mbLeft, GetShiftState + [ssLeft], P.X, P.Y);
          end;
          TriggerMouseUpEvent(mbLeft, GetShiftState + [ssLeft], P.X, P.Y);
        end;
      WM_RBUTTONDOWN :
        begin
          if FLClick then
          begin
            FLClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;
          if FMClick then
          begin
            FMClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;

          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          FRClick := true;
          TriggerMouseDownEvent(mbRight, GetShiftState + [ssRight], P.X, P.Y);
        end;
      WM_RBUTTONUP :
        begin
          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
             FHintTimer.Enabled := false;
          if FRClick then
          begin
            FRClick := false;
            if not DoPopupMenu(P.X, P.Y) then
            begin
              if Assigned(FOnDblClick) or DoDblClick(false) then
              begin

                FClickTimer.Interval := GetDoubleClickTime;

                FClickInfo.Button := mbRight;
                FClickInfo.Shift := GetShiftState + [ssRight];
                FClickInfo.X := P.X;
                FClickInfo.Y := P.Y;

                FClickTimer.Enabled := true;
              end
              else
                TriggerClickEvent(mbRight, GetShiftState + [ssRight], P.X, P.Y);
            end
            else
              FHintTimer.Enabled := false;
          end;
          TriggerMouseUpEvent(mbRight, GetShiftState + [ssRight], P.X, P.Y);
        end;
      WM_MBUTTONDOWN :
        begin
          FClickTimer.Enabled := false;
          if FRClick then
          begin
            FRClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;
          if FLClick then
          begin
            FLClick := false;
            FClickTimer.Enabled := false;
            TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
          end;

          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
            FHintTimer.Enabled := false;
          TriggerMouseDownEvent(mbMiddle, GetShiftState + [ssMiddle], P.X, P.Y);
        end;
      WM_MBUTTONUP :
        begin
          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
            FHintTimer.Enabled := false;
          if Assigned(FOnDblClick) or DoDblClick(false) then
          begin
            FClickTimer.Interval := GetDoubleClickTime;

            FClickInfo.Button := mbMiddle;
            FClickInfo.Shift := GetShiftState + [ssMiddle];
            FClickInfo.X := P.X;
            FClickInfo.Y := P.Y;

            FClickTimer.Enabled := true;

          end
          else
            TriggerClickEvent(mbMiddle, GetShiftState + [ssMiddle], P.X, P.Y);

          TriggerMouseUpEvent(mbMiddle, GetShiftState + [ssMiddle], P.X, P.Y);
        end;
      WM_LBUTTONDBLCLK :
        begin
          FClickTimer.Enabled := false;
          if FHintTimer.Enabled and ((TrayInfoSettings.Enabled and not TrayInfoVisible) or ((FExtForm <> nil) and (not FExtForm.Visible))) then
            FHintTimer.Enabled := false;
          if (not FPopupWhenModal) and ModalFormVisible then
          begin
          end
          else
          if not DoDblClick(true) then
          begin
            TriggerDblClickEvent;
            TriggerDblClickExEvent(mbLeft, GetShiftState + [ssLeft], P.X, P.Y);
          end;
        end;
      WM_MBUTTONDBLCLK :
        begin
          FClickTimer.Enabled := false;
          TriggerDblClickEvent;
          TriggerDblClickExEvent(mbMiddle, GetShiftState + [ssMiddle], P.X, P.Y);
        end;
      WM_RBUTTONDBLCLK :
        begin
          FClickTimer.Enabled := false;
          TriggerDblClickEvent;
          TriggerDblClickExEvent(mbRight, GetShiftState + [ssRight], P.X, P.Y);
        end;
      WM_MOUSEMOVE :
        begin
          TriggerMouseMoveEvent(GetShiftState, P.X, P.Y);
          if not (csDesigning in ComponentState) then
          begin
            FExtFormPt := P;
            if FHideForm = true then
            begin
              FHideForm := false;
              FHintTimer.Interval := TrackInterval;
            end
            else
            if ((TrayInfoSettings.Enabled) and (not FNoShow) and (not TrayInfoVisible)) or
               ((FExtForm <> nil) and (not FExtForm.Visible) and (not FNoShow)) then
            begin
              if FExtendedHintDelay = 0 then
              begin
                {$IFDEF VCL_5_USED}
                if not FInMenu then
                {$ENDIF}
                  if TrayInfoSettings.Enabled then
                  begin
                    FTrayInfo.ShowEx(P.X, AdjustY(P.Y), true);
                    FHintTimer.Interval := TrackInterval;
                    FHintTimer.Enabled := true;
                  end
                  else
                    ShowExtForm(P.X, P.Y);
              end
              else
              begin
                FHintTimer.Interval := FExtendedHintDelay;
                FHintTimer.Enabled := true;
              end;
            end
          end;
        end;
      else
        Message.Result := DefWindowProc(FHandle, Message.Msg, Message.wParam, Message.lParam);
    end; // case
    FInWndProc := false; 
  end
  else
  if Message.Msg = WM_QUERYENDSESSION then
  begin
    Message.Result := 1;
    if Assigned(FOnQueryEndSession) then
    begin
      CanClose := true;
      FOnQueryEndSession(Self, Message.LParam, CanClose);
      if not CanClose then
        Message.Result := 0;
    end;
  end
  else
  if Message.Msg = WM_TaskbarRestart then
  begin
    if FSet then
    begin
      FSet := False;
      SendDebug('TaskbarRestart');
      UpdateIconData(False);
    end;
  end
  else
    Message.Result := DefWindowProc(FHandle, Message.Msg, Message.wParam, Message.lParam);
end;

procedure TElTrayIcon.TriggerClickEvent(Button : TMouseButton; Shift :
  TShiftState; X, Y : Integer);
begin
  if (assigned(FOnClick)) then FOnClick(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.TriggerDblClickEvent;
begin
  if (assigned(FOnDblClick)) then FOnDblClick(Self);
end;

procedure TElTrayIcon.TriggerMouseDownEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if (assigned(FOnMouseDown)) then FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.TriggerMouseUpEvent(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if (assigned(FOnMouseUp)) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.TriggerMouseMoveEvent(Shift : TShiftState; X, Y : Integer);
begin
  if (assigned(FOnMouseMove)) then OnMouseMove(Self, Shift, X, Y);
end;

procedure TElTrayIcon.DoSetEnabled(AEnabled : boolean);
begin
  if Enabled <> AEnabled then
  begin
    if AEnabled then
    begin
      inherited;
      FEnabled := true;
      if FHideTaskBarIcon and IsIconic(Application.Handle) then DoHideTaskBarIcon;
      if FAnimated then
      begin
        FAnimated := false;
        Animated := true;
      end;
      SendDebug('doSetEnabled');
      if (ComponentState * [csLoading, csReading] = []) then
        UpdateIconData(false);
    end
    else
    begin
      if FInWndProc then
        PostMessage(Self.FHandle, EL_HIDEICON, 0, 0)
      else
      begin
        PerformIconHiding;
        inherited;
      end;
    end;
  end;
end;

procedure TElTrayIcon.SetStaticIcon(newValue : TIcon);
begin
  FStaticIcon.Assign(newValue);
  if not Animated then
  begin
    FIcon.Assign(FStaticIcon);
    SendDebug('SetStaticIcon');
    UpdateIconData(false);
  end;
end;

procedure TElTrayIcon.OnImagesChange(Sender : TObject);
begin
  if Animated and (not (csLoading in ComponentState)) and ((FIcons = nil) or (FIcons.Count = 0)) then
    Animated := false;

  if (ComponentState * [csLoading, csReading] = []) then
  begin
    if not FAnimated then
      UpdateStaticIcon;
    SendDebug('OnImagesChange');
    UpdateIconData(false);
  end;
end;

procedure TElTrayIcon.OnHintTimer(Sender : TObject);
var P : TPoint;
    b : boolean;

    function MouseOnHint : boolean;
    var Wnd : HWND;
    begin
      result := false;
      Wnd := WindowFromPoint(P);
      while Wnd <> 0 do
      begin
        if (TrayInfoSettings.Enabled and (FTrayInfo.InfoForm <> nil) and (Wnd = FTrayInfo.InfoForm.Handle)) or
           (Wnd = FExtForm.Handle) then
        begin
          result := true;
          exit;
        end;
        Wnd := GetParent(Wnd);
      end;
    end;

begin
  if (FExtForm = nil) and (not TrayInfoSettings.Enabled) then
    exit;
  if TrayInfoSettings.Enabled then
  begin
    if TrayInfoVisible then
    begin
      GetCursorPos(p);
      if FHideForm then
      begin
        FHideForm := false;
        FNoShow := true;
        FTrayInfo.Hide;
        FNoShow := false;
        FHintTimer.Enabled := false;
      end
      else
      begin

        //if (FExtFormPt.x <> P.x) or (FExtFormPt.y <> P.y) then
        if (not InRange(FExtFormPt.x - 3, FExtFormPt.x + 3, P.x)) or (not InRange(FExtFormPt.y - 3, FExtFormPt.y + 3, P.y)) then
        begin
          FHideForm := true;
          FHintTimer.Enabled := false;
          FHintTimer.Enabled := true;
          FHintTimer.Interval := HideInterval div 2;
        end;
      end;
    end
    else
    begin
      FHintTimer.Enabled := false;
      {$IFDEF VCL_5_USED}
      if not FInMenu then
      {$ENDIF}
      begin
        GetCursorPos(p);
        //if (not InRange(FExtFormPt.x - 3, FExtFormPt.x + 3, P.x)) or (not InRange(FExtFormPt.y - 3, FExtFormPt.y + 3, P.y)) then
        if ((InRange(FExtFormPt.x - 16, FExtFormPt.x + 16, P.x)) and (InRange(FExtFormPt.y - 16, FExtFormPt.y + 16, P.y))) then
        begin
          FTrayInfo.ShowEx(P.X, AdjustY(P.Y), true);
          FHintTimer.Interval := TrackInterval;
          FHintTimer.Enabled := true;
        end;
      end;
      FNoShow := false;
    end;
  end
  else
  // extended form
  if FExtForm.Visible then
  begin
    GetCursorPos(p);
    if FHideForm then
    begin
      FHideForm := false;
      if (MouseOnHint or ((FExtForm <> nil) and ({Application.Active} (GetWindowThreadProcessID(GetForegroundWindow(), nil) = GetCurrentProcessID) and FExtForm.Active))) and FExtFormInt then
      begin
        FHintTimer.Interval := TrackInterval;
      end
      else
      begin
        FNoShow := true;
        FExtForm.Hide;
        FNoShow := false;
        FHintTimer.Enabled := false;
      end;
    end else
    if ((not InRange(FExtFormPt.x - 16, FExtFormPt.x + 16, P.x)) or (not InRange(FExtFormPt.y - 16, FExtFormPt.y + 16, P.y)))
    {if ((P.x <> FExtFormPt.x) or (P.y <> FExtFormPt.y)) }and (not (FExtFormInt and MouseOnHint)) then
    begin
      FHideForm := true;
      FHintTimer.Interval := HideInterval;
    end;
  end
  else
  begin
    FHintTimer.Enabled := false;
    {$IFDEF VCL_5_USED}
    if not FInMenu then
    {$ENDIF}
    begin
      GetCursorPos(p);
      if ((InRange(FExtFormPt.x - 16, FExtFormPt.x + 16, P.x)) and (InRange(FExtFormPt.y - 16, FExtFormPt.y + 16, P.y))) then
      begin

        TriggerBeforeExtendedHintShowEvent(b);
        if b then
           ShowExtForm(P.X, P.Y);
      end;
    end;
    FNoShow := false;
  end;
end;

procedure TElTrayIcon.OnClickTimer(Sender : TObject);
begin
  FClickTimer.Enabled := false;
  TriggerClickEvent(FClickInfo.Button, FClickInfo.Shift, FClickInfo.X, FClickInfo.Y);
end;

procedure TElTrayIcon.OnTimer(Sender : TObject);
begin
  if FImgIdx >= (FIcons.Count - 1) then
  begin
    FImgIdx := 0;
    if AnimateOnce then
    begin
      Animated := false;
      TriggerAnimationStopped;
      exit;
    end;
  end
  else
    inc(FImgIdx);
  FIcons.GetIcon(FImgIdx, FIcon);
  SendDebug('OnTimer');
  UpdateIconData(false);
end;

type

  _NOTIFYICONDATA2K = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of AnsiChar;
    dwState : DWORD;
    dwStateMask : DWORD;
    szInfo : array [0..255] of AnsiChar;
    uTimeout_uVersion : UINT;
    szInfoTitle : array [0..63] of AnsiChar;
    dwInfoFlags : integer;
  end;
  TNotifyIconData2K = _NOTIFYICONDATA2K;
  PNotifyIconData2K = ^TNotifyIconData2K;

procedure TElTrayIcon.UpdateIconData;
var FIconData2K : TNotifyIconData2K;
begin
  if not Iswindow(FHandle) then
    SendDebug('Invalid window')
  else
    SendDebug('window OK');
  if FSet then
  begin
    if Remove then
    begin
      FIconData.Wnd := FHandle;
      FIconData.uID := FIconID;
      FIconData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
      if FIcon <> nil then FIconData.hIcon := FIcon.Handle;
      FIconData.uCallbackMessage := EL_NOTIFYICON;
      Shell_NotifyIcon(NIM_DELETE, @FIconData);
      FSet := false;
    end
    else
    begin
      SendDebug('Updating icon');
      if IsWin2000Up then
      begin
        ZeroMemory(@FIconData2K, sizeof(FIconData2K));
        FIconData2K.cbSize := sizeof(FIconData2K);
        FIconData2K.uID := FIconID;
        FIconData2K.Wnd := FHandle;
        FIconData2K.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
        FIconData2K.hIcon := FIcon.Handle;
        if (FExtForm = nil) and not (TrayInfoSettings.Enabled) then
           StrPCopy(FIconData2K.szTip, Copy(Hint, 1, 127))
        else
           StrPCopy(FIconData2K.szTip, '');
        FIconData2K.uCallbackMessage := EL_NOTIFYICON;
        Shell_NotifyIcon(NIM_MODIFY, PNotifyIconData(@FIconData2K));
      end
      else
      begin
        FIconData.Wnd := FHandle;
        FIconData.uID := FIconID;
        FIconData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
        FIconData.hIcon := FIcon.Handle;
        if (FExtForm = nil) and not (TrayInfoSettings.Enabled) then
           StrPCopy(FIconData.szTip, Copy(Hint, 1, 63))
        else
           StrPCopy(FIconData.szTip, '');
        FIconData.uCallbackMessage := EL_NOTIFYICON;
        Shell_NotifyIcon(NIM_MODIFY, @FIconData);
      end;
    end;
  end
  else
  begin
    if (not Remove) and FEnabled and (FDesignActive or (not (csDesigning in ComponentState))) then
    begin
	  SendDebug('Adding icon');
      if IsWin2000Up then
      begin
        ZeroMemory(@FIconData2K, sizeof(FIconData2K));
        FIconData2K.cbSize := sizeof(FIconData2K);
        FIconData2K.uID := FIconID;
        FIconData2K.Wnd := FHandle;
        FIconData2K.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
        FIconData2K.hIcon := FIcon.Handle;
        if (FExtForm = nil) and not (TrayInfoSettings.Enabled) then
           StrPCopy(FIconData2K.szTip, Copy(Hint, 1, 127))
        else
           StrPCopy(FIconData2K.szTip, '');
        FIconData2K.uCallbackMessage := EL_NOTIFYICON;
        Shell_NotifyIcon(NIM_ADD, PNotifyIconData(@FIconData2K));
      end
      else
      begin
        FIconData.Wnd := FHandle;
        FIconData.uID := FIconID;
        FIconData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
        FIconData.hIcon := FIcon.Handle;
        if (FExtForm = nil) and not (TrayInfoSettings.Enabled) then
           StrPCopy(FIconData.szTip, Copy(Hint, 1, 63))
        else
           StrPCopy(FIconData.szTip, '');
        FIconData.uCallbackMessage := EL_NOTIFYICON;
        Shell_NotifyIcon(NIM_ADD, @FIconData);
      end;
      FSet := true;
    end;
  end;
end;

function TElTrayIcon.DoDblClick(Perform : boolean) : boolean;
var
  i : integer;
begin
  result := false;
  if Assigned(FPopupMenu) and (not (csDesigning in ComponentState)) and (FPopupMenu.Items <> nil) then
  begin
    for i := 0 to FPopupMenu.Items.Count - 1 do // Iterate
    begin
      if FPopupMenu.Items[i].Enabled and (FPopupMenu.Items[i].Default) then
      begin
        if Perform then
           FPopupMenu.Items[i].Click;
        result := true;
        exit;
      end;
    end; // for
  end;
end;

function TElTrayIcon.DoPopupMenu;
var
  F : TForm;
begin
  result := false;
  if (not FPopupWhenModal) and ModalFormVisible then exit;
  if Assigned(FPopupMenu) and (FPopupMenu.AutoPopup) and Enabled and (not (csDesigning in ComponentState)) then
  begin
    FPopupMenu.PopupComponent := Self;
    if not (csDestroying in ComponentState) then
    begin
      F := Screen.ActiveForm;
      if F = nil then F := Application.MainForm;
      if F <> nil then F.SendCancelMode(nil);
    end;
    if IsWindowEnabled(FHandle) then SetForegroundWindow(FHandle);
    Application.ProcessMessages;

    if TrayInfoSettings.Enabled then
    begin
      if not TrayInfoVisible then
        FHintTimer.Enabled := false;
    end
    else
    begin
      if (FExtForm <> nil) and (not FExtForm.Visible) then
         FHintTimer.Enabled := false;
    end;
    {$IFDEF VCL_5_USED}
    FInMenu := true;
    {$ENDIF}
    if TrayInfoVisible then
      FTrayInfo.Hide
    else
    if (FExtForm <> nil) and FExtForm.Visible then
      FExtForm.Hide;
    // if FHintTimer <> nil then
      FHintTimer.Enabled := false;
    FPopupMenu.Popup(X, Y);
    if IsWindowEnabled(FHandle) then
      SetForegroundWindow(FHandle);
    result := true;
  end;
end;

procedure TElTrayIcon.SetHint(newValue : string);
begin
  if (FHint <> newValue) then
  begin
    FHint := newValue;
    SendDebug('setHint');
    if (ComponentState * [csLoading, csReading] = []) then
      UpdateIconData(false);
  end; {if}
end;

var AppWndProc : Pointer;

function NoActWndProc(Window: HWND; Message, WParam: Longint;
                    LParam: Longint): Longint; stdcall;
begin
  if (Message = WM_ACTIVATEAPP) and (wParam = 1) then
  begin
    result := 0;
  end else
  if (Message = WM_WINDOWPOSCHANGING) and (PWindowPos(lParam).flags and SWP_SHOWWINDOW = SWP_SHOWWINDOW) then
  begin
    PWindowPos(lParam).flags := PWindowPos(lParam).flags and (not SWP_SHOWWINDOW);
    result := 0;
  end else
    result := CallWindowProc(AppWndProc, Window, Message, wParam, lParam);
end;

procedure HookAppl;
begin
  AppWndProc := Pointer(GetWindowLong(Application.Handle, GWL_WNDPROC));
  SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(@NoActWndProc));
end;

procedure UnHookAppl;
begin
  SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(AppWndProc));
end;

procedure TElTrayIcon.ShowExtForm(X, Y : Integer);
var H1,
    H2 : HWND;
    R,
    R1 : TRect;
    TBarAlign : TTaskBarEdge;
    DesktopWidth,
    DesktopHeight : integer;

const EnabledStyle : array[boolean] of Cardinal = (WS_DISABLED, 0);

begin
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
    begin
      HookAppl;
      DesktopWidth  := GetSystemMetrics(SM_CXFULLSCREEN);
      DesktopHeight := GetSystemMetrics(SM_CYFULLSCREEN);
      TBarAlign := GetTaskbarEdge;
      GetWindowRect(H1, R1);
      GetWindowRect(H2, R);
      case TBarAlign of
        tbeBottom: begin
             R1.Top := R.Top - FExtForm.Height - 2;
             R1.Left := X;
             if R1.Left + FExtForm.Width > DesktopWidth then
                R1.Left := DesktopWidth - FExtForm.Width;
           end;
        tbeLeft: begin
             R1.Left := X; // R.Right + 2;
             R1.Top := Y;
             if R1.Top + FExtForm.Height > DesktopHeight then
                R1.Top := DesktopHeight - FExtForm.Height;
           end;
        tbeTop: begin
             R1.Top := R.Bottom + 2;
             R1.Left := X;
             if R1.Left + FExtForm.Width > DesktopWidth then
                R1.Left := DesktopWidth - FExtForm.Width;
           end;
        tbeRight: begin
             R1.Left := X;//R.Left - FExtForm.Width - 2;
             R1.Top := Y;
             if R1.Top + FExtForm.Height > DesktopHeight then
               R1.Top := DesktopHeight - FExtForm.Height;
             if R1.Left + FExtForm.Width > DesktopWidth then
               R1.Left := DesktopWidth - FExtForm.Width;
           end;
      end;
      FExtForm.Left := R1.Left;
      FExtForm.Top := R1.Top;
      FExtForm.Position := poDesigned;
      FExtForm.FormStyle := fsStayOnTop;
      FExtForm.BorderStyle := bsNone;

      H1 := GetForegroundWindow;

      FExtForm.ParentWindow := Handle;
      FExtForm.HandleNeeded;
      if FExtHintWndStyle <> 0 then
         SetWindowLong(FExtForm.Handle, Integer(GWL_STYLE), FExtHintWndStyle)
      else
         SetWindowLong(FExtForm.Handle, Integer(GWL_STYLE), WS_POPUP or EnabledStyle[ExtendedHintInteractive]);
      if FExtHintWndExStyle <> 0 then
         SetWindowLong(FExtForm.Handle, GWL_EXSTYLE, FExtHintWndExStyle)
      else
         SetWindowLong(FExtForm.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW or WS_EX_TOPMOST);
      SetParent(FExtForm.Handle, 0);
      FExtForm.Visible := true;
      FHintTimer.Interval := TrackInterval;
      SetWindowPos(FExtForm.Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE);
      FHintTimer.Enabled := true;
      SetForegroundWindow(H1);
      UnHookAppl;
    end;
  end;
end;

procedure TElTrayIcon.Loaded;
begin
  inherited;
  if UseStaticIcons and (FStaticIcons <> nil) and (FStaticIcons.Count = 0) then
    UseStaticIcons := false;
  if Animated then
  begin
    FAnimated := false;
    Animated := true;
  end
  else
  begin
    UpdateStaticIcon;
    SendDebug('Loaded');
    UpdateIconData(false);
  end;

  if (ExtendedHint <> '') and (not (csDesigning in ComponentState)) then
  begin
    if Assigned(OnExtHintFormCreate) then
      OnExtHintFormCreate(Self, ExtendedHint, FExtForm);
    if FExtForm = nil then
       FExtForm := TForm(FindExtForm(ExtendedHint).Create(Application));
  end;
  if Self.FHideTaskBarIcon then DoHideTaskbarIcon;
end;

procedure TElTrayIcon.TriggerQueryEndSessionEvent(Action : Integer; var CanClose : boolean);
{ Triggers the OnQueryEndSession event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnQueryEndSession)) then
    FOnQueryEndSession(Self, Action , CanClose );
end;  { TriggerQueryEndSessionEvent }

procedure TElTrayIcon.SetExtendedHintDelay(newValue : Cardinal);
{ Sets data member FExtendedHintDelay to newValue. }
begin
  if (FExtendedHintDelay <> newValue) and ((newValue = 0) or (newValue > 50)) then
    FExtendedHintDelay := newValue;
end;  { SetExtendedHintDelay }

procedure TElTrayIcon.SetHideTaskBarIcon(newValue : Boolean);
{ Sets data member FHideTaskBarIcon to newValue. }
begin
  if (FHideTaskBarIcon <> newValue) then
  begin
    FHideTaskBarIcon := newValue;
    if Enabled and IsIconic(Application.Handle) then
    begin
      if FHideTaskBarIcon then
         DoHideTaskBarIcon
       else
         DoShowTaskBarIcon;
    end;
  end;  { if }
end;  { SetHideTaskBarIcon }

{$IFDEF VCL_5_USED}
procedure TElTrayIcon.PopupMenuProc(var Message : TMessage);
begin
  if not Enabled or (csDesigning in ComponentState) then
     Message.Result := CallWindowProc(OldMenuProc, PopupList.Window, Message.Msg, Message.wParam, Message.lParam)
  else
  begin
    if Message.Msg = WM_QUERYENDSESSION then
    begin
      Message.result := 1;
      exit;
    end;
    Message.Result := CallWindowProc(OldMenuProc, PopupList.Window, Message.Msg, Message.wParam, Message.lParam);
    if Message.Msg = WM_EXITMENULOOP then
       FInMenu := false;
    if Message.Msg = WM_INITMENUPOPUP then
    begin
      if Message.wParam <> Integer(FPopupMenu.Handle) then FInMenu := false;
    end;
  end;
end;
{$ENDIF}


function TElTrayIcon.HookWndProc(var Message : TMessage): Boolean;
begin
  if not Enabled or (csDesigning in ComponentState) then
  else
  begin
    if FHideTaskBarIcon and (Message.Msg = WM_SIZE) and (Message.wParam = SIZE_MINIMIZED) then
       DoHideTaskBarIcon;
    if (Message.Msg = WM_SYSCOMMAND) then
    begin
      if FHideTaskBarIcon and (Message.WParam and $FFF0 = SC_RESTORE) then
         DoShowTaskBarIcon;
    end;
  end;
  result := false;
end;

procedure TElTrayIcon.DoHideTaskBarIcon;  { protected }
begin
  if not (csDesigning in ComponentState) then
     ShowWindow(Application.Handle, SW_HIDE);
end;  { DoHideTaskBarIcon }

procedure TElTrayIcon.DoShowTaskBarIcon;  { protected }
begin
  ShowWindow(Application.Handle, SW_SHOW);
end;  { DoShowTaskBarIcon }

procedure TElTrayIcon.TriggerBeforeExtendedHintShowEvent(var DoShow : boolean);
{$ifndef VCL_5_USED}
var
  T : TPoint;
  S : PChar;
{$endif}
begin
  DoShow := true;
  if (assigned(FOnBeforeExtendedHintShow)) then
    FOnBeforeExtendedHintShow(Self, DoShow );
  if (DoShow) then
  begin
{$ifndef VCL_5_USED}
    GetCursorPos(T);
    GetMem(S, 255);
    GetClassName(WindowFromPoint(T), S, 255);
    if S = '#32768' then
      DoShow := True;
    FreeMem(S);
    if (GetWindowThreadProcessID(FindWindow('#32768', nil), nil) = GetCurrentThreadId ) then
      DoShow:=False;
{$endif}
  end;
end;  { TriggerBeforeExtendedHintShowEvent }

destructor TElTrayIcon.Destroy;
begin
  Destroying;
  SetIcons(nil);

  FHintTimer.Enabled := false;

  FExtForm := nil;
  FExtFormName := '';

  FHintTimer.Free;
  FHintTimer := nil;
  FTimer.Free;
  FTimer := nil;
  FStaticIcon.Free;
  FStaticIcon := nil;
  FIcon.Free;
  FIcon := nil;
  PopupMenu := nil;
  MyChangeLink.Free;
  StaticChangeLink.Free;
  Application.UnhookMainWindow(HookWndProc);

  FTrayInfo.Free;
  FTrayInfoSettings.Free;
  FTimerPool.Free;
  inherited;
end;

constructor TElTrayIcon.Create(AOwner : TComponent);
begin
  inherited;
  FIconID := Random(MaxInt);
  FIcon := TIcon.Create;
  FInterval := 200;
  FStaticIcon := TIcon.Create;
  FStaticIcon.OnChange := OnImagesChange;

  FTimerPool := TElTimerPool.Create(nil);
  FTimerPool.Precise := false;
  FTimer := FTimerPool.Items.Add;
  FTimer.OnTimer := OnTimer;

  FClickTimer := FTimerPool.Items.Add;
  FClickTimer.OnTimer := OnClickTimer;

  FHintTimer := FTimerPool.Items.Add;
  FHintTimer.Interval := ExtendedHintDelay;
  FHintTimer.OnTimer  := OnHintTimer;

  MyChangeLink := TChangeLink.Create;
  MyChangeLink.OnChange := OnImagesChange;

  StaticChangeLink := TChangeLink.Create;
  StaticChangeLink.OnChange := OnStaticIconsChange;

  FTrayInfo := TElTrayInfo.Create(nil);
  FTrayInfoSettings := TElTrayInfoSettings.Create(Self);
  FTrayInfo.OnShow := TrayInfoShowHandler;
  FTrayInfo.OnHide := TrayInfoHideHandler;
  {$ifdef HAS_HTML_RENDER}
  FTrayInfo.OnImageNeeded := ImageNeededTransfer;
  FTrayInfo.OnLinkClick := LinkClickTransfer;
  {$endif}

  FIconData.cbSize := sizeof(FIconData);
  FPopupWhenModal := False;
  FExtendedHintDelay := Application.HintPause;
  { Initialize properties with default values: }
  FHideTaskBarIcon := False;
  Application.HookMainWindow(HookWndProc);
  FStaticIconIndex := -1;
end;

procedure TElTrayIcon.TriggerDblClickExEvent(Button : TMouseButton; Shift :
    TShiftState; X, Y : Integer);
begin
  if (assigned(FOnDblClickEx)) then FOnDblClickEx(Self, Button, Shift, X, Y);
end;

procedure TElTrayIcon.SetStaticIcons(Value: TImageList);
begin
  if (FStaticIcons <> Value) then
  begin
    if FStaticIcons <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FStaticIcons.ComponentState) then
        FStaticIcons.RemoveFreeNotification(Self);
      {$endif}
      FStaticIcons.UnRegisterChanges(StaticChangeLink);
    end;
    FStaticIcons := Value;
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
      Value.RegisterChanges(StaticChangeLink);
      if (ComponentState * [csLoading, csReading] = []) and UseStaticIcons and (FStaticIcons <> nil) then
        UpdateStaticIcon;
    end
    else
      UseStaticIcons := false;
  end; {if}
end;

procedure TElTrayIcon.SetUseStaticIcons(Value: Boolean);
begin
  if (FUseStaticIcons <> Value) and ((FUseStaticIcons = false) or (FStaticIcons = nil) or (FStaticIcons.Count > 0)) then
  begin
    FUseStaticIcons := Value;
    if (ComponentState * [csLoading, csReading] = []) then
      UpdateStaticIcon;
  end;
end;

function TElTrayIcon.GetStaticIconIndex : integer;
begin
  result := FStaticIconIndex;
end;

procedure TElTrayIcon.SetStaticIconIndex(Value: Integer);
begin
  //assert(FStaticIconIndex = 5);
  if FStaticIconIndex <> Value then
  begin
    FStaticIconIndex := Value;
    if UseStaticIcons and (FStaticIcons <> nil) then
      UpdateStaticIcon;
  end;
end;

procedure TElTrayIcon.OnStaticIconsChange(Sender : TObject);
begin
  if UseStaticIcons and (ComponentState * [csLoading, csReading] = []) and (FStaticIcons <> nil) and (FStaticIcons.Count = 0) then
    UseStaticIcons := false;
  SendDebug('OnStaticIconsChange');
  if (ComponentState * [csLoading, csReading] = []) then
    UpdateIconData(false);
end;

procedure TElTrayIcon.UpdateStaticIcon;
begin
  if UseStaticIcons and (FStaticIcons <> nil) and (InRange(0, FStaticIcons.Count - 1, FStaticIconIndex)) then
  begin
    FStaticIcons.GetIcon(FStaticIconIndex, FIcon)
  end
  else
    FIcon.Assign(FStaticIcon);

  SendDebug('UpdateStaticIcon');
  if (ComponentState * [csLoading, csReading] = []) then
    UpdateIconData(false);
end;

procedure TElTrayIcon.TrayInfoShowHandler(Sender : TObject);
begin
  TrayInfoVisible := true;
end;

procedure TElTrayIcon.TrayInfoHideHandler(Sender : TObject);
begin
  TrayInfoVisible := false;
  FHideForm := false;
  FNoShow := false;
  FHintTimer.Enabled := false;
end;

procedure TElTrayIcon.SetTrayInfoSettings(Value: TElTrayInfoSettings);
begin
  FTrayInfoSettings.Assign(Value);
end;

function TElTrayIcon.AdjustY(Y : integer): Integer;
var
  IconInfo : TIconInfo;
  BitmapInfoSize : DWORD;
  BitmapBitsSize : DWORD;
  Bitmap : PBitmapInfoHeader;
  Bits : Pointer;
  BytesPerScanline, ImageSize : DWORD;

  function FindScanline(Source : Pointer; MaxLen : Cardinal;
    Value : Cardinal) : Cardinal; assembler;
  asm
            PUSH    ECX
            MOV     ECX,EDX
            MOV     EDX,EDI
            MOV     EDI,EAX
            POP     EAX
            REPE    SCASB
            MOV     EAX,ECX
            MOV     EDI,EDX
  end;

begin
  { Default value is entire icon height }
  Result := GetSystemMetrics(SM_CYCURSOR);
  if GetIconInfo(GetCursor, IconInfo) then
  try
    GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
    Bitmap := AllocMem(BitmapInfoSize + BitmapBitsSize);
    try
      Bits := Pointer(Cardinal(Bitmap) + BitmapInfoSize);
      if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
        (Bitmap^.biBitCount = 1) then
      begin
        { Point Bits to the end of this bottom-up bitmap }
        with Bitmap^ do
        begin
          BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
          ImageSize := Cardinal(biWidth) * BytesPerScanline;
          Bits := Pointer(Cardinal(Bits) + BitmapBitsSize - ImageSize);
          { Use the width to determine the height since another mask bitmap
            may immediately follow }
          Result := FindScanline(Bits, ImageSize, $FF);
          { In case the and mask is blank, look for an empty scanline in the
            xor mask. }
          if (Result = 0) and (biHeight >= 2 * biWidth) then
            Result := FindScanline(Pointer(Cardinal(Bits) - ImageSize),
              ImageSize, $00);
          Result := Result div Integer(BytesPerScanline);
        end;
        Result := Integer(IconInfo.yHotSpot) - (Integer(GetSystemMetrics(SM_CYICON)) - Result);
        // Dec(Result, IconInfo.yHotSpot);
      end;
    finally
      FreeMem(Bitmap, BitmapInfoSize + BitmapBitsSize);
    end;

  finally
    if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
    if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
  end;
  Result := Max(y - Result, 0);
end;

{$ifdef HAS_HTML_RENDER}
procedure TElTrayIcon.ImageNeededTransfer(Sender: TObject; Src: TElFString; var
    Image: TBitmap);
begin
  if assigned(FOnTrayInfoImageNeeded) then FOnTrayInfoImageNeeded(Self, Src, Image);
end;

procedure TElTrayIcon.LinkClickTransfer(Sender: TObject; HRef: TElFString);
begin
  if assigned(FOnTrayInfoLinkClick) then FOnTrayInfoLinkClick(Self, HRef);
end;

{$endif}

procedure TElTrayIcon.TriggerAnimationStopped;
begin
  if assigned(FOnAnimationStopped) then
    FOnAnimationStopped(Self); 
end;

procedure TElTrayIcon.PerformIconHiding;
begin
  if FHideTaskBarIcon then DoShowTaskBarIcon;
  SendDebug('doSetEnabled');
  if (ComponentState * [csLoading, csReading] = []) then
    UpdateIconData(true);
end;

constructor TElTrayInfoSettings.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner as TElTrayIcon;
end;

procedure TElTrayInfoSettings.SetColor(Value: TColor);
begin
  FOwner.FTrayInfo.Color := Value;
end;

procedure TElTrayInfoSettings.SetInfoType(newValue: TElTrayInfoType);
{ Sets data member FInfoType to newValue. }
begin
  FOwner.FTrayInfo.InfoType := newValue;
end;  { SetInfoType }

{$ifdef HAS_HTML_RENDER}
procedure TElTrayInfoSettings.SetIsHTML(newValue: Boolean);
{ Sets data member FIsHTML to newValue. }
begin
  FOwner.FTrayInfo.IsHTML := newValue;
end;  { SetIsHTML }
{$endif}

procedure TElTrayInfoSettings.SetMessage(newValue: TElFString);
{ Sets data member FMessage to newValue. }
begin
  FOwner.FTrayInfo.Message := newValue;
end;  { SetMessage }

function TElTrayInfoSettings.GetColor: TColor;
begin
  Result := FOwner.FTrayInfo.Color;
end;

function TElTrayInfoSettings.GetInfoType: TElTrayInfoType;
begin
  Result := FOwner.FTrayInfo.InfoType;
end;

{$ifdef HAS_HTML_RENDER}
function TElTrayInfoSettings.GetIsHTML: Boolean;
begin
  Result := FOwner.FTrayInfo.IsHTML;
end;
{$endif}

function TElTrayInfoSettings.GetMessage: TElFString;
begin
  Result := FOwner.FTrayInfo.Message;
end;

procedure TElTrayInfoSettings.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
  end;
end;

procedure TElTrayInfoSettings.Assign(Source : TPersistent);
begin
  if Source is TElTrayInfoSettings then
  begin
    Color := TElTrayInfoSettings(Source).Color;
    Enabled := TElTrayInfoSettings(Source).Enabled;
    InfoType := TElTrayInfoSettings(Source).InfoType;
    {$ifdef HAS_HTML_RENDER}
    IsHTML := TElTrayInfoSettings(Source).IsHTML;
    {$endif}
    Message := TElTrayInfoSettings(Source).Message;
  end
  else
    inherited;
end;

function TElTrayInfoSettings.GetFont: TFont;
begin
  Result := FOwner.FTrayInfo.Font;
end;

procedure TElTrayInfoSettings.SetFont(Value: TFont);
begin
  FOwner.FTrayInfo.Font := Value;
end;

initialization

  WM_TaskbarRestart := RegisterWindowMessage(PChar('TaskbarCreated'));

end.
