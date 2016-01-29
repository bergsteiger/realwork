unit tb97vt;

{$I TB97Ver.inc}

{$IfNDef vcmNotNeedOvc}
 {$Define vcmNeedOvc}
{$EndIf  vcmNotNeedOvc}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, ClipBrd,
  Forms, Dialogs, StdCtrls, ExtCtrls, Menus, Contnrs, ActnList,

  l3Base,
  l3ObjectRefList,
  l3Interfaces,

  tb97Control
  ;

const
 CM_TBMOUSEQUERY = WM_USER + 12345;
 CM_TBCHECKCONTROL = CM_TBMOUSEQUERY + 1;

type

 TAdjustCorner = (acBottomLeft, acBottomRight);
 TOnAdjustCtrl = procedure(Sender: TObject) of object;
 TvtCustomPopupWindow = class(Ttb97Control,
                              Il3MouseListener)
  {* Базовое popup окно. }
  private
    fDependControl  : TControl;
    fExecResult     : Longint;
    fOrigin         : TPoint;
    FAdjustCorner   : TAdjustCorner ;
    fOnAdjustCtrl   : TOnAdjustCtrl;
    fOnExecute      : TNotifyEvent;

    procedure WMChar(var Msg : TWMChar); message WM_CHAR;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMKillFocus(var Msg : TWMKillFocus);   message WM_KILLFOCUS;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMCancelMode(Var Message: TMessage); message CM_CANCELMODE;
    // Il3MouseListener
    procedure MouseListenerNotify(aMouseMessage: WPARAM;
                                  aHookStruct: PMouseHookStruct;
                                  var theResult: Tl3HookProcResult);
  protected
    procedure KeyPressHandler(Const Key: Word); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
  {$IFNDEF WIN32}
    procedure CreateWnd; override;
  {$ENDIF}
    procedure MakeChildComponents; virtual;
    procedure DoOnExecute; virtual;
    procedure DoAfterExecute; virtual;

    function getChildControls(Index: Integer): TControl; virtual;
    function getChildControlCount: Integer; virtual;

    function IsChildControl(aHandle: HWND): boolean; virtual;
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent; aOrigin : TPoint); reintroduce; overload;
    //destructor  Destroy; override;
    procedure Close;
    function  Execute : Longint;

    property AdjustCorner  : TAdjustCorner read fAdjustCorner  write fAdjustCorner;
    property DependControl : TControl      read fDependControl write fDependControl;
    property OnAdjustCtrl  : TOnAdjustCtrl read fOnAdjustCtrl  write fOnAdjustCtrl;
    property ExecResult    : Longint       read fExecResult    write fExecResult;
    property Origin        : TPoint        read fOrigin        write fOrigin;

    property OnExecute     : TNotifyEvent  read fOnExecute     write fOnExecute;

    property ChildControls[Index: Integer] : TControl      read getChildControls;
    property ChildControlCount             : Integer       read getChildControlCount;
  end;

 TWinControlClass = class of TWinControl;

 TvtPopupWindow = class(TvtCustomPopupWindow)
  {* Popup окно. }
  protected
   fChildControl : TWinControl;
   procedure DoOnExecute; override;
   procedure DoAfterExecute; override;

   function getChildControls(Index: Integer): TControl; override;
   function getChildControlCount: Integer; override;
  public
   constructor Create(aOwner: TComponent; aChildControl : TWinControl); reintroduce; overload;
   constructor Create(aOwner: TComponent; aChildControlClass : TWinControlClass); reintroduce; overload;
 end;

  TAssList = class(Tl3ObjectRefList)
    public
      procedure AddItem(aKey:TObject; aAction:TObject; aOnExecute:TNotifyEvent);
      function ContainsControl(aKey:TObject):boolean;
      function ContainsAction(aAction:TObject):boolean;
      function GetActionByControl(aKey:TObject):TCustomAction;
      function GetOnExecuteByControl(aKey:TObject):TNotifyEvent;
      function GetOnExecuteByAction(aAction:TObject):TNotifyEvent;
  end;//TAssList

  TKeyData = class(Tl3Base)
    private
      Key:TObject;
      Action:TObject;
      OnExecute:TNotifyEvent;
  end;//TKeyData

  procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorRect  : TRect;   aAdjustCorner : TAdjustCorner = acBottomLeft); overload;
  procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorPoint : TPoint;  aAdjustCorner : TAdjustCorner = acBottomLeft); overload;
  procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorCtrl : TControl; aAdjustCorner : TAdjustCorner = acBottomLeft); overload;

