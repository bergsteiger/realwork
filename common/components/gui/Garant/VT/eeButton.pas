unit eeButton;

{$I vtDefine.inc}

interface

uses
  Windows,
  Messages,
  Graphics,
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  Buttons;

type

  TeeButton = class(TButton)
  private
    f_PrevCharCode : Word;
  private
    procedure WMChar(Var Msg: TWMChar); message WM_CHAR;
    procedure WMKeyDown(Var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner : TComponent);
      override;
  end;

(*  TeeBitBtn = class(TBitBtn)
  private
    f_PrevCharCode : Word;
  private
    procedure WMChar(Var Msg: TWMChar); message WM_CHAR;
    procedure WMKeyDown(Var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner : TComponent);
      override;
  end;

  TeeRadioButton = class(TRadioButton)
  private
    f_PrevCharCode : Word;
  private
    procedure WMChar(Var Msg: TWMChar); message WM_CHAR;
    procedure WMKeyDown(Var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure WMEraseBkgnd(var Message : TWMEraseBkgnd); message WM_ERASEBKGND;
  end;

  TeeRadioButton1 = class(TeeRadioButton)
  private
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
      procedure WMLButtonDown(var Msg : TMessage{TWMLButtonDown});
        message WM_LBUTTONDOWN;
        {-}
  protected
    function CanFocus: Boolean; override;
    procedure WndProc(var Message: TMessage); override;
  end;//TeeRadioButton1*)

procedure Register;

implementation

{$IfDef eeNeedOvc}
uses
  OvcBase,
  OvcCmd,
  OvcConst;
{$EndIf eeNeedOvc}


procedure Register;
begin
 RegisterComponents('Everest', [TeeButton]);
end;

function IsHandledShortcut(var Msg: TWMKeyDown; var aCharCode: Word): Boolean;
{$IfDef eeNeedOvc}
var
 l_Controller : TOvcController;
{$EndIf eeNeedOvc}
begin
 aCharCode := 0;
 Result := false;
 {$IfDef eeNeedOvc}
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    aCharCode := Msg.CharCode;
    Result := true;
   end;
 {$EndIf eeNeedOvc}
end;

constructor TeeButton.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 DoubleBuffered := True;
end;

procedure TeeButton.WMChar(Var Msg: TWMChar);
begin
 if (f_PrevCharCode <> 0) and (Msg.CharCode = f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeButton.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
 Msg.Result := Integer(True);
end;

procedure TeeButton.WMKeyDown(Var Msg: TWMKeyDown);
begin
 if IsHandledShortcut(Msg, f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeButton.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg, f_PrevCharCode) then
   Exit;
 inherited;
end;

(*constructor TeeBitBtn.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
end;

procedure TeeBitBtn.WMChar(Var Msg: TWMChar);
begin
 if (f_PrevCharCode <> 0) and (Msg.CharCode = f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeBitBtn.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
 Msg.Result := Integer(True);
end;

procedure TeeBitBtn.WMKeyDown(Var Msg: TWMKeyDown);
begin
 if IsHandledShortcut(Msg, f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeBitBtn.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg, f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeRadioButton.WMChar(Var Msg: TWMChar);
begin
 if (f_PrevCharCode <> 0) and (Msg.CharCode = f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeRadioButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
 Message.Result := Integer(True);
end;

procedure TeeRadioButton.WMKeyDown(Var Msg: TWMKeyDown);
begin
 if IsHandledShortcut(Msg, f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeRadioButton.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg, f_PrevCharCode) then
   Exit;
 inherited;
end;

// start class TeeRadioButton1

procedure TeeRadioButton1.WMMouseActivate(var Message: TMessage);
begin
 if not (csDesigning in ComponentState) then
  Message.Result := MA_NOACTIVATE
 else
  inherited; 
end;

procedure TeeRadioButton1.WMLButtonDown(var Msg : TMessage{TWMLButtonDown});
  //message WM_LBUTTONDOWN;
  {-}
begin
 if not (csDesigning in ComponentState) then
  Checked := true
 else
  inherited;
end;

function TeeRadioButton1.CanFocus: Boolean;
begin
 if not (csDesigning in ComponentState) then
  Result := false
 else
  Result := inherited CanFocus;
end;

procedure TeeRadioButton1.WndProc(var Message: TMessage);
begin
 case Message.Msg of
   WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
     if not (csDesigning in ComponentState) then
     begin
      Checked := true;
      Exit;
     end;//not (csDesigning in ComponentState)
 end;//case Message.Msg
 inherited;
end;*)

end.
