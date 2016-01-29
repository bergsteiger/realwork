{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCToolTip;

interface

{$I dc.inc}
uses
  Messages, Windows, CommCtrl,
  SysUtils, Classes, Controls, Forms;

{$IFNDEF C3}
Const
  TTF_SUBCLASS = $0010;
  TTM_WINDOWFROMPOINT = WM_USER + 16;
  TTM_SETMAXTIPWIDTH  = WM_USER + 24;
  TTM_GETMAXTIPWIDTH  = WM_USER + 25;
{$ENDIF}
Type
  TDCToolTipOption=(toNoPrefox);
  TDCToolTipOptions=Set Of TDCToolTipOption;

  { TDCToolTip }

  TDCToolTip = class(TComponent)
  private
    FDefWndProc:Pointer;
    FOnHide:TNotifyEvent;
    FOnShow:TNotifyEvent;
    FOptions:TDCToolTipOptions;
    FParent:TWinControl;
    FToolTipWnd:THandle;
    FVisible:Boolean;
    FWndProcInstance:Pointer;
  protected
    Procedure DoHideToolTip;virtual;
    Procedure DoShowToolTip;virtual;
    Function GetWidth:Integer;
    Procedure RestoreHook;
    Procedure SetWidth(Value:Integer);
    Procedure WndProc(Var Message:TMessage);virtual;
  public
    Constructor Create(AOwner:TComponent);override;
    Destructor Destroy;override;

    Procedure Activate;
    Procedure AddToolTip(ToolID:Cardinal;Handle:THandle;const ARect:TRect;
                         const Text:String;IsSubClasses:Boolean);
    Procedure CreateToolTipWindow;
    Procedure DestroyToolTipWindow;
    Procedure Deactivate;
    Procedure DefaultHandler(Var Message);override;
    Procedure DeleteToolTip(ToolID:Cardinal;Handle:THandle);
    Function HandleAllocated:Boolean;
    Procedure RecalcTime;
    Procedure RelayEvent(const Message:TMessage;Handle:THandle);
    Procedure SetInitialTime(Value:Integer);
    Procedure SetAutoPopTime(Value:Integer);
    Procedure SetReShowTime(Value:Integer);
    Procedure SetTime(TimeType:Integer;Value:Integer);
    Procedure UpdateToolTipInfo(ToolID:Cardinal;Handle:THandle;
                                const ARect:TRect;const Text:String;
                                IsSubClasses:Boolean);

    Property Handle:THandle read FToolTipWnd;
    Property Visible:Boolean read FVisible;
    Property Width:Integer read GetWidth write SetWidth;
  published
    Property OnHide:TNotifyEvent read FOnHide write FOnHide;
    Property OnShow:TNotifyEvent read FOnShow write FOnShow;
    Property Options:TDCToolTipOptions read FOptions write FOptions;
    Property Parent:TWinControl read FParent write FParent;
  end;

implementation

//Error messages
Const
  SErrCreatingWindow='Error creating window';

//Common procedures
Procedure Error(const Message:String);
Begin
  Raise Exception.Create(Message);
End;

{ TDCToolTip }

Constructor TDCToolTip.Create(AOwner:TComponent);
Begin
  Inherited;
End;

{---------------------------------------------------------}

Destructor TDCToolTip.Destroy;
Begin
  DestroyToolTipWindow;
  Inherited;
End;

{---------------------------------------------------------}

Procedure TDCToolTip.Activate;
Begin
  SendMessage(FToolTipWnd,TTM_ACTIVATE,-1,0);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.AddToolTip(ToolID:Cardinal;Handle:THandle;const ARect:TRect;
                                const Text:String;IsSubClasses:Boolean);
Var
  ToolInfo:TToolInfo;
Begin
  ToolInfo.cbSize:=SizeOf(ToolInfo);
  If IsSubClasses Then
    ToolInfo.uFlags:=TTF_SUBCLASS
  Else
    ToolInfo.uFlags:=0;
  ToolInfo.hwnd:=Handle;
  ToolInfo.uId:=ToolID;
  ToolInfo.Rect:=ARect;
  ToolInfo.hInst:=hInstance;
  ToolInfo.lpszText:=PChar(Text);
  SendMessage(FToolTipWnd,TTM_ADDTOOL,0,Integer(@ToolInfo));
End;

{---------------------------------------------------------}

Procedure TDCToolTip.CreateToolTipWindow;
Var
  ParentHandle:THandle;
Begin
  InitCommonControls;
  If FParent<>Nil Then
    ParentHandle:=FParent.Handle
  Else
    ParentHandle:=0;
  FToolTipWnd:=CreateWindow({$IFDEF D4}TOOLTIPS_CLASS{$ELSE}TOOTIPS_CLASS{$ENDIF},Nil,
                            TTS_ALWAYSTIP Or TTS_NOPREFIX,Integer(CW_USEDEFAULT),
                            Integer(CW_USEDEFAULT),Integer(CW_USEDEFAULT),
                            Integer(CW_USEDEFAULT),ParentHandle,0,hInstance,Nil);

  {$IFDEF D6}
  FWndProcInstance:=Classes.MakeObjectInstance(WndProc);
  {$ELSE}
  FWndProcInstance:=MakeObjectInstance(WndProc);
  {$ENDIF}

  FDefWndProc:=Pointer(SetWindowLong(FToolTipWnd,GWL_WNDPROC,Integer(FWndProcInstance)));
  If FToolTipWnd=0 Then
    Error(SErrCreatingWindow);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.Deactivate;
Begin
  SendMessage(FToolTipWnd,TTM_ACTIVATE,0,0);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.DefaultHandler(Var Message);
Begin
  With TMessage(Message) Do
    Result:=CallWindowProc(FDefWndProc,FToolTipWnd,Msg,wParam,lParam);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.DeleteToolTip(ToolID:Cardinal;Handle:THandle);
Var
  ToolInfo:TToolInfo;
Begin
  ToolInfo.cbSize:=SizeOf(ToolInfo);
  ToolInfo.hwnd:=Handle;
  ToolInfo.uId:=ToolID;
  SendMessage(FToolTipWnd,TTM_DELTOOL,0,Integer(@ToolInfo));
End;

{---------------------------------------------------------}

Procedure TDCToolTip.DestroyToolTipWindow;
Begin
  If FToolTipWnd>0 Then
  Begin
    DestroyWindow(FToolTipWnd);
    RestoreHook;
  End;
End;

{---------------------------------------------------------}

Procedure TDCToolTip.DoHideToolTip;
Begin
  FVisible:=False;
  If Assigned(FOnHide) Then
    FOnHide(Self);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.DoShowToolTip;
Begin
  FVisible:=True;
  If Assigned(FOnShow) Then
    FOnShow(Self);
End;

{---------------------------------------------------------}

Function TDCToolTip.GetWidth:Integer;
Begin
  Result:=SendMessage(Handle,TTM_SETMAXTIPWIDTH,0,0);
End;

{---------------------------------------------------------}

Function TDCToolTip.HandleAllocated:Boolean;
Begin
  Result:=FToolTipWnd<>0;
End;

{---------------------------------------------------------}

Procedure TDCToolTip.RecalcTime;
Begin
  SetTime(TTDT_AUTOMATIC,0);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.RelayEvent(const Message:TMessage;Handle:THandle);
Var
  Msg:TMsg;
Begin
  Msg.hWnd:=Handle;
  Msg.Message:=Message.Msg;
  Msg.wParam:=message.wParam;
  Msg.lParam:=message.lParam;
  Msg.Time:=0;
  GetCursorPos(Msg.Pt);
  SendMessage(FToolTipWnd,TTM_RELAYEVENT,0,Integer(@Msg));
End;

{---------------------------------------------------------}

Procedure TDCToolTip.RestoreHook;
Begin
  SetWindowLong(FToolTipWnd,GWL_WNDPROC,Integer(FDefWndProc));

  {$IFDEF D6}
  Classes.FreeObjectInstance(FWndProcInstance);
  {$ELSE}
  FreeObjectInstance(FWndProcInstance);
  {$ENDIF}

  FWndProcInstance:=Nil;
  FToolTipWnd:=0;
End;

{---------------------------------------------------------}

Procedure TDCToolTip.SetAutoPopTime(Value:Integer);
Begin
  SetTime(TTDT_AUTOPOP,Value);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.SetInitialTime(Value:Integer);
Begin
  SetTime(TTDT_INITIAL,Value);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.SetReShowTime(Value:Integer);
Begin
  SetTime(TTDT_RESHOW,Value);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.SetWidth(Value:Integer);
Begin
  SendMessage(Handle,TTM_SETMAXTIPWIDTH,0,Value);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.SetTime(TimeType:Integer;Value:Integer);
Begin
  SendMessage(FToolTipWnd,TTM_SETDELAYTIME,TimeType,Value);
End;

{---------------------------------------------------------}

Procedure TDCToolTip.UpdateToolTipInfo(ToolID:Cardinal;Handle:THandle;
                                       const ARect:TRect;const Text:String;
                                       IsSubClasses:Boolean);
Var
  ToolInfo:TToolInfo;
Begin
  ToolInfo.cbSize:=SizeOf(ToolInfo);
  If IsSubClasses Then
    ToolInfo.uFlags:=TTF_SUBCLASS
  Else
    ToolInfo.uFlags:=0;
  ToolInfo.hwnd:=Handle;
  ToolInfo.uId:=ToolID;
  ToolInfo.Rect:=ARect;
  ToolInfo.hInst:=hInstance;
  ToolInfo.lpszText:=PChar(Text);
  SendMessage(FToolTipWnd,TTM_SETTOOLINFO,0,Integer(@ToolInfo));
End;

{---------------------------------------------------------}

Procedure TDCToolTip.WndProc(Var Message:TMessage);
Begin
  Case Message.Msg Of
    WM_WINDOWPOSCHANGING:
      With TWINDOWPOS(Pointer(Message.lParam)^) Do
      Begin
        If (Flags And SWP_SHOWWINDOW<>0) And Not FVisible Then
          DoShowToolTip
        Else
          If (Flags And SWP_HIDEWINDOW<>0) And FVisible Then
            DoHideToolTip;
      End;
  End;
  Dispatch(Message);
  Case Message.Msg Of
    WM_DESTROY:
      RestoreHook;
  End;
End;

end.