implementation

{$IfDef vcmNeedOvc}
uses
  OvcBase, OvcCmd, OvcConst,
{$else}
uses
{$EndIf vcmNeedOvc}
 l3ListenersManager;

var
 g_FakeParent   : TWinControl = nil;
  // - специальный контрол для правильной отрисовки PopUpWindow
 g_CurrentPopup : TVtCustomPopupWindow;

type
 TSpecWinControl = class(Ttb97Control)
  protected
      procedure Cleanup;
        override;
        {-}
 end;

procedure TvtCustomPopupWindow.MouseListenerNotify(aMouseMessage: WPARAM;
                                                   aHookStruct: PMouseHookStruct;
                                                   var theResult: Tl3HookProcResult);
 function lp_IsChildProcess(aChild: TWinControl): Boolean;
 begin
  Result := SendMessage(aChild.Handle,
                        CM_TBMOUSEQUERY,
                        aHookStruct.Pt.X,
                        aHookStruct.Pt.Y) > 0;
 end;//lp_IsChildProcess

var
 l_Index     : Integer;
 l_Pt        : TPoint;
begin
 if (aMouseMessage in [WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN]) then
  if g_CurrentPopup = Self then
  begin
   l_Pt := ScreenToClient(aHookStruct.Pt);
   if not PtInRect(ClientRect, l_Pt) then
   begin
    // При работе с неклиентской областью дочерных компонентов не закрываемся:

    for l_Index := 0 to Pred(ChildControlCount) do
     if (ChildControls[l_Index] is TWinControl) and
        lp_IsChildProcess(TWinControl(ChildControls[l_Index])) then
      Exit;
      
    Close;
   end;//if not PtInRect(g_CurrentPopup.ClientRect, l_Pt) then
  end;//if g_CurrentPopup <> nil then
end;

procedure TSpecWinControl.Cleanup;
begin
  if (Pointer(g_FakeParent) = Self) then g_FakeParent := nil;
  inherited;
end;

function GetFakeParent : TWinControl;
begin
  if g_FakeParent = nil
  then g_FakeParent := TSpecWinControl.Create(Application.MainForm);
  if g_FakeParent.Parent = nil
    then g_FakeParent.Parent := Application.MainForm;
  Result := g_FakeParent;
end;

constructor TvtCustomPopupWindow.Create(AOwner: TComponent);
begin
 Create(AOwner, Point(-1,-1));
end;

constructor TvtCustomPopupWindow.Create(AOwner: TComponent; aOrigin : TPoint);
begin
  fDependControl:=TControl(AOwner);
  //if Not (AOwner is TForm) then AOwner := GetParentForm(TWinControl(aOwner));

  inherited Create(AOwner);
{$IFDEF WIN32}
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable,
    csAcceptsControls];
{$ELSE}
  ControlStyle := ControlStyle + [csAcceptsControls{, csCaptureMouse}] - [csFramed];
{$ENDIF}
  Ctl3D := True;
  ParentCtl3D := False;
  Visible := False;

  Height := 124;
  Width  := 185;

  FOrigin := aOrigin;
  MakeChildComponents;
end;

procedure TvtCustomPopupWindow.MakeChildComponents;
 begin
  //
 end;

procedure TvtCustomPopupWindow.DoOnExecute;
 begin
  if Assigned(fOnExecute) then
   OnExecute(Self);

  if Assigned(fOnAdjustCtrl) then
   OnAdjustCtrl(Self)
  else
   if (Origin.X < 0) and (Origin.Y < 0) then
    AdjustCtrl(Self, DependControl, AdjustCorner)
   else
    AdjustCtrl(Self, Origin, AdjustCorner);
 end;

procedure TvtCustomPopupWindow.DoAfterExecute;
 begin
  //
 end;

function TvtCustomPopupWindow.Execute : Longint;
var
 lParWin            : TCustomForm;
 lMsg               : TMsg;
{$IfDef vcmNeedOvc}
 l_Controller       : TOvcController;
 l_Message          : TMessage;
{$EndIf vcmNeedOvc}
begin
   {$IfNDef Nemesis}
   lParWin := Screen.ActiveCustomForm;
   if lParWin = nil
    then lParWin := Application.MainForm;
   {$Else}
   Assert(fDependControl <> nil);
   lParWin := GetParentForm(fDependControl);
   if (lParWin = nil) then
    lParWin := Screen.ActiveCustomForm;
   if (lParWin = nil) then
    lParWin := Application.MainForm;
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=570120392
   {$EndIf}

   GetFakeParent.Parent := lParWin;
   Parent := GetFakeParent;
   Windows.SetParent(Handle, 0);

   g_CurrentPopup := Self;
   Tl3ListenersManager.AddMouseListener(Self);
   try
    DoOnExecute;
    try
     Visible:=True;
     ExecResult := - 2;
     try

     While ExecResult<-1 do
      begin
       Application.HandleMessage; // заменил ProcessMessages с тем, чтобы вызывался OnIdle
       (* Это собственный обработчик Message, можно что-то сфильтровать
          Идея: можно попытаться подавить KillFocus при передаче фокуса на popup окошко,
          но придется видимо Хук вешать*)

       if Application.Terminated then Close;
       case Integer(Windows.GetMessage(lMsg, 0, 0, 0)) of
        -1 : Close;
         0 : begin
              PostQuitMessage(lMsg.wParam);
              Close;
             end
         else begin
          if lMsg.Message = WM_KEYDOWN then
           if lMsg.WParam = VK_ESCAPE then
            Close
           else
           begin
            {$IfDef vcmNeedOvc}
            l3FillChar(l_Message, SizeOf(l_Message), 0);
            l_Message.Msg := lMsg.Message;
            l_Message.WParam := lMsg.wParam;
            l_Message.LParam := lMsg.lParam;
            l_Controller := GetDefController;
            if Assigned(l_Controller) then
             with l_Controller.EntryCommands do
              if TranslateUsing([], TMessage(l_Message), GetTickCount) = ccShortCut then
              begin
               lMsg.Message := l_Message.Msg;
               lMsg.wParam := l_Message.WParam;
               lMsg.lParam := l_Message.LParam;
//               lMsg.Result := 0;  {indicate that this message was processed}
               Close;
              end;
            {$EndIf vcmNeedOvc}
           end;
{          if (lMsg.message = WM_LBUTTONDOWN) or (lMsg.message = WM_RBUTTONDOWN) or
            (lMsg.message = WM_MBUTTONDOWN) or (lMsg.message = WM_NCLBUTTONDOWN) or
            (lMsg.message = WM_NCRBUTTONDOWN) or (lMsg.message = WM_NCMBUTTONDOWN) then begin
              if CheckMouseClick then begin
                lInt:=0;
              end;
            end;}
         end;
       end;

       begin
        TranslateMessage(lMsg);
        DispatchMessage(lMsg);
       end;

       if Application.Terminated then Close;
     end;
     Result:=ExecResult;

     finally
//      ReleaseCapture;
     end;
    finally
     DoAfterExecute;
    end;
   finally
    Visible := False;
    Tl3ListenersManager.RemoveMouseListener(Self);
    g_CurrentPopup := nil;
   end;
 end;

procedure TvtCustomPopupWindow.Close;
 begin
  ExecResult := -1;
 end;

procedure TvtCustomPopupWindow.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 with Params do begin
    Style := {WS_CHILD or} WS_POPUP; // or {WS_BORDER or} WS_CLIPCHILDREN and not WS_CAPTION;

  ExStyle := WS_EX_TOOLWINDOW;
  WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
 end;
end;

{$IFNDEF WIN32}
procedure TvtCustomPopupWindow.CreateWnd;
begin
  inherited CreateWnd;
  if (csDesigning in ComponentState) then SetParent(nil);
end;
{$ENDIF}

procedure TvtCustomPopupWindow.KeyPressHandler(Const Key: Word);
begin
  Case Key of
   vk_Escape : Close;
  end;
end;

procedure TvtCustomPopupWindow.WMChar(var Msg : TWMChar);
begin
  inherited;
  KeyPressHandler(Msg.CharCode);
end;

procedure TvtCustomPopupWindow.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TvtCustomPopupWindow.WMActivate(var Message: TWMActivate);
begin
 inherited;
 if Message.Active = WA_INACTIVE then
  if not (csDestroying in ComponentState) then
   if not IsChildControl(Message.ActiveWindow) then
    Close;
end;

procedure TvtCustomPopupWindow.WMKillFocus(var Msg : TWMKillFocus);
begin
 inherited;
 if not (csDestroying in ComponentState) then
  if not IsChildControl(Msg.FocusedWnd) then
   Close;
end;

procedure TvtCustomPopupWindow.CMExit(var Message: TCMExit);
begin
 Inherited;
 Close;
end;

constructor TvtPopupWindow.Create(aOwner: TComponent; aChildControl : TWinControl);
 begin
  inherited Create(aOwner);
  fChildControl := aChildControl;
  fChildControl.Parent := Self;
  fChildControl.Align := alClient;
  fChildControl.Visible := True;
 end;

constructor TvtPopupWindow.Create(aOwner: TComponent; aChildControlClass : TWinControlClass);
 begin
  Create(aOwner, aChildControlClass.Create(Self));
 end;

procedure TvtPopupWindow.DoOnExecute;
 begin
  inherited;
  Visible:=True;
  fChildControl.SetFocus;
 end;

procedure TvtPopupWindow.DoAfterExecute;
 begin
  inherited;
  fChildControl.Visible := false;
  fChildControl.Parent := nil;
 end;

procedure TvtCustomPopupWindow.CMCancelMode(var Message: TMessage);
begin
  inherited;
  Close;
end;

procedure TAssList.AddItem(aKey:TObject; aAction:TObject; aOnExecute:TNotifyEvent);
Var
  lData:TKeyData;
begin
  lData:=TKeyData.Create;
  try
   lData.Key:=aKey;
   lData.Action:=aAction;
   lData.OnExecute:=aOnExecute;
   Add(lData);
  finally
   l3Free(lData);
  end;//try..finally
end;


function TAssList.ContainsAction(aAction: TObject): boolean;
Var
  i:Integer;
begin
  Result:=false;
  for i:=0 to Count-1 do begin
    if TKeyData(Items[I]).Action = aAction then begin
      Result:=true;
      break;
    end;
  end;
end;

function TAssList.ContainsControl(aKey: TObject): boolean;
Var
  i:Integer;
begin
  Result:=false;
  for i:=0 to Count-1 do begin
    if TKeyData(Items[I]).Key = aKey then begin
      Result:=true;
      break;
    end;
  end;
end;

function TAssList.GetActionByControl(aKey: TObject): TCustomAction;
Var
  i:Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if TKeyData(Items[I]).Key = aKey then begin
      Result:=TCustomAction(TKeyData(Items[I]).Action);
      break;
    end;
  end;
end;

function TAssList.GetOnExecuteByAction(aAction: TObject): TNotifyEvent;
Var
  i:Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if TKeyData(Items[I]).Action = aAction then begin
      Result:=TKeyData(Items[I]).OnExecute;
      break;
    end;
  end;
end;

function TAssList.GetOnExecuteByControl(aKey: TObject): TNotifyEvent;
Var
  i:Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do begin
    if TKeyData(Items[I]).Key = aKey then begin
      Result:=TKeyData(Items[I]).OnExecute;
      break;
    end;
  end;
end;


 procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorRect : TRect; aAdjustCorner : TAdjustCorner = acBottomLeft);
  var
   ptUpper, ptLower: TPoint;
   ptLeftTop: TPoint;
   lDeskRect : TRect;                      //Left, Top, Right, Bottom:
  begin
   ptUpper.X := aAnchorRect.Left;
   ptUpper.Y := aAnchorRect.Top;
   ptLower.X := aAnchorRect.Right;
   ptLower.Y := aAnchorRect.Bottom;

   lDeskRect := Screen.DeskTopRect;

   Case aAdjustCorner of
    acBottomLeft  :
     begin
      if ptUpper.X + 1 + aAdjustCtrl.Width > lDeskRect.Right
       then ptLeftTop.X := lDeskRect.Right - aAdjustCtrl.Width - 1
       else ptLeftTop.X := ptUpper.X + 1;

      if ptLower.Y + 1 + aAdjustCtrl.Height > lDeskRect.Bottom
       then ptLeftTop.Y := ptUpper.Y - aAdjustCtrl.Height
       else ptLeftTop.Y := ptLower.Y + 1;
     end;

    acBottomRight :
     begin
      if ptLower.X - 1 - aAdjustCtrl.Width < lDeskRect.Left
       then ptLeftTop.X := lDeskRect.Left
       else ptLeftTop.X := ptLower.X - 1 - aAdjustCtrl.Width;

      if ptLower.Y + 1 + aAdjustCtrl.Height > lDeskRect.Bottom
       then ptLeftTop.Y := ptUpper.Y - aAdjustCtrl.Height
       else ptLeftTop.Y := ptLower.Y + 1;
     end;
   end;

   //if aAdjustCtrl.Parent <> Nil
   // then ptLeftTop := aAdjustCtrl.Parent.ScreenToClient(ptLeftTop);

   With aAdjustCtrl do
    begin
     aAdjustCtrl.Left := ptLeftTop.X;
     aAdjustCtrl.Top  := ptLeftTop.Y;

     {дальше правильнее использовать Rect от текущего монитора}
     if Left < lDeskRect.Left then Left := lDeskRect.Left;
     if Top < 0 then Top := 0;
     if Width > lDeskRect.Right - lDeskRect.Left - Left then
      Width := lDeskRect.Right - lDeskRect.Left - Left;
     if Height > lDeskRect.Bottom - Top then
      Height := lDeskRect.Right - Top;

     {if Left < 0 then Left:=0;
     if Width > Parent.ClientWidth - Left then Width := Parent.ClientWidth - Left;
     if Top < 0 then Top:=0;
     if Height > Parent.ClientHeight - Top then Height := Parent.ClientHeight - Top;
     }
    end;
  end;

procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorPoint : TPoint;
                                 aAdjustCorner : TAdjustCorner = acBottomLeft);
 var
  lRect : TRect;
 begin
  lRect.TopLeft := aAnchorPoint;
  lRect.BottomRight := aAnchorPoint;
  AdjustCtrl(aAdjustCtrl, lRect, aAdjustCorner);
 end;

procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorCtrl : TControl;
                                 aAdjustCorner : TAdjustCorner = acBottomLeft);
 var
  lRect : TRect;
 begin
  lRect.TopLeft := aAnchorCtrl.ClientToScreen(Point(0,0));
  lRect.BottomRight := aAnchorCtrl.ClientToScreen(
                                 Point(aAnchorCtrl.Width, aAnchorCtrl.Height));
  AdjustCtrl(aAdjustCtrl, lRect, aAdjustCorner);
 end;


function TvtPopupWindow.getChildControls(Index: Integer): TControl;
begin
 if Index = 0 then
  Result := fChildControl
 else
  Result := fChildControl.Controls[Index-1];
end;

function TvtPopupWindow.getChildControlCount: Integer;
begin
 Result :=fChildControl.ControlCount+1 ;
end;

function TvtCustomPopupWindow.getChildControlCount: Integer;
begin
 Result := ControlCount;
end;

function TvtCustomPopupWindow.getChildControls(Index: Integer): TControl;
begin
 Result := Controls[Index];
end;

function TvtCustomPopupWindow.IsChildControl(aHandle: HWND): boolean;
Var
 l_Index: Integer;
 l_WinControl : TWinControl;
begin
 Result := false;
 for l_Index := 0 to ChildControlCount - 1 do
  if ChildControls[l_Index] is TWinControl then
  begin
   l_WinControl := ChildControls[l_Index] as TWinControl;
   if (l_WinControl.Handle = aHandle) or
      (SendMessage(l_WinControl.Handle, CM_TBCHECKCONTROL, WParam(aHandle), 0) > 0) then
   begin
    Result := true;
    break;
   end
  end;
end;

end.




